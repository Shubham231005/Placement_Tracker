import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/skill_card.dart';

class SkillsScreen extends StatefulWidget {
  const SkillsScreen({super.key});

  @override
  State<SkillsScreen> createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  final List<String> _categories = [
    "DSA",
    "Programming",
    "Backend",
    "ML/AI",
    "Core CS",
    "Soft Skills",
  ];

  final Map<String, List<Map<String, dynamic>>> _skillsData = {
    "DSA": [
      {"name": "Arrays & Strings", "level": "Advanced", "confidence": 8, "status": "Strong"},
      {"name": "Linked Lists", "level": "Intermediate", "confidence": 6, "status": "In Progress"},
      {"name": "Trees & Graphs", "level": "Intermediate", "confidence": 5, "status": "In Progress"},
      {"name": "Dynamic Programming", "level": "Beginner", "confidence": 3, "status": "Needs Work"},
      {"name": "Recursion", "level": "Advanced", "confidence": 7, "status": "Strong"},
    ],
    "Programming": [
      {"name": "Python", "level": "Advanced", "confidence": 9, "status": "Strong"},
      {"name": "Java", "level": "Intermediate", "confidence": 6, "status": "In Progress"},
      {"name": "JavaScript", "level": "Intermediate", "confidence": 7, "status": "Strong"},
      {"name": "C++", "level": "Beginner", "confidence": 4, "status": "In Progress"},
    ],
    "Backend": [
      {"name": "REST APIs", "level": "Advanced", "confidence": 8, "status": "Strong"},
      {"name": "SQL & Databases", "level": "Intermediate", "confidence": 6, "status": "In Progress"},
      {"name": "Node.js", "level": "Intermediate", "confidence": 7, "status": "Strong"},
      {"name": "Flask/Django", "level": "Beginner", "confidence": 4, "status": "In Progress"},
    ],
    "ML/AI": [
      {"name": "Machine Learning Basics", "level": "Intermediate", "confidence": 5, "status": "In Progress"},
      {"name": "Deep Learning", "level": "Beginner", "confidence": 3, "status": "Needs Work"},
      {"name": "Data Analysis", "level": "Intermediate", "confidence": 6, "status": "In Progress"},
    ],
    "Core CS": [
      {"name": "Operating Systems", "level": "Intermediate", "confidence": 6, "status": "In Progress"},
      {"name": "DBMS", "level": "Advanced", "confidence": 7, "status": "Strong"},
      {"name": "Computer Networks", "level": "Intermediate", "confidence": 5, "status": "In Progress"},
      {"name": "OOP Concepts", "level": "Advanced", "confidence": 8, "status": "Strong"},
    ],
    "Soft Skills": [
      {"name": "Communication", "level": "Intermediate", "confidence": 6, "status": "In Progress"},
      {"name": "Problem Solving", "level": "Advanced", "confidence": 8, "status": "Strong"},
      {"name": "Team Collaboration", "level": "Advanced", "confidence": 7, "status": "Strong"},
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Skills Hub",
                    style: GoogleFonts.inter(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Track and improve your competencies",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            
            // Stats Summary
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildStatsSummary(),
            ),
            const SizedBox(height: 20),
            
            // Category Tabs
            Container(
              height: 45,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.textMuted,
                labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14),
                unselectedLabelStyle: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 14),
                indicator: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                tabs: _categories.map((cat) => Tab(text: cat)).toList(),
              ),
            ),
            const SizedBox(height: 16),
            
            // Skills List
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: _categories.map((category) {
                  final skills = _skillsData[category] ?? [];
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    physics: const BouncingScrollPhysics(),
                    itemCount: skills.length,
                    itemBuilder: (context, index) {
                      final skill = skills[index];
                      return SkillCard(
                        name: skill["name"],
                        level: skill["level"],
                        confidence: skill["confidence"],
                        status: skill["status"],
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildStatsSummary() {
    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem("Total Skills", "24", AppColors.primary),
            _buildDivider(),
            _buildStatItem("Strong", "10", AppColors.accent1),
            _buildDivider(),
            _buildStatItem("In Progress", "11", AppColors.accent3),
            _buildDivider(),
            _buildStatItem("Needs Work", "3", AppColors.error),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 30,
      width: 1,
      color: Colors.white.withOpacity(0.1),
    );
  }
}
