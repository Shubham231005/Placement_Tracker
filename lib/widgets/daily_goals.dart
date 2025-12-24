// 📂 File: lib/widgets/daily_goals.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Make sure this is imported for style

import '../services/supabase_service.dart'; // <--- 🚨 THIS IS THE FIX 🚨

class DailyGoalsWidget extends StatefulWidget {
  const DailyGoalsWidget({super.key});

  @override
  State<DailyGoalsWidget> createState() => _DailyGoalsWidgetState();
}

class _DailyGoalsWidgetState extends State<DailyGoalsWidget> {
  // Now "SupabaseService" will work because we imported it!
  final _supabase = SupabaseService();

  late Future<List<Map<String, dynamic>>> _goalsFuture;

  @override
  void initState() {
    super.initState();
    _refreshGoals();
  }

  void _refreshGoals() {
    setState(() {
      _goalsFuture = _supabase.getGoals();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.blue.shade900, const Color(0xFF1E1E24)]),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("DAILY LIMITS (LIVE)",
                  style: GoogleFonts.teko(fontSize: 18, color: Colors.white)),
              IconButton(
                  icon: const Icon(Icons.refresh,
                      size: 16, color: Colors.white54),
                  onPressed: _refreshGoals),
            ],
          ),
          const SizedBox(height: 15),
          FutureBuilder(
            future: _goalsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(color: Colors.cyanAccent));
              }
              if (snapshot.hasError) {
                return const Text("Error loading goals",
                    style: TextStyle(color: Colors.red));
              }

              final goals = snapshot.data as List<Map<String, dynamic>>;

              if (goals.isEmpty) {
                return const Text("No goals found in Supabase",
                    style: TextStyle(color: Colors.grey));
              }

              return Column(
                children: goals.map((goal) => _buildGoalRow(goal)).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGoalRow(Map<String, dynamic> goal) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Transform.scale(
            scale: 1.1,
            child: Checkbox(
              value: goal['is_completed'],
              activeColor: Colors.cyanAccent,
              checkColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              side: const BorderSide(color: Colors.white54),
              onChanged: (val) async {
                // Optimistic UI Update (looks faster)
                setState(() {
                  goal['is_completed'] = val;
                });
                // Actual DB Update
                await _supabase.updateGoal(goal['id'], val!);
              },
            ),
          ),
          Text(
            goal['task_name'],
            style: GoogleFonts.poppins(
              color: goal['is_completed'] ? Colors.white38 : Colors.white,
              decoration:
                  goal['is_completed'] ? TextDecoration.lineThrough : null,
            ),
          ),
        ],
      ),
    );
  }
}
