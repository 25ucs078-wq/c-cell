class GymkhanaExecutive {
  final String name;
  final String position;
  final String phone;
  final String email;

  const GymkhanaExecutive({
    required this.name,
    required this.position,
    required this.phone,
    required this.email,
  });
}

class CouncilData {
  final String name;
  final String logoPath;
  final String description;
  final List<GymkhanaExecutive> leaders;
  final List<ClubData> clubs;

  const CouncilData({
    required this.name,
    required this.logoPath,
    required this.description,
    required this.leaders,
    required this.clubs,
  });
}

class ClubData {
  final String name;
  final String logoPath;
  final String description;
  final String instagramUrl;
  final List<Map<String, String>> coordinators;
  final List<String> galleryImages;

  const ClubData({
    required this.name,
    required this.logoPath,
    required this.description,
    required this.instagramUrl,
    required this.coordinators,
    required this.galleryImages,
  });
}

class FestData {
  final String name;
  final String logoPath;
  final String description;
  final List<Map<String, String>> heads;
  final List<String> galleryImages;
  final String instagramUrl;
  final String youtubeUrl;
  final String linkedinUrl;
  final String facebookUrl;
  final String xUrl;
  final String emailUrl;

  const FestData({
    required this.name,
    required this.logoPath,
    required this.description,
    required this.heads,
    required this.galleryImages,
    this.instagramUrl = '',
    this.youtubeUrl = '',
    this.linkedinUrl = '',
    this.facebookUrl = '',
    this.xUrl = '',
    this.emailUrl = '',
  });
}

// -----------------------------------------------------------------------------
// EXECUTIVE MEMBERS
// -----------------------------------------------------------------------------

const List<GymkhanaExecutive> gymkhanaExecutives = [
  GymkhanaExecutive(
    name: 'Mr. Hamendra Yadav',
    position: 'President',
    phone: '8890605538',
    email: 'gym.president@lnmiit.ac.in',
  ),
  GymkhanaExecutive(
    name: 'Mr. Priyanshu Kumar',
    position: 'Vice-President',
    phone: '9964391163',
    email: 'gym.vicepresident@lnmiit.ac.in',
  ),
  GymkhanaExecutive(
    name: 'Mr. Adarsh Mishra',
    position: 'Finance Convener',
    phone: '7426046332',
    email: 'gym.financeconvenor@lnmiit.ac.in',
  ),
];

// -----------------------------------------------------------------------------
// CULTURAL COUNCIL
// -----------------------------------------------------------------------------

final CouncilData culturalCouncil = CouncilData(
  name: "Cultural Council",
  logoPath: "assets/images/cult_logo.jpeg",
  description: "The Cultural Council at LNMIIT nurtures arts, traditions, and creative expression through its diverse clubs and events. From dance and drama to music and fashion, it celebrates campus culture and brings students together.",
  leaders: const [
    GymkhanaExecutive(
      name: "Mr. Kanishq Singhal",
      position: "General Secretary",
      phone: "8005644538",
      email: "gsec.cultural@lnmiit.ac.in",
    ),
    GymkhanaExecutive(
      name: "Ms. Ishita Khandelwal",
      position: "Associate General Secretary",
      phone: "7597252005",
      email: "agsec.cultural@lnmiit.ac.in",
    ),
    GymkhanaExecutive(
      name: "Mr. Tanmay Jain",
      position: "Finance Convener",
      phone: "9039951710",
      email: "",
    ),
  ],
  clubs: [
    const ClubData(
      name: "AAVEG",
      logoPath: "assets/images/cultural/aaveg/aaveg_logo.png",
      description: "AAVEG is the street play club of LNMIIT, using powerful scripts to reflect societal truths. Known for loud voices and beautiful acting, Aaveg has won numerous events.",
      instagramUrl: "https://www.instagram.com/aaveg_lnmiit/",
      coordinators: [
        {"name": "Shourya Kavdia", "phone": "", "email": ""},
        {"name": "Tanuj Tulsyan", "phone": "", "email": ""},
        {"name": "Aditya Agarwal", "phone": "", "email": ""},
        {"name": "Yash Gupta", "phone": "", "email": ""},
      ],
      galleryImages: [
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/aaveg/aaveg1.JPG",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/aaveg/aaveg2.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/aaveg/aaeg4.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/aaveg/aaveg4.JPG",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/aaveg/aaveg5.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/aaveg/aaveg6.JPG",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/aaveg/aaveg7.jpg",
      ],
    ),
    const ClubData(
      name: "Capriccio",
      logoPath: "assets/images/cultural/capriccio/capriccio_logo.jpg",
      description: "Capriccio is the music club of LNMIIT, welcoming singers, beatboxers, vocalists, and instrumentalists to jam together. Explore multiple genres and find your creative voice.",
      instagramUrl: "https://www.instagram.com/capriccio.lnmiit/",
      coordinators: [
        {"name": "Ashmit Dudani", "phone": "", "email": ""},
        {"name": "Nandini Sharma", "phone": "", "email": ""},
        {"name": "Nilesh Agarwal", "phone": "", "email": ""},
        {"name": "Parth Arora", "phone": "", "email": ""},
      ],
      galleryImages: [
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/capriccio/cap1.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/capriccio/cap2.JPG",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/capriccio/cap3.JPG",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/capriccio/cap4.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/capriccio/cap5.JPG",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/capriccio/cap6.JPG",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/capriccio/cap7.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/capriccio/cap8.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/capriccio/cap9.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/capriccio/cap10.JPG",
      ],
    ),
    const ClubData(
      name: "Eminence",
      logoPath: "assets/images/cultural/eminence/eminence_logo.jpg",
      description: "Eminence is the fashion club of LNMIIT, where style is an attitude and a lifestyle. Whether you're into streetwear, avant-garde, or classical elegance, there's a place for you here.",
      instagramUrl: "https://www.instagram.com/eminence.lnmiit/",
      coordinators: [
        {"name": "Avesh Khan", "phone": "", "email": ""},
        {"name": "Kushagra", "phone": "", "email": ""},
      ],
      galleryImages: [
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/eminence/emi1.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/eminence/emi2.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/eminence/emi3.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/eminence/emi4.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/eminence/emi5.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/eminence/emi6.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/eminence/emi7.jpg",
      ],
    ),
    const ClubData(
      name: "Fundoo",
      logoPath: "assets/images/cultural/fundoo/fundoo_logo.jpg",
      description: "Fundoo is the fun activities club of LNMIIT, combining 'Fun' and 'Do' to get everyone involved. It brings the fun to cultural celebrations like Nostalgia, Makar Sankranti, and Independence Day.",
      instagramUrl: "https://www.instagram.com/fundoo.lnmiit/",
      coordinators: [
        {"name": "Ansh Dubey", "phone": "9555078768", "email": "23uec517@lnmiit.ac.in"},
        {"name": "Sanvi Mittal", "phone": "7428261097", "email": "23uec614@lnmiit.ac.in"},
        {"name": "Satvik Gupta", "phone": "7727001785", "email": "23ucs698@lnmiit.ac.in"},
        {"name": "Yuvika Gupta", "phone": "9216746454", "email": "23ume560@lnmiit.ac.in"},
      ],
      galleryImages: [
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/fundoo/f1.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/fundoo/f2.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/fundoo/f3.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/fundoo/f4.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/fundoo/f5.jpg",
      ],
    ),
    const ClubData(
      name: "Imagination",
      logoPath: "assets/images/cultural/imagination/imagi_logo.jpg",
      description: "Imagination is the photography and cinematography club of LNMIIT, capturing memories of college life. From sunsets to vibrant fests, we freeze time with our lenses.",
      instagramUrl: "https://www.instagram.com/imagination.lnmiit/",
      coordinators: [
        {"name": "Siddhesh Chintamani", "phone": "", "email": ""},
        {"name": "Avirat Kaushik", "phone": "", "email": ""},
        {"name": "Aditya Prakash", "phone": "", "email": ""},
        {"name": "Ayush Agarwal", "phone": "", "email": ""},
      ],
      galleryImages: [
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/imagination/imagination1.JPG",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/imagination/imagination2.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/imagination/imagination3.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/imagination/imagination4.JPG",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/imagination/imagination5.jpg",
      ],
    ),
    const ClubData(
      name: "Insignia",
      logoPath: "assets/images/cultural/insignia/insignia_logo.jpg",
      description: "Insignia is the dance club of LNMIIT, catering to novices and experts alike across styles like Classical, Hip-Hop, Bollywood, and more. It's a dynamic community that choreographs, performs, and inspires members to learn something new.",
      instagramUrl: "https://www.instagram.com/insignia_lnm/",
      coordinators: [
        {"name": "Ananya Surana", "phone": "", "email": ""},
        {"name": "Kavin Goyal", "phone": "", "email": ""},
        {"name": "Shivansh Singh", "phone": "", "email": ""},
      ],
      galleryImages: [
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/insignia/insignia1.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/insignia/insignia2.JPG",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/insignia/insignia3.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/insignia/insignia4.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/insignia/insignia5.jpg",
      ],
    ),
    const ClubData(
      name: "Literary Committee",
      logoPath: "assets/images/cultural/lc/lc_logo.jpg",
      description: "The Literary Committee of LNMIIT is a sanctuary for bibliophiles and word weavers. From open mics to book discussions, it caters to a wide spectrum of literary interests.",
      instagramUrl: "https://www.instagram.com/literary_lnmiit/",
      coordinators: [
        {"name": "Parth Chaturvedi", "phone": "", "email": ""},
        {"name": "Mriganka Kothari", "phone": "", "email": ""},
        {"name": "Armaan Jain", "phone": "", "email": ""},
        {"name": "Poorvi Jagga", "phone": "", "email": ""},
      ],
      galleryImages: [
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/lc/lc1.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/lc/lc2.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/lc/lc3.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/lc/lc4.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/lc/lc5.jpg",
      ],
    ),
    const ClubData(
      name: "Media Cell",
      logoPath: "assets/images/cultural/mediacell/media_logo.jpg",
      description: "Media Cell is the voice of LNMIIT's campus events, captivating audiences through engaging content and masterful anchoring. They leave an indelible mark on every event they host.",
      instagramUrl: "https://www.instagram.com/mediacell_lnmiit/",
      coordinators: [
        {"name": "Pranav Vashisth", "phone": "", "email": ""},
        {"name": "Praneel Dev", "phone": "", "email": ""},
        {"name": "Samar Goyal", "phone": "", "email": ""},
        {"name": "Vedha Sinkar", "phone": "", "email": ""},
      ],
      galleryImages: [
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/mediacell/media1.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/mediacell/media2.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/mediacell/media3.JPG",
      ],
    ),
    const ClubData(
      name: "Rendition",
      logoPath: "assets/images/cultural/rendition/rendition_logo.png",
      description: "Rendition is the dramatics club of LNMIIT, nurturing dramatic skills through scripts, monologues, comedy, mime, and skits. It's a powerful community that brings stories to life through interactive theater exercises.",
      instagramUrl: "https://www.instagram.com/rendition_lnmiit/",
      coordinators: [
        {"name": "Nikhila S Hari", "phone": "", "email": ""},
        {"name": "Shah Manav Tarakkumar", "phone": "", "email": ""},
        {"name": "Madhav Agrawal", "phone": "", "email": ""},
      ],
      galleryImages: [
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/rendition/ren1.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/rendition/ren2.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/rendition/ren3.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/rendition/ren4.jpg",
      ],
    ),
    const ClubData(
      name: "Sankalp",
      logoPath: "assets/images/cultural/sankalp/sankalp_logo.jpg",
      description: "Sankalp is the social club of LNMIIT, dedicated to bringing joy and hope into the lives of the less fortunate. It believes a kind gesture can reach a wound that only compassion can heal.",
      instagramUrl: "https://www.instagram.com/sankalp.lnmiit/",
      coordinators: [
        {"name": "Amisha Paliwal", "phone": "", "email": ""},
        {"name": "Arnav Dubey", "phone": "", "email": ""},
        {"name": "Gaurav Kalal", "phone": "", "email": ""},
        {"name": "Lakshya Chandak", "phone": "", "email": ""},
        {"name": "Raghav Agarwal", "phone": "", "email": ""},
      ],
      galleryImages: [
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/sankalp/sankalp1.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/sankalp/sankalp2.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/sankalp/sankalp3.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/sankalp/sankalp4.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/sankalp/sankalp5.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/sankalp/sankalp6.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/sankalp/sankalp7.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/sankalp/sankalp8.jpg",
      ],
    ),
    const ClubData(
      name: "Vignette",
      logoPath: "assets/images/cultural/vignette/vignette_logo.jpg",
      description: "Vignette is the art club of LNMIIT, striving to bring out the artistic best of students. It offers a creative, soothing medium for self-expression across various art forms.",
      instagramUrl: "https://www.instagram.com/vignette_lnmiit/",
      coordinators: [
        {"name": "Akshat Mishra", "phone": "", "email": ""},
        {"name": "Divyansh Patil", "phone": "", "email": ""},
        {"name": "Hiya Gera", "phone": "", "email": ""},
        {"name": "Jahanvi Garg", "phone": "", "email": ""},
      ],
      galleryImages: [
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/vignette/vignette1.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/vignette/vignette2.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/vignette/vignette3.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/vignette/vignette4.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/vignette/vignette5.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/vignette/vignette6.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/vignette/vignette7.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/vignette/vignette8.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/vignette/vignette9.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/cultural/vignette/vignette10.jpg",
      ],
    ),
  ],
);

// -----------------------------------------------------------------------------
// SPORTS COUNCIL
// -----------------------------------------------------------------------------

final CouncilData sportsCouncil = CouncilData(
  name: "Sports Council",
  logoPath: "assets/images/sports_logo.jpg",
  description: "The Sports Council at LNMIIT drives athletic excellence and wellness on campus. It provides a platform for athletes to foster teamwork and competitive spirit through various tournaments.",
  leaders: const [
    GymkhanaExecutive(
      name: "Mr. Arihant Bhura",
      position: "General Secretary",
      phone: "9345275071",
      email: "gsec.sports@lnmiit.ac.in",
    ),
    GymkhanaExecutive(
      name: "Ms. Priyal Maheshwari",
      position: "Associate General Secretary",
      phone: "7727881239",
      email: "agsec.sports@lnmiit.ac.in",
    ),
    GymkhanaExecutive(
      name: "Mr. Raghav Khandelwal",
      position: "Finance Convener",
      phone: "8003454873",
      email: "",
    ),
  ],
  clubs: [
    const ClubData(
      name: "Badminton",
      logoPath: "assets/images/sports/badminton/badminton_logo.jpeg",
      description: "The Badminton Club at LNMIIT is where agility meets strategy. The courts buzz with energy as students test their smashes and reflexes.",
      instagramUrl: "https://www.instagram.com/badminton_lnmiit/",
      coordinators: [
        {"name": "Sanvi Rastogi", "phone": "", "email": ""},
        {"name": "Parth Pandey", "phone": "", "email": ""},
        {"name": "Aditya Jakhar", "phone": "", "email": ""},
      ],
      galleryImages: [
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/badminton/badminton1.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/badminton/badminton2.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/badminton/badminton3.jpeg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/badminton/badminton4.jpeg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/badminton/badminton5.jpeg",
      ],
    ),
    const ClubData(
      name: "Basketball",
      logoPath: "assets/images/sports/basketball/basketball_logo.png",
      description: "The Basketball Club at LNMIIT is where passion for the game takes center stage. Members elevate their skills through regular practice and intercollegiate competitions.",
      instagramUrl: "https://www.instagram.com/lnmiit_basketball/",
      coordinators: [
        {"name": "Tanmay Poswalia", "phone": "", "email": ""},
        {"name": "Vedansh Vashisth", "phone": "", "email": ""},
        {"name": "Jatin Kukreja", "phone": "", "email": ""},
        {"name": "Raghav Agarwal", "phone": "", "email": ""},
      ],
      galleryImages: [
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/basketball/basketball1.jpeg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/basketball/basketball2.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/basketball/basketball3.jpeg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/basketball/basketball4.JPG",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/basketball/basketball5.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/basketball/basketball6.JPG",
      ],
    ),
    const ClubData(
      name: "Chess",
      logoPath: "assets/images/sports/chess/chess_logo.jpg",
      description: "The Chess Club at LNMIIT is the intellectual arena where strategy and foresight reign supreme. It hones critical thinking and problem-solving skills through regular play and competitions.",
      instagramUrl: "https://www.instagram.com/chess_lnmiit/",
      coordinators: [
        {"name": "Lakshit Singhvi", "phone": "", "email": ""},
        {"name": "Divyansh Aggarwal", "phone": "", "email": ""},
        {"name": "Kavya Jain", "phone": "", "email": ""},
      ],
      galleryImages: [
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/chess/chess1.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/chess/chess2.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/chess/chess3.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/chess/chess4.jpg",
      ],
    ),
    const ClubData(
      name: "Cricket",
      logoPath: "assets/images/sports/cricket/cricket_logo.jpeg",
      description: "The Cricket Club at LNMIIT fosters a deep appreciation for India's favorite sport. It develops well-rounded individuals who understand the value of teamwork and dedication.",
      instagramUrl: "https://www.instagram.com/_cricket_lnmiit/",
      coordinators: [
        {"name": "Saurav Singh", "phone": "", "email": ""},
        {"name": "Garvit Girdhar", "phone": "", "email": ""},
        {"name": "Divyansh Shrivastava", "phone": "", "email": ""},
        {"name": "Abhinav Dhwaj Prasad Singh", "phone": "", "email": ""},
        {"name": "Tanmay Pareek", "phone": "", "email": ""},
      ],
      galleryImages: [
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/cricket/cricket1.jpeg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/cricket/cricket2.jpeg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/cricket/cricket3.jpeg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/cricket/cricket5.jpeg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/cricket/cricket6.jpeg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/cricket/cricket7.jpeg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/cricket/cricket8.jpeg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/cricket/cricket9.jpeg",
      ],
    ),
    const ClubData(
      name: "Football",
      logoPath: "assets/images/sports/football/football_logo.jpg",
      description: "The Football Club at LNMIIT is driven by passion for the beautiful game. Whether seasoned or new, members enjoy a dynamic environment to develop their skills.",
      instagramUrl: "https://www.instagram.com/football.lnmiit/",
      coordinators: [
        {"name": "Harsh Gupta", "phone": "", "email": ""},
        {"name": "Kavyansh Mittal", "phone": "", "email": ""},
        {"name": "Rishabh Agarwal", "phone": "", "email": ""},
        {"name": "Sahadra Rana", "phone": "", "email": ""},
      ],
      galleryImages: [
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/football/football1.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/football/football2.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/football/football3.jpeg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/football/football4.jpeg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/football/football5.jpg",
      ],
    ),
    const ClubData(
      name: "Kabaddi",
      logoPath: "assets/images/sports/kabaddi/kabaddi_logo.jpeg",
      description: "The Kabaddi Club at LNMIIT celebrates India's indigenous sport of strength, strategy, and teamwork. Experience the thrill on the mat.",
      instagramUrl: "https://www.instagram.com/lnmiit_kabaddi/",
      coordinators: [
        {"name": "Shivam Sharma", "phone": "", "email": ""},
        {"name": "Nikhil Kumar", "phone": "", "email": ""},
        {"name": "Manish Bana", "phone": "", "email": ""},
        {"name": "Abhinav", "phone": "", "email": ""},
      ],
      galleryImages: [
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/kabaddi/kabaddi1.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/kabaddi/kabaddi2.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/kabaddi/kabaddi3.jpeg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/kabaddi/kabaddi4.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/kabaddi/kabaddi5.JPG",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/kabaddi/kabaddi6.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/kabaddi/kabaddi7.JPG",
      ],
    ),
    const ClubData(
      name: "Lawn Tennis",
      logoPath: "assets/images/sports/lawn_tennis/lawnt_logo.png",
      description: "The Lawn Tennis Club at LNMIIT instills a love for the game and develops individuals who embody the true spirit of tennis.",
      instagramUrl: "",
      coordinators: [
        {"name": "Kushagra Maheshwari", "phone": "", "email": ""},
        {"name": "Lakshya Chandak", "phone": "", "email": ""},
      ],
      galleryImages: [
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/lawn_tennis/lawnt1.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/lawn_tennis/lawnt2.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/lawn_tennis/lawnt3.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/lawn_tennis/lawnt4.jpg",
      ],
    ),
    const ClubData(
      name: "Squash",
      logoPath: "assets/images/sports/squash/squash_logo.jpeg",
      description: "The Squash Club at LNMIIT offers fast-paced action and a fantastic way to stay fit and active on campus.",
      instagramUrl: "",
      coordinators: [
        {"name": "Aditya Jindal", "phone": "", "email": ""},
        {"name": "Vansh Sharma", "phone": "", "email": ""},
      ],
      galleryImages: [
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/squash/squash1.jpeg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/squash/squash2.jpeg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/squash/squash3.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/squash/squash4.jpeg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/squash/squash5.jpeg",
      ],
    ),
    const ClubData(
      name: "Table Tennis",
      logoPath: "assets/images/sports/table_tennis/tablet_logo.png",
      description: "The Table Tennis Club at LNMIIT brings lightning-fast rallies and precise techniques to the table. Join for competitive play and skill development.",
      instagramUrl: "",
      coordinators: [
        {"name": "Arjun Mukherjee", "phone": "", "email": ""},
        {"name": "Aashil Bhutra", "phone": "", "email": ""},
        {"name": "Shivansh Gupta", "phone": "", "email": ""},
        {"name": "Urvi Salecha", "phone": "", "email": ""},
      ],
      galleryImages: [
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/table_tennis/tablet1.JPG",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/table_tennis/tablet2.JPG",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/table_tennis/tablet3.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/table_tennis/tablet4.JPG",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/table_tennis/tablet5.JPG",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/table_tennis/tablet6.JPG",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/table_tennis/tablet7.JPG",
      ],
    ),
    const ClubData(
      name: "Volleyball",
      logoPath: "assets/images/sports/volleyball/volleyball_logo.jpg",
      description: "The Volleyball Club at LNMIIT embraces the challenge of the game, pushing members to grow together. Join for spirited matches and teamwork.",
      instagramUrl: "https://www.instagram.com/lnmiit.volleyball/",
      coordinators: [
        {"name": "Apoorwa Jain", "phone": "", "email": ""},
        {"name": "Saniya Sharma", "phone": "", "email": ""},
        {"name": "Ayush Raj Shahi", "phone": "", "email": ""},
        {"name": "Dinakar", "phone": "", "email": ""},
        {"name": "Panth Moradiya", "phone": "", "email": ""},
      ],
      galleryImages: [
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/volleyball/volleyball1.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/volleyball/volleyball2.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/volleyball/volleyball3.JPG",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/volleyball/volleyball4.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/volleyball/volleyball5.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/sports/volleyball/volleyball6.jpg",
      ],
    ),
  ],
);

// -----------------------------------------------------------------------------
// TECHNOLOGY COUNCIL
// -----------------------------------------------------------------------------

final CouncilData technologyCouncil = CouncilData(
  name: "Science & Technology Council",
  logoPath: "assets/images/tech_logo.jpg",
  description: "The Science & Technology Council at LNMIIT fosters innovation and excellence through its diverse range of clubs spanning robotics, cybersecurity, competitive programming, and more. It organizes hackathons, tech talks, and competitions to build technical expertise and leadership.",
  leaders: const [
    GymkhanaExecutive(
      name: "Mr. Tushar Agrawal",
      position: "General Secretary",
      phone: "6306263607",
      email: "gsec.science@lnmiit.ac.in",
    ),
    GymkhanaExecutive(
      name: "Ms. Anmol Adwani",
      position: "Associate General Secretary",
      phone: "9039839018",
      email: "agsec.science@lnmiit.ac.in",
    ),
    GymkhanaExecutive(
      name: "Mr. Devashish Tripathi",
      position: "Finance Convener",
      phone: "9473548085",
      email: "",
    ),
  ],
  clubs: [
    const ClubData(
      name: "Astronomy",
      logoPath: "assets/images/tech/astronomy/astro_logo.jpg",
      description: "The Astronomy Club at LNMIIT gazes at the stars and unravels the mysteries of the universe. Join to explore celestial wonders through observation and learning.",
      instagramUrl: "https://www.instagram.com/astronomylnmiit",
      coordinators: [
        {"name": "Tanushree Sethi", "phone": "", "email": ""},
        {"name": "Kshitij Verma", "phone": "", "email": ""},
        {"name": "Jivya Jain", "phone": "", "email": ""},
        {"name": "Gourav Bansal", "phone": "", "email": ""},
      ],
      galleryImages: [
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/tech/astronomy/astro1.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/tech/astronomy/astro2.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/tech/astronomy/astro3.JPG",
      ],
    ),
    const ClubData(
      name: "Cipher",
      logoPath: "assets/images/tech/cipherclub/cipher_logo.png",
      description: "Cipher is the cybersecurity and blockchain club of LNMIIT. Learn, secure, and hack responsibly.",
      instagramUrl: "https://www.instagram.com/cipher.lnmiit/",
      coordinators: [
        {"name": "Amrendra Vikram Singh", "phone": "", "email": ""},
        {"name": "Vaibhav Rawat", "phone": "", "email": ""},
        {"name": "Ninaad Mathur", "phone": "", "email": ""},
        {"name": "Nitish Matta", "phone": "", "email": ""},
      ],
      galleryImages: [
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/tech/cipherclub/cipher1.JPG",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/tech/cipherclub/cipher2.jpg",
      ],
    ),
    const ClubData(
      name: "Cybros",
      logoPath: "assets/images/tech/cybros/cybros_logo.jpg",
      description: "Cybros is the competitive programming club of LNMIIT where members eat, sleep, and breathe algorithms. Sharpen your coding skills through contests and practice.",
      instagramUrl: "https://www.instagram.com/cybros_lnmiit/",
      coordinators: [
        {"name": "Abhinav Dogra", "phone": "", "email": ""},
        {"name": "Lokesh Malik", "phone": "", "email": ""},
      ],
      galleryImages: [
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/tech/cybros/cybros1.JPG",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/tech/cybros/cybros2.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/tech/cybros/cybros3.JPG",
      ],
    ),
    const ClubData(
      name: "Debsoc",
      logoPath: "assets/images/tech/debsoc/debsoc_logo.jpg",
      description: "Debsoc is the Debate Society of LNMIIT, conquering through the power of words. Members argue, reason, and sharpen their public speaking skills.",
      instagramUrl: "https://www.instagram.com/thedebatesocietylnmiit/",
      coordinators: [
        {"name": "Aalekh Narain", "phone": "", "email": ""},
        {"name": "Akansh Saxena", "phone": "", "email": ""},
        {"name": "Ruhani Sukhija", "phone": "", "email": ""},
      ],
      galleryImages: [
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/tech/debsoc/debsoc1.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/tech/debsoc/debsoc2.JPG",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/tech/debsoc/debsoc3.JPG",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/tech/debsoc/debsoc4.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/tech/debsoc/debsoc5.JPG",
      ],
    ),
    const ClubData(
      name: "E-Cell",
      logoPath: "assets/images/tech/ecell/ecell_logo.jpg",
      description: "E-Cell is the Entrepreneurship Cell of LNMIIT, fostering the entrepreneurial spirit among students. It provides a platform for ideas, mentorship, and startup culture.",
      instagramUrl: "https://www.instagram.com/ecell.lnmiit",
      coordinators: [
        {"name": "Jimit Thakrar", "phone": "8780579193", "email": "23uec557@lnmiit.ac.in"},
        {"name": "Shiviansh Yadav", "phone": "9264930636", "email": "23uec623@lnmiit.ac.in"},
        {"name": "Sakasham Mewada", "phone": "7597024466", "email": "23ume543@lnmiit.ac.in"},
        {"name": "Satyam Shukla", "phone": "7984786107", "email": "23ucs753@lnmiit.ac.in"},
      ],
      galleryImages: [
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/tech/ecell/ecell1.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/tech/ecell/ecell2.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/tech/ecell/ecell3.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/tech/ecell/ecell4.jpg",
      ],
    ),
    const ClubData(
      name: "Phoenix",
      logoPath: "assets/images/tech/phoenix/phoenix_logo.png",
      description: "Phoenix is the robotics club of LNMIIT, building the future one circuit at a time. Members design, build, and compete with robots across various domains.",
      instagramUrl: "https://www.instagram.com/phoenix.lnmiit/",
      coordinators: [
        {"name": "Aviral Goyal", "phone": "", "email": ""},
        {"name": "Aryan Agarwal", "phone": "", "email": ""},
        {"name": "Shamit Rathi", "phone": "", "email": ""},
        {"name": "Shreekant Kumawat", "phone": "", "email": ""},
      ],
      galleryImages: [
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/tech/phoenix/phoenix1.JPG",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/tech/phoenix/phoenix2.JPG",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/tech/phoenix/phoenix3.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/tech/phoenix/phoenix4.JPG",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/tech/phoenix/phoenix5.JPG",
      ],
    ),
    const ClubData(
      name: "Quizzinga",
      logoPath: "assets/images/tech/quizzinga/quizzinga_logo.jpg",
      description: "Quizzinga is the quizzing club of LNMIIT, for those who know a little bit about everything. Test your knowledge and compete in exciting quiz events.",
      instagramUrl: "https://www.instagram.com/quizzingalnm/",
      coordinators: [
        {"name": "Dhruv Semalti", "phone": "", "email": ""},
        {"name": "Sandarbh Gyan", "phone": "", "email": ""},
        {"name": "Viha Arvind Kotak", "phone": "", "email": ""},
      ],
      galleryImages: [
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/tech/quizzinga/quizzinga1.jpg",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/tech/quizzinga/quizzinga2.JPG",
        "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/tech/quizzinga/quizzinga3.JPG",
      ],
    ),
    const ClubData(
      name: "Finlogue",
      logoPath: "assets/images/tech/finlogue/finlogue_logo.png",
      description: "Finlogue is the finance and investment club of LNMIIT, bridging the gap between academic knowledge and real-world financial literacy.",
      instagramUrl: "",
      coordinators: [
        {"name": "Aditya Tiwari", "phone": "", "email": ""},
        {"name": "Akshat Thadani", "phone": "", "email": ""},
        {"name": "Aryan Mittal", "phone": "", "email": ""},
      ],
      galleryImages: [],
    ),
  ],
);

// -----------------------------------------------------------------------------
// FESTS & EVENTS
// -----------------------------------------------------------------------------

const List<FestData> studentFests = [
  FestData(
    name: "Desportivos",
    logoPath: "assets/images/despo/despo_logo.jpeg",
    description: "Desportivos is the flagship annual sports festival of LNMIIT, spanning four action-packed days of intercollegiate competition. Teams from across the nation compete in high-stakes matches filled with sportsmanship and camaraderie.",
    instagramUrl: "https://www.instagram.com/desportivos.lnmiit",
    youtubeUrl: "https://www.youtube.com/@desportivoslnmiit",
    linkedinUrl: "https://www.linkedin.com/company/desportivos-lnmiit/",
    facebookUrl: "https://www.facebook.com/Desportivos.LNMIIT",
    xUrl: "https://twitter.com/desportivos_18",
    emailUrl: "desportivos@lnmiit.ac.in",
    heads: [
      {"name": "Abhas Chaudhary", "phone": "9411453707", "email": "23uec502@lnmiit.ac.in"},
      {"name": "Arnav Rinawa", "phone": "9166270181", "email": "23dec504@lnmiit.ac.in"},
    ],
    galleryImages: [
      "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/despo/despo1.jpg",
      "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/despo/despo2.jpg",
      "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/despo/despo3.jpg",
      "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/despo/despo4.jpg",
      "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/despo/despo5.jpg",
    ],
  ),
  FestData(
    name: "Plinth",
    logoPath: "assets/images/plinth/plinth_logo.jpg",
    description: "Plinth is the annual techno-management fest of LNMIIT, one of Rajasthan's grandest inter-collegiate tech festivals. Spanning three days, it features robotics competitions, coding challenges, management games, and workshops.",
    instagramUrl: "https://www.instagram.com/plinth.lnmiit/",
    youtubeUrl: "https://www.youtube.com/user/PlinthLNMIITJaipur",
    facebookUrl: "https://www.facebook.com/Plinth.LNMIIT",
    xUrl: "https://twitter.com/PlinthLNMIIT",
    heads: [
      {"name": "Akshansh Singh", "phone": "8448321696", "email": "23ucs524@lnmiit.ac.in"},
      {"name": "Jayant Singhal", "phone": "7878194515", "email": "23uec555@lnmiit.ac.in"},
    ],
    galleryImages: [
      "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/plinth/plinth1.jpg",
      "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/plinth/plinth2.jpg",
      "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/plinth/plinth3.jpg",
      "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/plinth/plinth4.JPG",
      "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/plinth/plinth5.JPG",
    ],
  ),
  FestData(
    name: "Vivacity",
    logoPath: "assets/images/viva/viva_logo.png",
    description: "Vivacity is LNMIIT's flagship cultural festival, celebrated since 2007 as one of the region's most anticipated events. It showcases diverse talents across music, dance, drama, art, and literature.",
    instagramUrl: "https://www.instagram.com/vivacity.lnmiit",
    youtubeUrl: "https://www.youtube.com/@vivacity_lnmiit",
    linkedinUrl: "https://www.linkedin.com/company/vivacity-lnmiit-jaipur/",
    heads: [
      {"name": "Vedang Dixit", "phone": "8290956788", "email": "23uec641@lnmiit.ac.in"},
      {"name": "Vedant Wadhwa", "phone": "9897774430", "email": "23ucc612@lnmiit.ac.in"},
    ],
    galleryImages: [
      "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/viva/viva1.JPG",
      "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/viva/viva2.jpg",
      "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/viva/viva3.JPG",
      "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/viva/viva4.jpg",
      "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/viva/viva5.JPG",
    ],
  ),
];

const List<FestData> studentEvents = [
  FestData(
    name: "TEDX LNMIIT",
    logoPath: "assets/images/ted_logo.jpg",
    description: "TEDx LNMIIT ignites minds and sparks conversations, fostering a community of lifelong learners and innovators. It's a catalyst for positive change and a celebration of human potential.",
    instagramUrl: "https://www.instagram.com/tedxlnmiit/",
    youtubeUrl: "https://youtube.com/@tedxlnmiit",
    facebookUrl: "https://www.facebook.com/tedxlnmiitjaipur/",
    heads: [
      {"name": "Abdul Hadi Siddiqui", "phone": "8107210700", "email": "23ucs503@lnmiit.ac.in"},
      {"name": "Anshika Agrawal", "phone": "8826256810", "email": "23ucc516@lnmiit.ac.in"},
      {"name": "Parv Khandelwal", "phone": "8306595368", "email": "23uec588@lnmiit.ac.in"},
      {"name": "Vihaan Malik", "phone": "8445893879", "email": "23ume553@lnmiit.ac.in"},
    ],
    galleryImages: [
      "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/ted/ted1.jpg",
      "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/ted/ted2.jpg",
      "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/ted/ted3.jpg",
      "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/ted/ted4.jpg",
      "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/ted/ted5.JPG",
    ],
  ),
  FestData(
    name: "E-Summit",
    logoPath: "assets/images/esummit/esummit_logo.jpg",
    description: "E-Summit is the flagship event of E-Cell LNMIIT, providing a platform for budding entrepreneurs. Showcase ideas, learn from industry experts, and network with like-minded individuals.",
    heads: [
      {"name": "Aashrith Boppudi", "phone": "6302713914", "email": "22ucs051@lnmiit.ac.in"},
      {"name": "Mayank Rathi", "phone": "8824528009", "email": "22uec078@lnmiit.ac.in"},
    ],
    galleryImages: [
      "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/esummit/esummit1.JPG",
      "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/esummit/esummit1.JPG",
      "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/esummit/esummit1.JPG",
      "https://raw.githubusercontent.com/ccell2026/ccell/refs/heads/master/assets/images/esummit/esummit1.JPG",
    ],
  ),
];

// -----------------------------------------------------------------------------
// COSHA COMMITTEE
// -----------------------------------------------------------------------------

const ClubData coshaCommittee = ClubData(
  name: "COSHA Committee",
  logoPath: "assets/images/cosha_logo.jpg",
  description: "The Committee of Students for Hostel Affairs (COSHA) supervises all matters of common interest to the Hostels, Mess, and Canteen. It serves as the voice of students to address concerns and improve the habitable conditions on campus.",
  instagramUrl: "",
  coordinators: [
    {"name": "Mr. Rishi Raj", "phone": "9140003123", "email": "cosha@lnmiit.ac.in"},
  ],
  galleryImages: [],
);
