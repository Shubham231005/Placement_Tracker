import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';

class ApplicationsScreen extends StatefulWidget {
  const ApplicationsScreen({super.key});

  @override
  State<ApplicationsScreen> createState() => _ApplicationsScreenState();
}

class _ApplicationsScreenState extends State<ApplicationsScreen> {
  String _selectedFilter = "All";
  
  final List<String> _filters = ["All", "Applied", "OA", "Interview", "Offer", "Rejected"];
  
  final List<Map<String, dynamic>> _applications = [
    {
      "company": "Google",
      "role": "Software Engineer",
      "status": "Interview",
      "date": "Dec 25",
      "skills": ["DSA", "System Design"],
      "readiness": 85,
      "logo": "G",
      "color": Color(0xFF4285F4),
    },
    {
      "company": "Amazon",
      "role": "SDE-1",
      "status": "OA",
      "date": "Dec 22",
      "skills": ["DSA", "Java", "AWS"],
      "readiness": 72,
      "logo": "A",
      "color": Color(0xFFFF9900),
    },
    {
      "company": "Microsoft",
      "role": "Software Developer",
      "status": "Applied",
      "date": "Dec 20",
      "skills": ["C++", "Azure", "System Design"],
      "readiness": 68,
      "logo": "M",
      "color": Color(0xFF00A4EF),
    },
    {
      "company": "TCS",
      "role": "Systems Engineer",
      "status": "Offer",
      "date": "Dec 15",
      "skills": ["Java", "SQL"],
      "readiness": 90,
      "logo": "T",
      "color": Color(0xFF0072C6),
    },
    {
      "company": "Infosys",
      "role": "Associate",
      "status": "Interview",
      "date": "Dec 18",
      "skills": ["Python", "SQL"],
      "readiness": 78,
      "logo": "I",
      "color": Color(0xFF007CC3),
    },
    {
      "company": "Wipro",
      "role": "Project Engineer",
      "status": "Rejected",
      "date": "Dec 10",
      "skills": ["Java", "SQL"],
      "readiness": 65,
      "logo": "W",
      "color": Color(0xFF4C2889),
    },
  ];

  List<Map<String, dynamic>> get _filteredApplications {
    if (_selectedFilter == "All") return _applications;
    return _applications.where((app) => app["status"] == _selectedFilter).toList();
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
                    "Applications",
                    style: GoogleFonts.inter(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Track your job applications",
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
            
            // Filter Chips
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _filters.length,
                itemBuilder: (context, index) {
                  final filter = _filters[index];
                  final isSelected = _selectedFilter == filter;
                  
                  return GestureDetector(
                    onTap: () => setState(() => _selectedFilter = filter),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : Colors.white.withOpacity(0.1),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        filter,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? Colors.white : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            
            // Applications List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                physics: const BouncingScrollPhysics(),
                itemCount: _filteredApplications.length,
                itemBuilder: (context, index) {
                  return _buildApplicationCard(_filteredApplications[index]);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          "Add Application",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
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
            _buildStatItem("15", "Applied", AppColors.primary),
            _buildDivider(),
            _buildStatItem("4", "OA Done", AppColors.accent3),
            _buildDivider(),
            _buildStatItem("3", "Interviews", AppColors.accent2),
            _buildDivider(),
            _buildStatItem("1", "Offers", AppColors.accent1),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label, Color color) {
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
            fontSize: 11,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 35,
      width: 1,
      color: Colors.white.withOpacity(0.1),
    );
  }

  Widget _buildApplicationCard(Map<String, dynamic> app) {
    final statusColor = _getStatusColor(app["status"]);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Company Logo
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: (app["color"] as Color).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  app["logo"],
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: app["color"] as Color,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              
              // Company Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      app["company"],
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      app["role"],
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  app["status"],
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          
          // Skills & Readiness
          Row(
            children: [
              // Skills
              Expanded(
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: (app["skills"] as List).map((skill) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        skill,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: AppColors.textMuted,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              
              // Readiness Score
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${app["readiness"]}%",
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _getReadinessColor(app["readiness"]),
                    ),
                  ),
                  Text(
                    "Readiness",
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: app["readiness"] / 100,
              backgroundColor: Colors.white.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation(_getReadinessColor(app["readiness"])),
              minHeight: 4,
            ),
          ),
          const SizedBox(height: 10),
          
          // Date
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.calendar_today, size: 12, color: AppColors.textMuted),
              const SizedBox(width: 4),
              Text(
                app["date"],
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Applied":
        return AppColors.primary;
      case "OA":
        return AppColors.accent3;
      case "Interview":
        return AppColors.secondary;
      case "Offer":
        return AppColors.accent1;
      case "Rejected":
        return AppColors.error;
      default:
        return AppColors.textMuted;
    }
  }

  Color _getReadinessColor(int readiness) {
    if (readiness >= 80) return AppColors.accent1;
    if (readiness >= 60) return AppColors.accent3;
    return AppColors.error;
  }
}
