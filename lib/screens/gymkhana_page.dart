import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/gymkhana_data.dart';
import 'council_detail_page.dart';
import 'club_detail_page.dart';
import 'fest_detail_page.dart';

class GymkhanaPage extends StatelessWidget {
  const GymkhanaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050816),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'GYMKHANA',
          style: GoogleFonts.bebasNeue(
            color: Colors.redAccent,
            fontSize: 32,
            letterSpacing: 2,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Executive Council'),
              const SizedBox(height: 16),
              ...gymkhanaExecutives.map((exec) => _buildExecutiveCard(exec)).toList(),

              const SizedBox(height: 40),
              _buildSectionTitle('Councils'),
              const SizedBox(height: 16),
              _buildCouncilCard(context, culturalCouncil),
              const SizedBox(height: 20),
              _buildCouncilCard(context, sportsCouncil),
              const SizedBox(height: 20),
              _buildCouncilCard(context, technologyCouncil),

              const SizedBox(height: 40),
              _buildSectionTitle('COSHA Committee'),
              const SizedBox(height: 16),
              _buildCoshaCard(context),

              const SizedBox(height: 40),
              _buildSectionTitle('Student Fests'),
              const SizedBox(height: 16),
              ...studentFests.map((fest) => _buildFestCard(context, fest)).toList(),

              const SizedBox(height: 40),
              _buildSectionTitle('Major Events'),
              const SizedBox(height: 16),
              ...studentEvents.map((event) => _buildFestCard(context, event)).toList(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.bebasNeue(
        color: Colors.white,
        fontSize: 28,
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _buildExecutiveCard(GymkhanaExecutive exec) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.redAccent.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, color: Colors.redAccent),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exec.name,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  exec.position,
                  style: GoogleFonts.poppins(
                    color: Colors.redAccent,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (exec.phone.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.phone, color: Colors.white70, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        exec.phone,
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCouncilCard(BuildContext context, CouncilData council) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CouncilDetailPage(council: council),
          ),
        );
      },
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(council.logoPath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withValues(alpha: 0.6),
              BlendMode.darken,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.redAccent.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: Text(
            council.name.toUpperCase(),
            style: GoogleFonts.bebasNeue(
              color: Colors.white,
              fontSize: 32,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFestCard(BuildContext context, FestData fest) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FestDetailPage(fest: fest),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(fest.logoPath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withValues(alpha: 0.6),
              BlendMode.darken,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.redAccent.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: Text(
            fest.name.toUpperCase(),
            style: GoogleFonts.bebasNeue(
              color: Colors.white,
              fontSize: 32,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCoshaCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ClubDetailPage(club: coshaCommittee),
          ),
        );
      },
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: const AssetImage('assets/images/cosha_logo.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withValues(alpha: 0.6),
              BlendMode.darken,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.redAccent.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: Text(
            'COSHA COMMITTEE',
            style: GoogleFonts.bebasNeue(
              color: Colors.white,
              fontSize: 32,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }
}
