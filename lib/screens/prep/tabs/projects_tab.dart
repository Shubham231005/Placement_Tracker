import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';

class ProjectsTab extends StatelessWidget {
  const ProjectsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = [
      {
        "name": "E-Commerce Platform",
        "techStack": ["React", "Node.js", "MongoDB"],
        "status": "Completed",
        "description": "Full-stack e-commerce with payment integration",
        "github": "github.com/user/ecommerce",
        "learnings": "REST APIs, JWT Auth, Stripe Integration",
      },
      {
        "name": "ML Stock Predictor",
        "techStack": ["Python", "TensorFlow", "Flask"],
        "status": "Completed",
        "description": "LSTM model for stock price prediction",
        "github": "github.com/user/stock-ml",
        "learnings": "LSTM, Data preprocessing, Model deployment",
      },
      {
        "name": "Chat Application",
        "techStack": ["Flutter", "Firebase", "Dart"],
        "status": "Building",
        "description": "Real-time chat with group features",
        "github": "",
        "learnings": "WebSockets, Real-time DB, Push notifications",
      },
      {
        "name": "Portfolio Website",
        "techStack": ["Next.js", "Tailwind", "Vercel"],
        "status": "Completed",
        "description": "Personal portfolio with blog",
        "github": "github.com/user/portfolio",
        "learnings": "SSR, SEO optimization, Markdown parsing",
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Stats
          _buildProjectStats(),
          const SizedBox(height: 20),
          
          // Projects List
          ...projects.map((project) => _buildProjectCard(project)),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildProjectStats() {
    return Row(
      children: [
        Expanded(child: _buildStatCard("3", "Completed", AppColors.accent1, Icons.check_circle)),
        const SizedBox(width: 12),
        Expanded(child: _buildStatCard("1", "Building", AppColors.accent3, Icons.construction)),
        const SizedBox(width: 12),
        Expanded(child: _buildStatCard("2", "Ideas", AppColors.primary, Icons.lightbulb)),
      ],
    );
  }

  Widget _buildStatCard(String value, String label, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> project) {
    final statusColor = project["status"] == "Completed" 
        ? AppColors.accent1 
        : project["status"] == "Building" 
            ? AppColors.accent3 
            : AppColors.primary;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  project["name"],
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  project["status"],
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Description
          Text(
            project["description"],
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          
          // Tech Stack
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: (project["techStack"] as List).map((tech) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                ),
                child: Text(
                  tech,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          
          // Learnings
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.lightbulb_outline, color: AppColors.accent3, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    project["learnings"],
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // GitHub Link
          if (project["github"].isNotEmpty) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.link, color: AppColors.secondary, size: 16),
                const SizedBox(width: 8),
                Text(
                  project["github"],
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
