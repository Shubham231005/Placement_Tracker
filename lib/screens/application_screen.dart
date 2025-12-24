import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart'; // Add this to pubspec.yaml if missing

class ApplicationsScreen extends StatefulWidget {
  const ApplicationsScreen({super.key});

  @override
  State<ApplicationsScreen> createState() => _ApplicationsScreenState();
}

class _ApplicationsScreenState extends State<ApplicationsScreen> {
  final _supabase = Supabase.instance.client;

  // 📡 Stream: Listens to the database in real-time
  late final Stream<List<Map<String, dynamic>>> _applicationsStream;

  @override
  void initState() {
    super.initState();
    // Fetch all applications, ordered by newest first
    _applicationsStream = _supabase
        .from('applications')
        .stream(primaryKey: ['id'])
        .order('applied_date', ascending: false);
  }

  // 🎨 Helper: Get Color based on Status
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Offer': return const Color(0xFF00E5FF); // Cyber Cyan
      case 'Interview': return Colors.orangeAccent;
      case 'OA Received': return Colors.purpleAccent;
      case 'Rejected': return Colors.redAccent;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F13),
      appBar: AppBar(
        title: Text("APPLICATIONS", style: GoogleFonts.teko(fontSize: 24, letterSpacing: 2)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart, color: Colors.white54),
            onPressed: () {
              // TODO: Show stats (e.g., 10 applied, 2 interviews)
            }
          )
        ],
      ),

      // ➕ FLOATING ACTION BUTTON (Add New)
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddApplicationSheet(context),
        backgroundColor: const Color(0xFF00E5FF),
        child: const Icon(Icons.add, color: Colors.black),
      ),

      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _applicationsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF00E5FF)));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.work_outline, size: 60, color: Colors.white24),
                  const SizedBox(height: 20),
                  Text("No Applications Yet", style: GoogleFonts.poppins(color: Colors.white54)),
                  Text("Start applying to get hired! 🚀", style: GoogleFonts.poppins(color: Colors.white24, fontSize: 12)),
                ],
              ),
            );
          }

          final apps = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: apps.length,
            itemBuilder: (context, index) {
              final app = apps[index];
              return _buildApplicationCard(app);
            },
          );
        },
      ),
    );
  }

  Widget _buildApplicationCard(Map<String, dynamic> app) {
    Color statusColor = _getStatusColor(app['status']);

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E24),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white10),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. Company Icon (Placeholder)
          Container(
            height: 50, width: 50,
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                app['company_name'][0].toUpperCase(),
                style: GoogleFonts.teko(fontSize: 24, fontWeight: FontWeight.bold, color: statusColor),
              ),
            ),
          ),
          const SizedBox(width: 15),

          // 2. Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(app['company_name'], style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16)),
                Text(app['role'] ?? 'Software Engineer', style: GoogleFonts.poppins(fontSize: 12, color: Colors.white54)),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 12, color: Colors.white24),
                    const SizedBox(width: 5),
                    Text(
                      app['applied_date'] ?? 'Unknown Date',
                      style: GoogleFonts.poppins(fontSize: 10, color: Colors.white24)
                    ),
                  ],
                )
              ],
            ),
          ),

          // 3. Status Badge (Clickable to change)
          InkWell(
            onTap: () => _showStatusPicker(context, app['id'], app['status']),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: statusColor.withOpacity(0.5)),
              ),
              child: Text(
                app['status'].toUpperCase(),
                style: GoogleFonts.teko(fontSize: 12, fontWeight: FontWeight.bold, color: statusColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 📝 BOTTOM SHEET: Add New Application
  void _showAddApplicationSheet(BuildContext context) {
    final companyCtrl = TextEditingController();
    final roleCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E1E24),
      isScrollControlled: true, // Allow full keyboard view
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20, right: 20, top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("TRACK NEW APPLICATION", style: GoogleFonts.teko(fontSize: 20, color: Colors.white)),
              const SizedBox(height: 20),

              _buildTextField(companyCtrl, "Company Name", Icons.business),
              const SizedBox(height: 15),
              _buildTextField(roleCtrl, "Role (e.g. Backend Intern)", Icons.person_outline),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00E5FF)),
                  onPressed: () async {
                    if (companyCtrl.text.isEmpty) return;

                    // SAVE TO SUPABASE
                    await _supabase.from('applications').insert({
                      'user_id': _supabase.auth.currentUser!.id, // Ensure user is logged in!
                      'company_name': companyCtrl.text,
                      'role': roleCtrl.text,
                      'status': 'Applied',
                      'applied_date': DateTime.now().toIso8601String(),
                    });

                    Navigator.pop(context);
                  },
                  child: Text("ADD TRACKER", style: GoogleFonts.teko(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  // 🔄 DIALOG: Change Status
  void _showStatusPicker(BuildContext context, int id, String currentStatus) {
    final statuses = ['Applied', 'OA Received', 'Interview', 'Offer', 'Rejected'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E24),
        title: Text("Update Status", style: GoogleFonts.teko(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: statuses.map((status) => ListTile(
            title: Text(status, style: GoogleFonts.poppins(color: Colors.white70)),
            trailing: status == currentStatus ? const Icon(Icons.check, color: Color(0xFF00E5FF)) : null,
            onTap: () async {
              await _supabase.from('applications').update({'status': status}).eq('id', id);
              Navigator.pop(context);
            },
          )).toList(),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController ctrl, String hint, IconData icon) {
    return TextField(
      controller: ctrl,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white24),
        prefixIcon: Icon(icon, color: Colors.white54),
        filled: true,
        fillColor: Colors.black26,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
    );
  }
}