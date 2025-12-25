import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/progress_ring.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // Profile Header
              _buildProfileHeader(),
              const SizedBox(height: 24),
              
              // Analytics Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle("Analytics Dashboard"),
                    const SizedBox(height: 16),
                    _buildAnalyticsCards(),
                    const SizedBox(height: 24),
                    
                    // Skills Analysis
                    _buildSectionTitle("Skill Analysis"),
                    const SizedBox(height: 16),
                    _buildSkillAnalysis(),
                    const SizedBox(height: 24),
                    
                    // Settings
                    _buildSectionTitle("Settings"),
                    const SizedBox(height: 16),
                    _buildSettingsList(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.2),
            AppColors.background,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          // Avatar with edit button
          Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  shape: BoxShape.circle,
                  boxShadow: AppShadows.glowShadow(AppColors.primary),
                ),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 50,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.background, width: 3),
                  ),
                  child: const Icon(
                    Icons.edit,
                    color: AppColors.primary,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          Text(
            "Shubham Kumar",
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "B.Tech CSE • CGPA 8.5",
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.school, size: 16, color: AppColors.textMuted),
              const SizedBox(width: 6),
              Text(
                "Graduation 2025",
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Role Tags
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildRoleTag("Backend Dev", AppColors.primary),
              const SizedBox(width: 8),
              _buildRoleTag("Full Stack", AppColors.secondary),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRoleTag(String role, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        role,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildAnalyticsCards() {
    return Row(
      children: [
        Expanded(
          child: _buildAnalyticsCard(
            "Streak",
            "12 Days",
            Icons.local_fire_department,
            AppColors.accent3,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildAnalyticsCard(
            "Consistency",
            "85%",
            Icons.trending_up,
            AppColors.accent1,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildAnalyticsCard(
            "Rank",
            "Top 15%",
            Icons.leaderboard,
            AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildAnalyticsCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 26),
          const SizedBox(height: 10),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillAnalysis() {
    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Strongest Skills",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.accent1,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildSkillBar("Python", 0.9, AppColors.accent1),
                      _buildSkillBar("REST APIs", 0.85, AppColors.accent1),
                      _buildSkillBar("SQL", 0.8, AppColors.accent1),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Needs Improvement",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.accent3,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildSkillBar("DP", 0.3, AppColors.accent3),
                      _buildSkillBar("Graphs", 0.4, AppColors.accent3),
                      _buildSkillBar("ML Basics", 0.35, AppColors.accent3),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.insights, color: AppColors.primary, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Focus on Dynamic Programming to boost your readiness by 15%",
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillBar(String skill, double progress, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                skill,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                "${(progress * 100).toInt()}%",
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation(color),
              minHeight: 5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsList() {
    final settings = [
      {"icon": Icons.notifications_outlined, "title": "Study Reminders", "hasSwitch": true, "enabled": true},
      {"icon": Icons.flash_on, "title": "Placement Season Mode", "hasSwitch": true, "enabled": false},
      {"icon": Icons.dark_mode_outlined, "title": "Dark Mode", "hasSwitch": true, "enabled": true},
      {"icon": Icons.download_outlined, "title": "Export Data (PDF)", "hasSwitch": false},
      {"icon": Icons.help_outline, "title": "Help & Support", "hasSwitch": false},
      {"icon": Icons.info_outline, "title": "About", "hasSwitch": false},
      {"icon": Icons.logout, "title": "Logout", "hasSwitch": false, "isDestructive": true},
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: settings.asMap().entries.map((entry) {
          final index = entry.key;
          final setting = entry.value;
          final isLast = index == settings.length - 1;
          final isDestructive = setting["isDestructive"] == true;
          
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    Icon(
                      setting["icon"] as IconData,
                      color: isDestructive ? AppColors.error : AppColors.textSecondary,
                      size: 22,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        setting["title"] as String,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          color: isDestructive ? AppColors.error : AppColors.textPrimary,
                        ),
                      ),
                    ),
                    if (setting["hasSwitch"] == true)
                      Switch(
                        value: setting["enabled"] == true,
                        onChanged: (v) {},
                        activeColor: AppColors.primary,
                      )
                    else
                      Icon(
                        Icons.chevron_right,
                        color: AppColors.textMuted,
                        size: 22,
                      ),
                  ],
                ),
              ),
              if (!isLast)
                Divider(
                  height: 1,
                  color: Colors.white.withOpacity(0.05),
                  indent: 52,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
