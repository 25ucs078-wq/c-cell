import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'more_page.dart';
import 'office_bearers_page.dart';
import 'student_fests_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  int hoveredCard = -1;
final GlobalKey eventsKey = GlobalKey();

final GlobalKey gymkhanaKey = GlobalKey();

final GlobalKey trendingKey = GlobalKey();

final GlobalKey clubsKey = GlobalKey();

final GlobalKey quickKey = GlobalKey();

final GlobalKey aboutKey = GlobalKey();

  void navigateToSection(
  int index,
  GlobalKey key,
) {

  setState(() {
    selectedIndex = index;
  });

  Navigator.pop(context);

  Future.delayed(
    const Duration(milliseconds: 250),
    () {

      Scrollable.ensureVisible(
        key.currentContext!,

        duration: const Duration(
          milliseconds: 700,
        ),

        curve: Curves.easeInOut,
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
        return Scaffold(

   drawer: Drawer(
  backgroundColor: const Color(0xFF050816),

  child: ListView(
    padding: const EdgeInsets.all(25),

    children: [

      const SizedBox(height: 30),
      Center(
  child: Container(

    decoration: BoxDecoration(
      shape: BoxShape.circle,

      boxShadow: [
        BoxShadow(
          color: Colors.redAccent.withValues(alpha: 0.35),
          blurRadius: 25,
        ),
      ],
    ),

    child: const CircleAvatar(
      radius: 38,
      backgroundImage: AssetImage(
        "assets/images/logo.jpeg",
      ),
    ),
  ),
),

const SizedBox(height: 20),

      Text(
        "C-CELL",
        style: GoogleFonts.bebasNeue(
          color: Colors.redAccent,
          fontSize: 46,
          letterSpacing: 3,
        ),
      ),

      const SizedBox(height: 25),

      Container(
        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),

          borderRadius: BorderRadius.circular(18),

          boxShadow: [
            BoxShadow(
              color: Colors.redAccent.withValues(alpha: 0.15),
              blurRadius: 25,
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

         Text(
              "WELCOME BACK",
              style: GoogleFonts.bebasNeue(
                color: Colors.redAccent,
                fontSize: 18,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 5),

          Text(
          "KUNAL AGARWAL",
          style: GoogleFonts.bebasNeue(
            color: Colors.white,
            fontSize: 32,
            letterSpacing: 1.5,
          ),
        ),

            const SizedBox(height: 5),

            Text(
            "Explore your campus universe",
            style: GoogleFonts.poppins(
              color: Colors.white54,
              fontSize: 13,
            ),
          ),
          ],
        ),
      ),

      const SizedBox(height: 35),

      // GLOW TILE

      AnimatedContainer(
        duration: const Duration(
    milliseconds: 300,
  ),

  curve: Curves.easeInOut, 

  margin: const EdgeInsets.only(bottom: 12),

  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(14),

   gradient: LinearGradient(
  colors: selectedIndex == 0
      ? [
          Colors.redAccent.withValues(alpha: 0.45),
          Colors.redAccent.withValues(alpha: 0.15),
        ]
      : [
          Colors.transparent,
          Colors.transparent,
        ],
),

    boxShadow: selectedIndex == 0
    ? [
        BoxShadow(
          color: Colors.redAccent.withValues(alpha: 0.35),
          blurRadius: 25,
        ),
      ]
    : [],
  ),

  child: Row(
    children: [

      Container(
        width: 5,
        height: 72,

        decoration: BoxDecoration(
          color: selectedIndex == 0
    ? Colors.redAccent
    : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
      ),

      Expanded(
        child: ListTile(

          leading: const Icon(
            Icons.auto_awesome,
            color: Colors.white,
          ),

          title: Text(
            "Freshers Events",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),

         onTap: () {
        navigateToSection(
          0,
    eventsKey,
  );
},

        ),
      ),

    ],
  ),
),

    AnimatedContainer(
            duration: const Duration(
        milliseconds: 300,
      ),

      curve: Curves.easeInOut,

  margin: const EdgeInsets.only(bottom: 12),

  decoration: BoxDecoration(

    borderRadius: BorderRadius.circular(14),

    gradient: LinearGradient(

      colors: selectedIndex == 1

          ? [

              Colors.redAccent.withValues(alpha: 0.35),

              Colors.redAccent.withValues(alpha: 0.12),

            ]

          : [

              Colors.transparent,

              Colors.transparent,

            ],
    ),
  ),

  child: Row(
  children: [

    Container(
      width: 5,
      height: 72,

      decoration: BoxDecoration(
        color: selectedIndex == 1
            ? Colors.redAccent
            : Colors.transparent,

        borderRadius:
            BorderRadius.circular(10),
      ),
    ),

    Expanded(
      child: ListTile(

    leading: const Icon(
      Icons.account_balance,
      color: Colors.white,
    ),

    title: const Text(
      "Gymkhana Councils",
      style: TextStyle(
        color: Colors.white,
      ),
    ),

    onTap: () {

      navigateToSection(
        1,
        gymkhanaKey,
      );

    },
  ),
    ),
  ],
  ),
),

    AnimatedContainer(
      duration: const Duration(
  milliseconds: 300,
),

curve: Curves.easeInOut,

  margin: const EdgeInsets.only(bottom: 12),

  decoration: BoxDecoration(

    borderRadius: BorderRadius.circular(14),

    gradient: LinearGradient(

      colors: selectedIndex == 2

          ? [

              Colors.redAccent.withValues(alpha: 0.35),

              Colors.redAccent.withValues(alpha: 0.12),

            ]

          : [

              Colors.transparent,

              Colors.transparent,

            ],
    ),
  ),

   child: Row(
  children: [

    Container(
      width: 5,
      height: 72,

      decoration: BoxDecoration(
        color: selectedIndex == 2
            ? Colors.redAccent
            : Colors.transparent,

        borderRadius:
            BorderRadius.circular(10),
      ),
    ),

    Expanded(
      child: ListTile(

    leading: const Icon(
      Icons.local_fire_department,
      color: Colors.white,
    ),

    title: const Text(
      "Trending Campus",
      style: TextStyle(
        color: Colors.white,
      ),
    ),

    onTap: () {

      navigateToSection(
        2,
        trendingKey,
      );

    },
  ),
    ),
  ],
   ),
), 

     AnimatedContainer(
    duration: const Duration(
  milliseconds: 300,
),

curve: Curves.easeInOut,
    
  margin: const EdgeInsets.only(bottom: 12),

  decoration: BoxDecoration(

    borderRadius: BorderRadius.circular(14),

    gradient: LinearGradient(

      colors: selectedIndex == 3

          ? [

              Colors.redAccent.withValues(alpha: 0.35),

              Colors.redAccent.withValues(alpha: 0.12),

            ]

          : [

              Colors.transparent,

              Colors.transparent,

            ],
    ),
  ),

  child: Row(
  children: [

    Container(
      width: 5,
      height: 72,

      decoration: BoxDecoration(
        color: selectedIndex == 3
            ? Colors.redAccent
            : Colors.transparent,

        borderRadius:
            BorderRadius.circular(10),
      ),
    ),

    Expanded(
      child: ListTile(

    leading: const Icon(
      Icons.groups,
      color: Colors.white,
    ),

    title: const Text(
      "Clubs & Societies",
      style: TextStyle(
        color: Colors.white,
      ),
    ),

    onTap: () {

      navigateToSection(
        3,
        clubsKey,
      );

    },
  ),
    ),
  ],
  ),
),


     AnimatedContainer(
      duration: const Duration(
  milliseconds: 300,
),

curve: Curves.easeInOut,

  margin: const EdgeInsets.only(bottom: 12),

  decoration: BoxDecoration(

    borderRadius: BorderRadius.circular(14),

    gradient: LinearGradient(

      colors: selectedIndex == 4

          ? [

              Colors.redAccent.withValues(alpha: 0.35),

              Colors.redAccent.withValues(alpha: 0.12),

            ]

          : [

              Colors.transparent,

              Colors.transparent,

            ],
    ),
  ),

  child: Row(
  children: [

    Container(
      width: 5,
      height: 72,

      decoration: BoxDecoration(
        color: selectedIndex == 4
            ? Colors.redAccent
            : Colors.transparent,

        borderRadius:
            BorderRadius.circular(10),
      ),
    ),

    Expanded(
      child: ListTile(

    leading: const Icon(
      Icons.flash_on,
      color: Colors.white,
    ),

    title: const Text(
      "Quick Access",
      style: TextStyle(
        color: Colors.white,
      ),
    ),

    onTap: () {

      navigateToSection(
        4,
        quickKey,
      );

    },
  ),
    ),
  ],
  ),
),

  AnimatedContainer(

    duration: const Duration(
  milliseconds: 300,
),

curve: Curves.easeInOut,

  margin: const EdgeInsets.only(bottom: 12),

  decoration: BoxDecoration(

    borderRadius: BorderRadius.circular(14),

    gradient: LinearGradient(

      colors: selectedIndex == 5

          ? [

              Colors.redAccent.withValues(alpha: 0.35),

              Colors.redAccent.withValues(alpha: 0.12),

            ]

          : [

              Colors.transparent,

              Colors.transparent,

            ],
    ),
  ),

  child: Row(
  children: [

    Container(
      width: 5,
      height: 72,

      decoration: BoxDecoration(
        color: selectedIndex == 5
            ? Colors.redAccent
            : Colors.transparent,

        borderRadius:
            BorderRadius.circular(10),
      ),
    ),

    Expanded(
      child: ListTile(

    leading: const Icon(
      Icons.info_outline,
      color: Colors.white,
    ),

    title: const Text(
      "About Us",
      style: TextStyle(
        color: Colors.white,
      ),
    ),

    onTap: () {

      navigateToSection(
        5,
        aboutKey,
      );

    },
  ),
    ),
  ],
  ),
), 

      const SizedBox(height: 50),

      AnimatedContainer(
           duration: const Duration(
  milliseconds: 300,
),

curve: Curves.easeInOut,

        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),

          gradient: LinearGradient(
            colors: [
              Colors.redAccent.withValues(alpha: 0.25),
              Colors.black,
            ],
          ),
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Text(
              "💎 PRO TIP",
              style: GoogleFonts.poppins(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Check back daily\nfor new events!",
              style: GoogleFonts.poppins(
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),

      const SizedBox(height: 20),
    ],
  ),
),

  backgroundColor: const Color(0xFF050816),

  body: SingleChildScrollView(
        child: Stack(
          children: [

            // HERO IMAGE

            SizedBox(
              width: double.infinity,
              height: 600,

              child: Image.asset(
                "assets/images/hero_new.jpeg",
                fit: BoxFit.cover,
              ),
            ),

            // DARK OVERLAY

            Container(
              width: double.infinity,
              height: 600,

              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,

                  colors: [

                    Colors.black.withValues(alpha: 0.25),

                    Colors.black.withValues(alpha: 0.55),

                    const Color(0xFF050816),

                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                top: 180,
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const SizedBox(height: 100),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),

                    child: Text(
                      "LNMIIT EXCLUSIVE",

                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  Text(
                    "THE C-CELL APP",

                    style: GoogleFonts.bebasNeue(
                      color: Colors.white,
                      fontSize: 82,
                      letterSpacing: 3,
                      height: 1,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    "LNMIIT's Ultimate Campus Experience\nEvents, Clubs and Everything Campus.",

                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 18,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 35),

                  Row(
                    children: [

                      Builder(
  builder: (context) {
    return ElevatedButton.icon(

      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,

        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 18,
        ),
      ),

      onPressed: () {
        Scaffold.of(context).openDrawer();
      },

      icon: const Icon(Icons.grid_view_rounded),

      label: Text(
        "Explore",
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  },
),

                      const SizedBox(width: 15),

                      ElevatedButton.icon(

                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          Colors.white.withValues(alpha: 0.15),

                          foregroundColor: Colors.white,

                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 18,
                          ),
                        ),

                        onPressed: () {},

                        icon: const Icon(Icons.info_outline),

                        label: Text(
                          "More Info",

                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 100),

  Container(
  key: eventsKey,
),

  Text(
  "EVENTS FOR FRESHERS",
  style: GoogleFonts.bebasNeue(
    color: Colors.white,
    fontSize: 34,
    letterSpacing: 2,
  ),
),

const SizedBox(height: 20),

SizedBox(
  height: 220,

  child: ListView(
    scrollDirection: Axis.horizontal,

    children: [
       buildPosterCard(
        0,
  "assets/images/treasure_hunt.jpeg",
  "Treasure Hunt",
),

buildPosterCard(
  1,
  "assets/images/y25_talent.jpeg",
  "Y25 Got Talent",
),

buildPosterCard(
  2,
  "assets/images/duologue.jpeg",
  "Duologue",
),

buildPosterCard(
  3,
  "assets/images/dalgona.jpeg",
  "Dalgona Trials",
),

buildPosterCard(
  4,
  "assets/images/astro_lens.jpeg",
  "Astro Lens",
),

buildPosterCard(
  5,
  "assets/images/freshers_quiz.jpeg",
  "Freshers Quiz",
),

buildPosterCard(
  6,
  "assets/images/survive_skies.jpeg",
  "Survive The Skies",
),

buildPosterCard(
  7,
  "assets/images/agree_disagree.jpeg",
  "Agree To Disagree",
),

buildPosterCard(
  8,
  "assets/images/micro_mayhem.jpeg",
  "Micro Mayhem",
),

buildPosterCard(
  9,
  "assets/images/dance_workshop.jpeg",
  "Dance Workshop",
),

buildPosterCard(
  10,
  "assets/images/imaginarium.jpeg",
  "Imaginarium",
),

buildPosterCard(
  11,
  "assets/images/casecraft.jpeg",
  "Casecraft",
),

buildPosterCard(
  12,
  "assets/images/photowalk.jpeg",
  "Photowalk",
),

buildPosterCard(
  13,
  "assets/images/market_moguls.jpeg",
  "Market Moguls",
),

buildPosterCard(
  14,
  "assets/images/batch_photography.jpeg",
  "Batch Photography",
),
     
    ],
  ),
),
    const SizedBox(height: 60),

  Container(
  key: gymkhanaKey,
),

  Text(
  "STUDENT GYMKHANA",
  style: GoogleFonts.bebasNeue(
    color: Colors.white,
    fontSize: 34,
    letterSpacing: 2,
  ),
),

const SizedBox(height: 20),

SizedBox(
  height: 220,
  child: ListView(
    scrollDirection: Axis.horizontal,

    children: [

      buildEventCard(
        100,
        Colors.redAccent,
        Icons.account_balance,
        "Office Bearers",
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const OfficeBearersPage(),
            ),
          );
        },
      ),

      buildEventCard(
        101,
        Colors.deepPurple,
        Icons.groups,
        "Councils",
      ),

      buildEventCard(
        102,
        Colors.teal,
        Icons.celebration,
        "Student Fests",
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const StudentFestsPage(),
            ),
          );
        },
      ),

      buildEventCard(
        103,
        Colors.indigo,
        Icons.event,
        "Events",
      ),

    ],
  ),
),

const SizedBox(height: 60),

Container(
  key: trendingKey,
),

Text(
  "TRENDING ON CAMPUS",
  style: GoogleFonts.bebasNeue(
    color: Colors.white,
    fontSize: 34,
    letterSpacing: 2,
  ),
),

const SizedBox(height: 20),

SizedBox(
  height: 220,
  child: ListView(
    scrollDirection: Axis.horizontal,

    children: [
      
      
      buildEventCard(
        200,
        Colors.pink,
        Icons.campaign,
        "Campus Buzz",
      ),

      buildEventCard(
        201,
        Colors.orange,
        Icons.local_fire_department,
        "Vivacity Merch",
      ),

      buildEventCard(
        202,
        Colors.red,
        Icons.architecture,
        "Plinth Merch",
      ),

      buildEventCard(
        203,
        Colors.blueGrey,
        Icons.sports_esports,
        "Desportivos Merch",
      ),


    ],
  ),
),

const SizedBox(height: 60),

Container(
  key: clubsKey,
),

Text(
  "CLUBS & SOCIETIES",
  style: GoogleFonts.bebasNeue(
    color: Colors.white,
    fontSize: 34,
    letterSpacing: 2,
  ),
),

const SizedBox(height: 20),

SizedBox(
  height: 220,
  child: ListView(
    scrollDirection: Axis.horizontal,

    children: [

      buildEventCard(
        300,
        Colors.purple,
        Icons.palette,
        "Cultural",
      ),

      buildEventCard(
        301,
        Colors.green,
        Icons.science,
        "Technical",
      ),

      buildEventCard(
        302,
        Colors.blue,
        Icons.sports,
        "Sports",
      ),

      buildEventCard(
        303,
        Colors.amber,
        Icons.volunteer_activism,
        "Social",
      ),

    ],
  ),
),

const SizedBox(height: 60),

Container(
  key: quickKey,
),

Text(
  "QUICK ACCESS",
  style: GoogleFonts.bebasNeue(
    color: Colors.white,
    fontSize: 34,
    letterSpacing: 2,
  ),
),

const SizedBox(height: 20),

SizedBox(
  height: 220,
  child: ListView(
    scrollDirection: Axis.horizontal,

    children: [

      
      buildEventCard(
        400,
        Colors.indigo,
        Icons.calendar_month,
        "Academic Calendar",
      ),

      buildEventCard(
        401,
        Colors.teal,
        Icons.map,
        "Campus Map",
      ),

      buildEventCard(
        402,
        Colors.deepOrange,
        Icons.restaurant,
        "Mess Menu",
      ),

      buildEventCard(
        403,
        Colors.pink,
        Icons.map,
        "Bus Schedule",
      ),

      buildEventCard(
        404,
        Colors.redAccent,
        Icons.phone,
        "Emergency",
      ),

    ],
  ),
),

const SizedBox(height: 60),

Container(
  key: aboutKey,
),

Text(
  "CONTINUE YOUR JOURNEY",
  style: GoogleFonts.bebasNeue(
    color: Colors.white,
    fontSize: 34,
    letterSpacing: 2,
  ),
),

const SizedBox(height: 20),

GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MorePage(),
      ),
    );
  },

  child: Container(
    height: 180,
    width: double.infinity,

    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),

      image: const DecorationImage(
        image: AssetImage(
          "assets/images/team_poster.jpeg",
        ),
        fit: BoxFit.cover,
      ),
    ),

    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),

        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,

          colors: [
            Colors.black.withValues(alpha: 0.2),
            Colors.black.withValues(alpha: 0.8),
          ],
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,

          children: [

            Text(
              "ABOUT US",
              style: GoogleFonts.bebasNeue(
                color: Colors.white,
                fontSize: 40,
                letterSpacing: 2,
              ),
            ),

            Text(
              "Meet the C-CELL Team",
              style: GoogleFonts.poppins(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    ),
  ),
),

const SizedBox(height: 60),  
  

const SizedBox(height: 50),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
 Widget buildEventCard(
  int index,
  Color color,
  IconData icon,
  String title, {
  VoidCallback? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: MouseRegion(
      onEnter: (_) {
        setState(() {
          hoveredCard = index;
        });
      },
      onExit: (_) {
        setState(() {
          hoveredCard = -1;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 250,
        ),
        width: hoveredCard == index ? 185 : 170,
        margin: EdgeInsets.only(
          right: 15,
          top: hoveredCard == index ? 0 : 10,
          bottom: hoveredCard == index ? 10 : 0,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.9),
              color.withValues(alpha: 0.5),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: hoveredCard == index
              ? [
                  BoxShadow(
                    color: color.withValues(
                      alpha: 0.45,
                    ),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: hoveredCard == index ? 50 : 45,
              ),
              const Spacer(),
              Text(
                title,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: hoveredCard == index ? 22 : 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget buildPosterCard(
  int index,
  String image,
  String title,
) {
  return MouseRegion(

    onEnter: (_) {
      setState(() {
        hoveredCard = index;
      });
    },

    onExit: (_) {
      setState(() {
        hoveredCard = -1;
      });
    },

    child: AnimatedContainer(

      duration: const Duration(
        milliseconds: 250,
      ),

      width: hoveredCard == index
          ? 185
          : 170,

      margin: EdgeInsets.only(
        right: 15,
        top: hoveredCard == index
            ? 0
            : 10,

        bottom: hoveredCard == index
            ? 10
            : 0,
      ),

      decoration: BoxDecoration(

        borderRadius:
            BorderRadius.circular(20),

        boxShadow:
            hoveredCard == index
                ? [
                    BoxShadow(
                      color: Colors
                          .redAccent
                          .withValues(
                            alpha: 0.4,
                          ),
                      blurRadius: 25,
                      spreadRadius: 3,
                    ),
                  ]
                : [],

        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),

      child: Container(

        decoration: BoxDecoration(

          borderRadius:
              BorderRadius.circular(20),

          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,

            colors: [
              Colors.transparent,
              Colors.black87,
            ],
          ),
        ),

        child: Padding(
          padding: const EdgeInsets.all(
            16,
          ),

          child: Align(
            alignment:
                Alignment.bottomLeft,

            child: Text(
              title,

              style:
                  GoogleFonts.bebasNeue(
                color: Colors.white,
                fontSize:
                    hoveredCard ==
                            index
                        ? 31
                        : 28,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

}
