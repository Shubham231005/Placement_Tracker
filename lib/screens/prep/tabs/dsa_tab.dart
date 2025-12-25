import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/glass_card.dart';

class DSATab extends StatelessWidget {
  const DSATab({super.key});

  @override
  Widget build(BuildContext context) {
    final topics = [
      {"name": "Arrays & Hashing", "solved": 45, "total": 50, "difficulty": "Easy", "color": AppColors.accent1},
      {"name": "Two Pointers", "solved": 18, "total": 20, "difficulty": "Medium", "color": AppColors.accent3},
      {"name": "Sliding Window", "solved": 12, "total": 15, "difficulty": "Medium", "color": AppColors.accent3},
      {"name": "Stack & Queue", "solved": 22, "total": 25, "difficulty": "Easy", "color": AppColors.accent1},
      {"name": "Binary Search", "solved": 15, "total": 20, "difficulty": "Medium", "color": AppColors.accent3},
      {"name": "Linked List", "solved": 18, "total": 22, "difficulty": "Medium", "color": AppColors.accent3},
      {"name": "Trees", "solved": 25, "total": 40, "difficulty": "Hard", "color": AppColors.accent2},
      {"name": "Graphs", "solved": 10, "total": 35, "difficulty": "Hard", "color": AppColors.accent2},
      {"name": "Dynamic Programming", "solved": 8, "total": 50, "difficulty": "Hard", "color": AppColors.accent2},
      {"name": "Backtracking", "solved": 5, "total": 15, "difficulty": "Hard", "color": AppColors.accent2},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          // Stats Summary
          _buildStatsSummary(),
          const SizedBox(height: 20),
          
          // Platform Progress
          _buildPlatformProgress(),
          const SizedBox(height: 20),
          
          // Topics List
          ...topics.map((topic) => _buildTopicCard(topic)),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildStatsSummary() {
    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatColumn("178", "Solved", AppColors.accent1),
            _buildDivider(),
            _buildStatColumn("292", "Total", AppColors.textSecondary),
            _buildDivider(),
            _buildStatColumn("61%", "Accuracy", AppColors.primary),
            _buildDivider(),
            _buildStatColumn("12", "Streak 🔥", AppColors.accent3),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.white.withOpacity(0.1),
    );
  }

  Widget _buildPlatformProgress() {
    return Row(
      children: [
        Expanded(child: _buildPlatformCard("LeetCode", 120, AppColors.accent3)),
        const SizedBox(width: 12),
        Expanded(child: _buildPlatformCard("GFG", 58, AppColors.accent1)),
      ],
    );
  }

  Widget _buildPlatformCard(String name, int count, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.code, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                "$count solved",
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopicCard(Map<String, dynamic> topic) {
    final progress = topic["solved"] / topic["total"];
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      topic["name"],
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${topic["solved"]} / ${topic["total"]} problems",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: (topic["color"] as Color).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  topic["difficulty"],
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: topic["color"] as Color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation(topic["color"] as Color),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}
