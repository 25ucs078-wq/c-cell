import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
    final String name;
    final String image;
    final String role;

  const ProfilePage({
    super.key,
    required this.name,
    required this.image,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050816),

      body: Stack(
        children: [

          SizedBox(
            width: double.infinity,
            height: double.infinity,

            child: Hero(
            tag: name,

            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,

                colors: [
                  Colors.black.withValues(alpha: 0.3),
                  Colors.black.withValues(alpha: 0.8),
                  Colors.black,
                ],
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(25),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),

                  const Spacer(),

                  Text(
                    name,

                    style: GoogleFonts.bebasNeue(
                      color: Colors.white,
                      fontSize: 52,
                      letterSpacing: 2,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    role,

                    style: GoogleFonts.poppins(
                      color: Colors.redAccent,
                      fontSize: 20,
                    ),
                  ),

                   const SizedBox(height: 30),

                    Container(
                      width: double.infinity,

                      padding: const EdgeInsets.all(20),

                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.06),

                        borderRadius: BorderRadius.circular(20),

                        border: Border.all(
                          color: Colors.redAccent.withValues(alpha: 0.3),
                        ),
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          Text(
                            "❝",

                            style: GoogleFonts.bebasNeue(
                              color: Colors.redAccent,
                              fontSize: 50,
                            ),
                          ),

                          Text(
                            "Making chaos look\nsurprisingly manageable.",

                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 18,
                              height: 1.5,
                            ),
                          ),

                          const SizedBox(height: 20),

                          Text(
                            "ABOUT",

                            style: GoogleFonts.bebasNeue(
                              color: Colors.redAccent,
                              fontSize: 28,
                              letterSpacing: 2,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            "Helping freshers settle into campus life and ensuring that nobody feels alone during their journey at LNMIIT.",

                            style: GoogleFonts.poppins(
                              color: Colors.white70,
                              fontSize: 16,
                              height: 1.7,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                                  Row(
                children: [

                  Expanded(
                    child: Container(
                      height: 55,

                      decoration: BoxDecoration(
                        color: const Color(0xFFB20710),

                        borderRadius: BorderRadius.circular(15),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.redAccent.withValues(alpha: 0.3),
                            blurRadius: 15,
                          ),
                        ],
                      ),

                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),

                        onPressed: () {},

                        icon: const Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),

                        label: Text(
                          "CALL",
                          style: GoogleFonts.bebasNeue(
                            color: Colors.white,
                            fontSize: 24,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 20),

                  Expanded(
                    child: Container(
                      height: 55,

                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.08),

                        borderRadius: BorderRadius.circular(15),

                        border: Border.all(
                          color: Colors.white24,
                        ),
                      ),

                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),

                        onPressed: () {},

                        icon: const Icon(
                          Icons.email,
                          color: Colors.white,
                        ),

                        label: Text(
                          "MAIL",
                          style: GoogleFonts.bebasNeue(
                            color: Colors.white,
                            fontSize: 24,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}