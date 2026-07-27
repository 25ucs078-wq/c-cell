import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseData {
  final String name;
  final double credits;
  CourseData({required this.name, required this.credits});
}

class CustomCourseRow {
  final TextEditingController nameController;
  final TextEditingController creditsController;
  String selectedGrade;

  CustomCourseRow({
    required this.nameController,
    required this.creditsController,
    required this.selectedGrade,
  });
}

class SpiCalculatorPage extends StatefulWidget {
  const SpiCalculatorPage({super.key});

  @override
  State<SpiCalculatorPage> createState() => _SpiCalculatorPageState();
}

class _SpiCalculatorPageState extends State<SpiCalculatorPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _resultKey = GlobalKey();

  String? _selectedBranch;
  int? _selectedSem;

  // Track regular course states: map of index to selected grade
  final Map<int, String> _regularCourseGrades = {};
  // Track whether regular courses have been customized as S/F
  final Map<int, bool> _regularCourseIsSF = {};
  // Track S/F course values ('S' or 'F')
  final Map<int, String> _sfCourseValues = {};

  // For Sem 8 custom courses
  final List<CustomCourseRow> _customCourses = [];

  // Calculation Results
  double? _calculatedSgpa;
  double? _earnedCredits;
  double? _semesterCredits;
  List<Map<String, dynamic>> _breakdownRows = [];
  String? _statusText;

  final Map<String, double> _gradePoints = {
    'A': 10,
    'AB': 9,
    'B': 8,
    'BC': 7,
    'C': 6,
    'CD': 5,
    'D': 4,
    'F': 0,
  };

  final List<String> _grades = ['A', 'AB', 'B', 'BC', 'C', 'CD', 'D', 'F'];

  final List<Map<String, dynamic>> _branches = [
    {
      'code': 'CSE',
      'label': 'Computer Science & Engineering',
      'disabled': false,
      'gradient': [Color(0xff1e88e5), Color(0xff1565c0)],
      'icon': Icons.code,
    },
    {
      'code': 'ME',
      'label': 'Mechanical Engineering',
      'disabled': false,
      'gradient': [Color(0xffe64a19), Color(0xffbf360c)],
      'icon': Icons.build,
    },
    {
      'code': 'ECE',
      'label': 'Electronics & Communication Eng.',
      'disabled': false,
      'gradient': [Color(0xff2e7d32), Color(0xff1b5e20)],
      'icon': Icons.settings_input_component,
    },
    {
      'code': 'CCE',
      'label': 'Communication & Computer Eng.',
      'disabled': false,
      'gradient': [Color(0xfffbc02d), Color(0xfff57f17)],
      'icon': Icons.router,
    },
    {
      'code': 'AIDS',
      'label': 'Artificial Intelligence & Data Science',
      'disabled': false,
      'gradient': [Color(0xff5e35b1), Color(0xff4527a0)],
      'icon': Icons.storage,
    },
    {
      'code': 'AI',
      'label': 'Artificial Intelligence',
      'disabled': false,
      'gradient': [Color(0xff00acc1), Color(0xff00838f)],
      'icon': Icons.psychology,
    },
  ];

  final Map<String, Map<int, dynamic>> _curriculum = {
    'CSE': {
      1: [
        CourseData(name: 'Classical Physics', credits: 4),
        CourseData(name: 'Calculus and ODE', credits: 4),
        CourseData(name: 'Basic Electronics', credits: 4),
        CourseData(name: 'Basic Electronics Lab', credits: 1.5),
        CourseData(name: 'Programming for Problem Solving', credits: 4.5),
        CourseData(name: 'Technical Communication in English', credits: 3),
        CourseData(name: 'Indian Knowledge System', credits: 1),
      ],
      2: [
        CourseData(name: 'Human Values and Ethics', credits: 3),
        CourseData(name: 'Environmental Science', credits: 1),
        CourseData(name: 'Linear Algebra and Complex Analysis', credits: 4),
        CourseData(name: 'Data Structures and Algorithms', credits: 4.5),
        CourseData(name: 'UG Physics Laboratory', credits: 1.5),
        CourseData(name: 'Introduction to Scripting Languages', credits: 1),
        CourseData(name: 'Digital Systems', credits: 4),
        CourseData(name: 'Discrete Mathematics', credits: 3),
      ],
      3: [
        CourseData(name: 'Probability and Statistics', credits: 4),
        CourseData(name: 'Signals and Systems', credits: 3),
        CourseData(name: 'Computer Organization and Architecture', credits: 4),
        CourseData(name: 'Database Management Systems', credits: 4),
        CourseData(name: 'Object Oriented Programming', credits: 4),
        CourseData(name: 'Design and Analysis of Algorithms', credits: 4),
      ],
      4: [
        CourseData(name: 'Constitutional Studies', credits: 1),
        CourseData(name: 'Principles of Management', credits: 3),
        CourseData(name: 'Web Programming', credits: 1),
        CourseData(name: 'Theory of Computation', credits: 3),
        CourseData(name: 'Operating Systems', credits: 4),
        CourseData(name: 'Computer Networks', credits: 4),
        CourseData(name: 'Data Science', credits: 3),
        CourseData(name: 'Program Elective 1', credits: 3),
      ],
      5: [
        CourseData(name: 'Summer Internship / Project', credits: 4),
        CourseData(name: 'Psychology Technology and Society', credits: 3),
        CourseData(name: 'Software Engineering', credits: 3),
        CourseData(name: 'Artificial Intelligence', credits: 4),
        CourseData(name: 'Computer System Security', credits: 4),
        CourseData(name: 'Software Development Lab', credits: 1),
        CourseData(name: 'Program Elective 2', credits: 3),
      ],
      6: [
        CourseData(name: 'BTP', credits: 4),
        CourseData(name: 'Introduction to Economics', credits: 3),
        CourseData(name: 'Seminar and Presentation Skills', credits: 1),
        CourseData(name: 'Numerical Analysis and Scientific Computing', credits: 4),
        CourseData(name: 'Program Elective 3', credits: 3),
        CourseData(name: 'Program Elective 4', credits: 3),
        CourseData(name: 'Open Elective 1', credits: 3),
      ],
      7: [
        CourseData(name: 'BTP', credits: 4),
        CourseData(name: 'Program Elective 5', credits: 3),
        CourseData(name: 'Program Elective 6', credits: 3),
        CourseData(name: 'Open Elective 2', credits: 3),
        CourseData(name: 'Open Elective 3', credits: 3),
      ],
      8: 'FLEXIBLE',
    },
    'ME': {
      1: [
        CourseData(name: 'Classical Physics', credits: 4),
        CourseData(name: 'Calculus and ODE', credits: 4),
        CourseData(name: 'Basic Electronics', credits: 4),
        CourseData(name: 'Basic Electronics Lab', credits: 1.5),
        CourseData(name: 'Programming for Problem Solving', credits: 4.5),
        CourseData(name: 'Technical Communication in English', credits: 3),
        CourseData(name: 'Indian Knowledge System', credits: 1),
      ],
      2: [
        CourseData(name: 'Human Values and Ethics', credits: 3),
        CourseData(name: 'Environmental Science', credits: 1),
        CourseData(name: 'Linear Algebra and Complex Analysis', credits: 4),
        CourseData(name: 'Data Structures and Algorithms', credits: 4.5),
        CourseData(name: 'UG Physics Lab', credits: 1.5),
        CourseData(name: 'Introduction to Scripting Languages', credits: 1),
        CourseData(name: 'Introduction to Mechanical Engineering', credits: 1),
        CourseData(name: 'Engineering Drawing and Graphics', credits: 1.5),
        CourseData(name: 'Workshop Practices', credits: 1.5),
        CourseData(name: 'Engineering Physical Metallurgy', credits: 3),
      ],
      3: [
        CourseData(name: 'Probability and Statistics', credits: 4),
        CourseData(name: 'Mechanics of Solids', credits: 4),
        CourseData(name: 'Rigid Body Dynamics', credits: 2),
        CourseData(name: 'Engineering Thermodynamics', credits: 4),
        CourseData(name: 'Welding and Casting', credits: 4),
        CourseData(name: 'Electrical Technology', credits: 3),
      ],
      4: [
        CourseData(name: 'Constitutional Studies', credits: 1),
        CourseData(name: 'Design of Machine Elements', credits: 3),
        CourseData(name: 'Fluid Mechanics and Machinery', credits: 5),
        CourseData(name: 'Machining and Metal Forming', credits: 4),
        CourseData(name: 'Mechanisms and Machines', credits: 3),
        CourseData(name: 'Introduction to Computational Methods', credits: 1),
        CourseData(name: 'Industrial Measurements', credits: 4),
      ],
      5: [
        CourseData(name: 'Summer Internship / Project', credits: 4),
        CourseData(name: 'Heat Transfer', credits: 4),
        CourseData(name: 'Design of Transmission Elements', credits: 4),
        CourseData(name: 'Digital Manufacturing', credits: 4),
        CourseData(name: 'Robotics and Control', credits: 3),
        CourseData(name: 'Mechatronics and IoT', credits: 3),
      ],
      6: [
        CourseData(name: 'BTP', credits: 4),
        CourseData(name: 'Introduction to Economics', credits: 3),
        CourseData(name: 'Seminar and Presentation Skills', credits: 1),
        CourseData(name: 'IC Engines', credits: 4),
        CourseData(name: 'Finite Element Methods', credits: 3),
        CourseData(name: 'Industrial Engineering and Management', credits: 3),
        CourseData(name: 'Program Elective 1', credits: 3),
      ],
      7: [
        CourseData(name: 'BTP', credits: 4),
        CourseData(name: 'Open Elective 1', credits: 3),
        CourseData(name: 'Program Elective 2', credits: 3),
        CourseData(name: 'Program Elective 3', credits: 3),
        CourseData(name: 'Program Elective 4', credits: 3),
        CourseData(name: 'Open Elective 2', credits: 3),
      ],
      8: 'FLEXIBLE',
    },
    'ECE': {
      1: [
        CourseData(name: 'Classical Physics', credits: 4),
        CourseData(name: 'Calculus and ODE', credits: 4),
        CourseData(name: 'Basic Electronics', credits: 4),
        CourseData(name: 'Basic Electronics Lab', credits: 1.5),
        CourseData(name: 'Programming for Problem Solving', credits: 4.5),
        CourseData(name: 'Technical Communication in English', credits: 3),
        CourseData(name: 'Indian Knowledge System', credits: 1),
      ],
      2: [
        CourseData(name: 'Human Values and Ethics', credits: 3),
        CourseData(name: 'Environmental Science', credits: 1),
        CourseData(name: 'Linear Algebra and Complex Analysis', credits: 4),
        CourseData(name: 'Data Structures and Algorithms', credits: 4.5),
        CourseData(name: 'UG Physics Laboratory', credits: 1.5),
        CourseData(name: 'Introduction to Scripting Languages', credits: 1),
        CourseData(name: 'Semiconductor Devices and Circuits', credits: 3),
        CourseData(name: 'Analog Electronics', credits: 3),
        CourseData(name: 'Analog Electronics Lab', credits: 1.5),
      ],
      3: [
        CourseData(name: 'Probability and Statistics', credits: 4),
        CourseData(name: 'Signals and Systems', credits: 3),
        CourseData(name: 'Signals and Systems Lab', credits: 1.5),
        CourseData(name: 'Digital Circuit and Systems', credits: 3),
        CourseData(name: 'Digital Circuit and Systems Lab', credits: 1.5),
        CourseData(name: 'Engineering Electromagnetics', credits: 3),
        CourseData(name: 'Microprocessor and Microcontroller', credits: 3),
        CourseData(name: 'Microprocessor and Microcontroller Lab', credits: 1.5),
        CourseData(name: 'Network Analysis and Synthesis', credits: 3),
      ],
      4: [
        CourseData(name: 'Constitutional Studies', credits: 1),
        CourseData(name: 'Analog and Digital Communication', credits: 3),
        CourseData(name: 'Analog and Digital Communication Lab', credits: 1.5),
        CourseData(name: 'Fundamentals of VLSI', credits: 3),
        CourseData(name: 'VLSI Lab', credits: 1.5),
        CourseData(name: 'Microwave Engineering', credits: 3),
        CourseData(name: 'Microwave Engineering Lab', credits: 1.5),
        CourseData(name: 'Design and Project Lab', credits: 1.5),
        CourseData(name: 'Introduction to AI and ML', credits: 4),
      ],
      5: [
        CourseData(name: 'Summer Internship / Project', credits: 4),
        CourseData(name: 'Psychology Technology and Society', credits: 3),
        CourseData(name: 'Wireless Communication', credits: 3),
        CourseData(name: 'Wireless Communication Lab', credits: 1.5),
        CourseData(name: 'Control System Engineering', credits: 4),
        CourseData(name: 'Digital Signal Processing', credits: 3),
        CourseData(name: 'Digital Signal Processing Lab', credits: 1.5),
        CourseData(name: 'Program Elective 1', credits: 3),
      ],
      6: [
        CourseData(name: 'BTP', credits: 4),
        CourseData(name: 'Introduction to Economics', credits: 3),
        CourseData(name: 'Seminar and Presentation Skills', credits: 1),
        CourseData(name: '5G Wireless Systems and Beyond', credits: 3),
        CourseData(name: 'Computer Communication Networks', credits: 4),
        CourseData(name: 'Program Elective 2', credits: 3),
        CourseData(name: 'Program Elective 3', credits: 3),
        CourseData(name: 'Open Elective 1', credits: 3),
      ],
      7: [
        CourseData(name: 'BTP', credits: 4),
        CourseData(name: 'Program Elective 4', credits: 3),
        CourseData(name: 'Program Elective 5', credits: 3),
        CourseData(name: 'Open Elective 2', credits: 3),
        CourseData(name: 'Open Elective 3', credits: 3),
      ],
      8: 'FLEXIBLE',
    },
    'CCE': {
      1: [
        CourseData(name: 'Classical Physics', credits: 4),
        CourseData(name: 'Calculus and ODE', credits: 4),
        CourseData(name: 'Basic Electronics', credits: 4),
        CourseData(name: 'Basic Electronics Lab', credits: 1.5),
        CourseData(name: 'Programming for Problem Solving', credits: 4.5),
        CourseData(name: 'Technical Communication in English', credits: 3),
        CourseData(name: 'Indian Knowledge System', credits: 1),
      ],
      2: [
        CourseData(name: 'Human Values and Ethics', credits: 3),
        CourseData(name: 'Environmental Science', credits: 1),
        CourseData(name: 'Linear Algebra and Complex Analysis', credits: 4),
        CourseData(name: 'Data Structures and Algorithms', credits: 4.5),
        CourseData(name: 'UG Physics Laboratory', credits: 1.5),
        CourseData(name: 'Introduction to Scripting Languages', credits: 1),
        CourseData(name: 'Digital Systems', credits: 4),
        CourseData(name: 'Discrete Mathematics', credits: 3),
      ],
      3: [
        CourseData(name: 'Probability and Statistics', credits: 4),
        CourseData(name: 'Design and Analysis of Algorithms', credits: 4),
        CourseData(name: 'Signals and Systems', credits: 4),
        CourseData(name: 'Computer Organization and Architecture', credits: 3),
        CourseData(name: 'Database Management Systems', credits: 4),
        CourseData(name: 'Object Oriented Programming', credits: 4),
      ],
      4: [
        CourseData(name: 'Constitutional Studies', credits: 1),
        CourseData(name: 'Web Programming', credits: 1),
        CourseData(name: 'Operating Systems', credits: 4),
        CourseData(name: 'Computer Communication Networks', credits: 4),
        CourseData(name: 'Analog and Digital Communication', credits: 3),
        CourseData(name: 'Analog and Digital Communication Lab', credits: 1.5),
        CourseData(name: 'Embedded Systems and IoT', credits: 4.5),
        CourseData(name: 'Program Elective 1', credits: 3),
      ],
      5: [
        CourseData(name: 'Summer Internship / Project', credits: 4),
        CourseData(name: 'Psychology Technology and Society', credits: 3),
        CourseData(name: 'Wireless Communication', credits: 3),
        CourseData(name: 'Wireless Communication Lab', credits: 1.5),
        CourseData(name: 'Software Engineering', credits: 3),
        CourseData(name: 'Digital Signal Processing', credits: 3),
        CourseData(name: 'Digital Signal Processing Lab', credits: 1.5),
        CourseData(name: 'Software Development Lab', credits: 1),
        CourseData(name: 'Program Elective 2', credits: 3),
      ],
      6: [
        CourseData(name: 'BTP', credits: 4),
        CourseData(name: 'Introduction to Economics', credits: 3),
        CourseData(name: 'Seminar and Presentation Skills', credits: 1),
        CourseData(name: 'Information Theory and Coding', credits: 3),
        CourseData(name: 'Control System Engineering', credits: 3),
        CourseData(name: 'Introduction to AI and ML', credits: 4),
        CourseData(name: 'Program Elective 3', credits: 3),
      ],
      7: [
        CourseData(name: 'BTP', credits: 4),
        CourseData(name: 'Program Elective 4', credits: 3),
        CourseData(name: 'Program Elective 5', credits: 3),
        CourseData(name: 'Open Elective 1', credits: 3),
        CourseData(name: 'Open Elective 2', credits: 3),
      ],
      8: 'FLEXIBLE',
    },
    'AIDS': {
      1: [
        CourseData(name: 'Classical Physics', credits: 4),
        CourseData(name: 'Calculus and ODE', credits: 4),
        CourseData(name: 'Basic Electronics', credits: 4),
        CourseData(name: 'Basic Electronics Lab', credits: 1.5),
        CourseData(name: 'Programming for Problem Solving', credits: 4.5),
        CourseData(name: 'Technical Communication in English', credits: 3),
        CourseData(name: 'Indian Knowledge System', credits: 1),
      ],
      2: [
        CourseData(name: 'Human Values and Ethics', credits: 3),
        CourseData(name: 'Environmental Science', credits: 1),
        CourseData(name: 'Linear Algebra and Complex Analysis', credits: 4),
        CourseData(name: 'Data Structures and Algorithms', credits: 4.5),
        CourseData(name: 'UG Physics Laboratory', credits: 1.5),
        CourseData(name: 'Introduction to AI and Data Science', credits: 4),
        CourseData(name: 'Discrete Mathematics', credits: 3),
      ],
      3: [
        CourseData(name: 'Probability and Statistics', credits: 4),
        CourseData(name: 'Database Management Systems', credits: 3),
        CourseData(name: 'Object Oriented Programming', credits: 3),
        CourseData(name: 'Design and Analysis of Algorithms', credits: 4),
        CourseData(name: 'Computer System Design', credits: 4),
        CourseData(name: 'Optimization and Numerical Methods', credits: 3),
        CourseData(name: 'Project Lab', credits: 1),
      ],
      4: [
        CourseData(name: 'Constitutional Studies', credits: 1),
        CourseData(name: 'Introduction to Statistical Machine Learning', credits: 4),
        CourseData(name: 'Computer Networks', credits: 4),
        CourseData(name: 'Information Coding and Theory', credits: 3),
        CourseData(name: 'Computational Theory and Language Processing', credits: 3),
        CourseData(name: 'Game Theory', credits: 3),
        CourseData(name: 'Program Elective 1', credits: 3),
      ],
      5: [
        CourseData(name: 'Summer Internship / Project', credits: 4),
        CourseData(name: 'Psychology Technology and Society', credits: 3),
        CourseData(name: 'Deep Learning', credits: 4),
        CourseData(name: 'Artificial Intelligence', credits: 4),
        CourseData(name: 'Internet of Things', credits: 4),
        CourseData(name: 'Program Elective 2', credits: 3),
      ],
      6: [
        CourseData(name: 'BTP', credits: 4),
        CourseData(name: 'Introduction to Economics', credits: 3),
        CourseData(name: 'Disaster Management', credits: 2),
        CourseData(name: 'Ethics and Responsible AI', credits: 3),
        CourseData(name: 'Large Language Models', credits: 4),
        CourseData(name: 'Reinforcement Learning', credits: 3),
        CourseData(name: 'Program Elective 3', credits: 3),
      ],
      7: [
        CourseData(name: 'BTP', credits: 4),
        CourseData(name: 'Program Elective 4', credits: 3),
        CourseData(name: 'Program Elective 5', credits: 3),
        CourseData(name: 'Program Elective 6', credits: 3),
        CourseData(name: 'Open Elective 1', credits: 3),
        CourseData(name: 'Open Elective 2', credits: 3),
      ],
      8: 'FLEXIBLE',
    },
    'AI': {
      1: [
        CourseData(name: 'Classical Physics', credits: 4),
        CourseData(name: 'Calculus and ODE', credits: 4),
        CourseData(name: 'Basic Electronics', credits: 4),
        CourseData(name: 'Basic Electronics Lab', credits: 1.5),
        CourseData(name: 'Programming for Problem Solving', credits: 4.5),
        CourseData(name: 'Technical Communication in English', credits: 3),
        CourseData(name: 'Indian Knowledge System', credits: 1),
      ],
      2: [
        CourseData(name: 'Human Values and Ethics', credits: 3),
        CourseData(name: 'Environmental Science', credits: 1),
        CourseData(name: 'Linear Algebra and Complex Analysis', credits: 4),
        CourseData(name: 'Data Structures and Algorithms', credits: 4.5),
        CourseData(name: 'UG Physics Laboratory', credits: 1.5),
        CourseData(name: 'Computer System Design', credits: 3),
        CourseData(name: 'Discrete Mathematics', credits: 3),
        CourseData(name: 'Introduction to Scripting Language', credits: 1),
      ],
      3: [
        CourseData(name: 'Probability and Statistics', credits: 4),
        CourseData(name: 'Introduction to AI and Data Science', credits: 3),
        CourseData(name: 'Optimization and Numerical Methods', credits: 4),
        CourseData(name: 'Database Management Systems', credits: 4),
        CourseData(name: 'Object Oriented Programming', credits: 4),
        CourseData(name: 'Design and Analysis of Algorithms', credits: 4),
      ],
      4: [
        CourseData(name: 'Constitutional Studies', credits: 1),
        CourseData(name: 'Introduction to Statistical Machine Learning', credits: 4),
        CourseData(name: 'Computational Thinking and Neuroscience', credits: 3),
        CourseData(name: 'Big Data Systems', credits: 4),
        CourseData(name: 'Data Wrangling and Visualization', credits: 1),
        CourseData(name: 'Data Mining', credits: 3),
        CourseData(name: 'Program Elective 1', credits: 3),
      ],
      5: [
        CourseData(name: 'Summer Internship / Project', credits: 4),
        CourseData(name: 'Psychology Technology and Society', credits: 3),
        CourseData(name: 'Deep Learning', credits: 4),
        CourseData(name: 'Artificial Intelligence', credits: 4),
        CourseData(name: 'Time Series Analysis and Forecasting', credits: 4),
        CourseData(name: 'Program Elective 2', credits: 3),
      ],
      6: [
        CourseData(name: 'BTP', credits: 4),
        CourseData(name: 'Introduction to Economics', credits: 3),
        CourseData(name: 'Disaster Management', credits: 2),
        CourseData(name: 'Natural Language Processing', credits: 3),
        CourseData(name: 'Computer Vision', credits: 3),
        CourseData(name: 'Soft Computing', credits: 3),
        CourseData(name: 'Program Elective 3', credits: 4),
      ],
      7: [
        CourseData(name: 'BTP', credits: 4),
        CourseData(name: 'Program Elective 4', credits: 3),
        CourseData(name: 'Program Elective 5', credits: 3),
        CourseData(name: 'Program Elective 6', credits: 3),
        CourseData(name: 'Open Elective 1', credits: 3),
        CourseData(name: 'Open Elective 2', credits: 3),
      ],
      8: 'FLEXIBLE',
    },
  };

  bool isSFCourse(String branch, int sem, String name) {
    if (sem == 1 && name == 'Indian Knowledge System') return true;
    if (sem == 2 && name == 'Environmental Science') return true;
    if (branch == 'AIDS' && sem == 6 && name == 'Disaster Management') return true;
    if (branch == 'AI' && sem == 6 && name == 'Disaster Management') return true;
    return false;
  }

  void _selectBranch(String code) {
    setState(() {
      _selectedBranch = code;
      _selectedSem = null;
      _calculatedSgpa = null;
      _regularCourseGrades.clear();
      _regularCourseIsSF.clear();
      _sfCourseValues.clear();
      _customCourses.clear();
    });
  }

  void _selectSem(int sem) {
    setState(() {
      _selectedSem = sem;
      _calculatedSgpa = null;
      _regularCourseGrades.clear();
      _regularCourseIsSF.clear();
      _sfCourseValues.clear();
      _customCourses.clear();

      final branchData = _curriculum[_selectedBranch];
      if (branchData != null) {
        final semData = branchData[sem];
        if (semData is List<CourseData>) {
          for (int i = 0; i < semData.length; i++) {
            _regularCourseGrades[i] = 'A';
            _regularCourseIsSF[i] = isSFCourse(_selectedBranch!, sem, semData[i].name);
            _sfCourseValues[i] = 'S';
          }
        } else if (semData == 'FLEXIBLE') {
          _addCustomRow();
        }
      }
    });
  }

  void _addCustomRow() {
    setState(() {
      _customCourses.add(
        CustomCourseRow(
          nameController: TextEditingController(),
          creditsController: TextEditingController(),
          selectedGrade: 'A',
        ),
      );
    });
  }

  void _removeCustomRow(int index) {
    setState(() {
      _customCourses[index].nameController.dispose();
      _customCourses[index].creditsController.dispose();
      _customCourses.removeAt(index);
    });
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: const Color(0xffef5350)),
        ),
        backgroundColor: const Color(0xff140808),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _calculate() {
    if (_selectedBranch == null || _selectedSem == null) return;

    final branchData = _curriculum[_selectedBranch!];
    if (branchData == null) return;

    final semData = branchData[_selectedSem!];
    List<Map<String, dynamic>> tempRows = [];

    if (semData == 'FLEXIBLE') {
      if (_customCourses.isEmpty) {
        _showToast('ERROR: NO COURSE ROWS FOUND. ADD ROWS FIRST.');
        return;
      }

      for (int i = 0; i < _customCourses.length; i++) {
        final row = _customCourses[i];
        final name = row.nameController.text.trim();
        final creditsText = row.creditsController.text.trim();

        if (name.isEmpty) {
          _showToast('ERROR: COURSE NAME MISSING IN ROW ${i + 1}');
          return;
        }

        final credits = double.tryParse(creditsText);
        if (credits == null || credits <= 0) {
          _showToast('ERROR: INVALID CREDITS IN ROW ${i + 1}');
          return;
        }

        tempRows.add({
          'name': name,
          'credits': credits,
          'grade': row.selectedGrade,
          'isSF': false,
        });
      }
    } else if (semData is List<CourseData>) {
      for (int i = 0; i < semData.length; i++) {
        final course = semData[i];
        final isSF = _regularCourseIsSF[i] ?? false;

        if (isSF) {
          final val = _sfCourseValues[i] ?? 'S';
          tempRows.add({
            'name': course.name,
            'credits': course.credits,
            'grade': val,
            'isSF': true,
          });
        } else {
          final grade = _regularCourseGrades[i] ?? 'A';
          tempRows.add({
            'name': course.name,
            'credits': course.credits,
            'grade': grade,
            'isSF': false,
          });
        }
      }
    }

    double totalWeighted = 0;
    double sgpaCredits = 0;
    double earnedCredits = 0;
    double semesterCredits = 0;

    for (var r in tempRows) {
      final double creds = r['credits'];
      semesterCredits += creds;

      if (r['isSF']) {
        r['gradePoints'] = null;
        r['weightedScore'] = null;
        if (r['grade'] == 'S') {
          earnedCredits += creds;
        }
      } else {
        final String g = r['grade'];
        final double gp = _gradePoints[g]!;
        final double wScore = gp * creds;

        r['gradePoints'] = gp;
        r['weightedScore'] = wScore;

        totalWeighted += wScore;
        sgpaCredits += creds;
        earnedCredits += creds;
      }
    }

    final double sgpa = sgpaCredits > 0 ? totalWeighted / sgpaCredits : 0.0;
    final List<Map<String, dynamic>> countedRows = tempRows.where((r) => !r['isSF']).toList();
    final double avgWS = countedRows.isNotEmpty ? totalWeighted / countedRows.length : 0.0;

    for (var r in tempRows) {
      if (!r['isSF']) {
        r['aboveAverage'] = r['weightedScore'] >= avgWS;
      }
    }

    String status;
    if (sgpa >= 9.0) {
      status = 'STATUS: OUTSTANDING';
    } else if (sgpa >= 8.0) {
      status = 'STATUS: EXCELLENT';
    } else if (sgpa >= 7.0) {
      status = 'STATUS: GOOD';
    } else if (sgpa >= 6.0) {
      status = 'STATUS: AVERAGE';
    } else {
      status = 'STATUS: NEEDS IMPROVEMENT';
    }

    setState(() {
      _calculatedSgpa = sgpa;
      _earnedCredits = earnedCredits;
      _semesterCredits = semesterCredits;
      _breakdownRows = tempRows;
      _statusText = status;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_resultKey.currentContext != null) {
        Scrollable.ensureVisible(
          _resultKey.currentContext!,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    for (var row in _customCourses) {
      row.nameController.dispose();
      row.creditsController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 700;

    return Scaffold(
      backgroundColor: const Color(0xff090B18),
      appBar: AppBar(
        backgroundColor: const Color(0xff0F1123),
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        shape: const Border(
          bottom: BorderSide(
            color: Color(0xff1E2243),
            width: 1,
          ),
        ),
        title: Text(
          "SPI Calculator",
          style: GoogleFonts.playfairDisplay(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 850),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // STEP 1: Branch selection
                Text(
                  "01_ SELECT BRANCH",
                  style: GoogleFonts.playfairDisplay(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 14),

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isSmallScreen ? 2 : 4,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: screenWidth < 400 ? 1.15 : (isSmallScreen ? 1.25 : 1.35),
                  ),
                  itemCount: _branches.length,
                  itemBuilder: (context, idx) {
                    final branch = _branches[idx];
                    final bool isDisabled = branch['disabled'];
                    final bool isActive = _selectedBranch == branch['code'];

                    return GestureDetector(
                      onTap: isDisabled ? null : () => _selectBranch(branch['code']),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            colors: isDisabled
                                ? [const Color(0xff14161d), const Color(0xff14161d)]
                                : branch['gradient'],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          border: Border.all(
                            color: isActive
                                ? Colors.white
                                : isDisabled
                                    ? Colors.white.withValues(alpha: 0.05)
                                    : Colors.transparent,
                            width: isActive ? 2.5 : 1,
                          ),
                          boxShadow: isActive
                              ? [
                                  BoxShadow(
                                    color: (branch['gradient'] as List<Color>)[0].withValues(alpha: 0.4),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  )
                                ]
                              : [],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              branch['icon'],
                              color: isDisabled ? Colors.white24 : Colors.white.withValues(alpha: 0.9),
                              size: 24,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      branch['code'].toString().replaceAll('_CS', '').replaceAll('_V', ''),
                                      style: GoogleFonts.poppins(
                                        color: isDisabled ? Colors.white30 : Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    isDisabled ? "[ COMING SOON ]" : branch['label'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      color: isDisabled
                                          ? Colors.white24
                                          : Colors.white.withValues(alpha: 0.7),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),

                // STEP 2: Semester Selection
                if (_selectedBranch != null) ...[
                  Text(
                    "02_ SELECT SEMESTER",
                    style: GoogleFonts.playfairDisplay(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(8, (i) {
                      final sem = i + 1;
                      final isActive = _selectedSem == sem;

                      return GestureDetector(
                        onTap: () => _selectSem(sem),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: isActive
                                ? const LinearGradient(
                                    colors: [Color(0xffff5722), Color(0xffe64a19)],
                                  )
                                : null,
                            color: isActive ? null : const Color(0xff14161d),
                            border: Border.all(
                              color: isActive
                                  ? const Color(0xffff5722)
                                  : Colors.white.withValues(alpha: 0.06),
                            ),
                            boxShadow: isActive
                                ? [
                                    BoxShadow(
                                      color: const Color(0xffff5722).withValues(alpha: 0.3),
                                      blurRadius: 8,
                                    )
                                  ]
                                : [],
                          ),
                          child: Text(
                            "SEM 0$sem",
                            style: GoogleFonts.poppins(
                              color: isActive ? Colors.white : Colors.white70,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 24),
                ],

                // STEP 3: Enter Grades
                if (_selectedBranch != null && _selectedSem != null) ...[
                  Text(
                    "03_ ENTER GRADES",
                    style: GoogleFonts.playfairDisplay(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 14),

                  _buildCoursesWidget(),

                  const SizedBox(height: 24),

                  // Execute Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _calculate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffff5722),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                        shadowColor: const Color(0xffff5722).withValues(alpha: 0.4),
                      ),
                      child: Text(
                        "EXECUTE CALCULATION_",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],

                // RESULT SECTION
                if (_calculatedSgpa != null) ...[
                  Container(
                    key: _resultKey,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xff0F1123),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xff1E2243),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.4),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Result Top
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [
                              Text(
                                "SEMESTER GRADE POINT AVERAGE",
                                style: GoogleFonts.poppins(
                                  color: Colors.white38,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                _calculatedSgpa!.toStringAsFixed(2),
                                style: GoogleFonts.playfairDisplay(
                                  color: const Color(0xffff5722),
                                  fontSize: 70,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                decoration: BoxDecoration(
                                  color: const Color(0xffff5722).withValues(alpha: 0.1),
                                  border: Border.all(
                                    color: const Color(0xffff5722).withValues(alpha: 0.25),
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  _statusText ?? '',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Breakdown Table
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(minWidth: 550),
                            child: Column(
                              children: [
                                // Breakdown Table Header
                                Container(
                                  width: 550,
                                  color: Colors.black12,
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          "COURSE",
                                          style: GoogleFonts.poppins(
                                              color: Colors.white30, fontSize: 10, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "CREDITS",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                              color: Colors.white30, fontSize: 10, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "GRADE",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                              color: Colors.white30, fontSize: 10, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "GRADE PTS",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                              color: Colors.white30, fontSize: 10, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "WTD SCORE",
                                          textAlign: TextAlign.right,
                                          style: GoogleFonts.poppins(
                                              color: Colors.white30, fontSize: 10, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Breakdown Rows
                                SizedBox(
                                  width: 550,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: _breakdownRows.length,
                                    itemBuilder: (context, idx) {
                                      final row = _breakdownRows[idx];
                                      final isSF = row['isSF'];

                                      return Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.white10,
                                              width: 0.5,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                row['name'],
                                                style: GoogleFonts.poppins(
                                                  color: Colors.white.withValues(alpha: 0.9),
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                row['credits'].toString(),
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                  color: isSF ? Colors.white24 : Colors.white70,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                row['grade'],
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                  color: isSF ? Colors.white24 : Colors.white70,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                isSF ? '—' : row['gradePoints'].toString(),
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                  color: isSF ? Colors.white24 : Colors.white70,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                isSF ? 'NOT COUNTED' : (row['weightedScore'] as double).toStringAsFixed(2),
                                                textAlign: TextAlign.right,
                                                style: GoogleFonts.poppins(
                                                  color: isSF
                                                      ? Colors.white24
                                                      : (row['aboveAverage'] ?? false)
                                                          ? const Color(0xff81c784)
                                                          : Colors.white38,
                                                  fontSize: 13,
                                                  fontWeight: isSF ? FontWeight.normal : FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Summary info
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "CREDITS EARNED",
                                style: GoogleFonts.poppins(
                                  color: Colors.white38,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${_earnedCredits?.toStringAsFixed(1)} / ${_semesterCredits?.toStringAsFixed(1)} cr",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          color: Colors.black12,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "SGPA",
                                style: GoogleFonts.poppins(
                                  color: Colors.white38,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                _calculatedSgpa!.toStringAsFixed(4),
                                style: GoogleFonts.poppins(
                                  color: const Color(0xffff5722),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCoursesWidget() {
    final branchData = _curriculum[_selectedBranch!];
    if (branchData == null) return const SizedBox.shrink();

    final semData = branchData[_selectedSem!];

    if (semData == 'FLEXIBLE') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.02),
              border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "⚠ FLEXIBLE SEMESTER",
                  style: GoogleFonts.poppins(
                    color: const Color(0xffff5722),
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Industrial SLI / Thesis / Electives / Project+Electives / Internship+Electives.\nAll options = 12 credits. Add your courses manually below.",
                  style: GoogleFonts.poppins(
                    color: Colors.white70,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Custom Course List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _customCourses.length,
            itemBuilder: (context, idx) {
              final row = _customCourses[idx];
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xff14161d),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextField(
                        controller: row.nameController,
                        style: GoogleFonts.poppins(color: Colors.white, fontSize: 13),
                        decoration: InputDecoration(
                          hintText: "Course name...",
                          hintStyle: GoogleFonts.poppins(color: Colors.white30, fontSize: 13),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: row.creditsController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        style: GoogleFonts.poppins(color: Colors.white, fontSize: 13),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: "Cr.",
                          hintStyle: GoogleFonts.poppins(color: Colors.white30, fontSize: 13),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    DropdownButton<String>(
                      value: row.selectedGrade,
                      dropdownColor: const Color(0xff111111),
                      underline: const SizedBox.shrink(),
                      style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                      onChanged: (String? val) {
                        if (val != null) {
                          setState(() {
                            row.selectedGrade = val;
                          });
                        }
                      },
                      items: _grades.map((g) {
                        return DropdownMenuItem<String>(
                          value: g,
                          child: Text(g),
                        );
                      }).toList(),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white38, size: 20),
                      onPressed: () => _removeCustomRow(idx),
                    ),
                  ],
                ),
              );
            },
          ),

          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: _addCustomRow,
            icon: const Icon(Icons.add, color: Color(0xffff5722), size: 16),
            label: Text(
              "ADD COURSE ROW",
              style: GoogleFonts.poppins(
                color: const Color(0xffff5722),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xffff5722)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ],
      );
    } else if (semData is List<CourseData>) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: semData.length,
        itemBuilder: (context, idx) {
          final course = semData[idx];
          final isHardcodedSF = isSFCourse(_selectedBranch!, _selectedSem!, course.name);
          final bool isSF = _regularCourseIsSF[idx] ?? false;

          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xff14161d),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    course.name,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                if (isHardcodedSF) ...[
                  // Hardcoded SF courses like Indian Knowledge System
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "S/F",
                      style: GoogleFonts.poppins(
                        color: Colors.white30,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  _buildSFToggle(idx),
                ] else if (isSF) ...[
                  // Graded course converted to S/F
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "S/F",
                      style: GoogleFonts.poppins(
                        color: Colors.white30,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  _buildSFToggle(idx),
                  const SizedBox(width: 8),
                  _buildSFButton(idx, true),
                ] else ...[
                  // Normal graded course
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.04),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      course.credits.toString(),
                      style: GoogleFonts.poppins(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  DropdownButton<String>(
                    value: _regularCourseGrades[idx] ?? 'A',
                    dropdownColor: const Color(0xff111111),
                    underline: const SizedBox.shrink(),
                    style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                    onChanged: (String? val) {
                      if (val != null) {
                        setState(() {
                          _regularCourseGrades[idx] = val;
                        });
                      }
                    },
                    items: _grades.map((g) {
                      return DropdownMenuItem<String>(
                        value: g,
                        child: Text(g),
                      );
                    }).toList(),
                  ),
                  const SizedBox(width: 8),
                  _buildSFButton(idx, false),
                ],
              ],
            ),
          );
        },
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildSFToggle(int idx) {
    final currentVal = _sfCourseValues[idx] ?? 'S';
    final isS = currentVal == 'S';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _sfCourseValues[idx] = 'S';
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isS ? const Color(0xffff5722) : const Color(0xff0f1015),
              border: Border.all(
                color: isS ? const Color(0xffff5722) : Colors.white.withValues(alpha: 0.1),
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: Text(
              "S",
              style: GoogleFonts.poppins(
                color: isS ? Colors.white : Colors.white60,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _sfCourseValues[idx] = 'F';
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: !isS ? const Color(0xffc62828) : const Color(0xff0f1015),
              border: Border.all(
                color: !isS ? const Color(0xffc62828) : Colors.white.withValues(alpha: 0.1),
              ),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: Text(
              "F",
              style: GoogleFonts.poppins(
                color: !isS ? Colors.white : Colors.white60,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSFButton(int idx, bool isActive) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _regularCourseIsSF[idx] = !isActive;
          if (!isActive) {
            _sfCourseValues[idx] = 'S';
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xffff5722) : Colors.transparent,
          border: Border.all(
            color: isActive ? const Color(0xffff5722) : Colors.white.withValues(alpha: 0.1),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          "S/F",
          style: GoogleFonts.poppins(
            color: isActive ? Colors.white : Colors.white30,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
