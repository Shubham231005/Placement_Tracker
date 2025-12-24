// lib/screens/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/daily_goals.dart';
import 'voice_agent_screen.dart';
import 'application_screen.dart'; // <--- 1. IMPORT THE NEW SCREEN

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "STUDENT OS",
          style: GoogleFonts.teko(fontSize: 24, letterSpacing: 2),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Supabase Goals Widget
            const DailyGoalsWidget(),
            const SizedBox(height: 25),

            // 2. Navigation Grid
            Text(
              "TOOLS",
              style: GoogleFonts.teko(fontSize: 20, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 1.5,
              children: [
                // CARD 1: AI COACH
                _buildCard(
                  context,
                  Icons.mic_none_outlined, // Changed icon to Mic
                  "AI Coach",
                  Colors.pinkAccent,
                  const VoiceAgentScreen(),
                ),

                // CARD 2: APPLICATIONS TRACKER (NEW! 🚀)
                _buildCard(
                  context,
                  Icons.work_outline,
                  "Applications",
                  const Color(0xFF00E5FF), // Cyber Cyan
                  const ApplicationsScreen(),
                ),

                // CARD 3: DSA (Placeholder)
                _buildCard(
                  context,
                  Icons.code,
                  "DSA Tracker",
                  Colors.orange,
                  null,
                ),

                // CARD 4: NOTES (Placeholder)
                _buildCard(
                  context,
                  Icons.book,
                  "Notes",
                  Colors.green,
                  null
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
    BuildContext context,
    IconData icon,
    String title,
    Color color,
    Widget? page,
  ) {
    return InkWell(
      onTap: () {
        if (page != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        } else {
          // Show a "Coming Soon" message for empty cards
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text("$title is coming soon! 🚧"), backgroundColor: Colors.grey[900]),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E24),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.withOpacity(0.3)),
          boxShadow: [
             BoxShadow(
               color: color.withOpacity(0.1),
               blurRadius: 10,
               offset: const Offset(0, 4)
             )
          ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: color),
            const SizedBox(height: 10),
            Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}