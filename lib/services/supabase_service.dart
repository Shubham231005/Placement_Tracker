// lib/services/supabase_service.dart
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final _client = Supabase.instance.client;

  // Fetch Goals
  Future<List<Map<String, dynamic>>> getGoals() async {
    final response = await _client.from('daily_goals').select().order('id');
    return List<Map<String, dynamic>>.from(response);
  }

  // Update Goal Status
  Future<void> updateGoal(int id, bool status) async {
    await _client.from('daily_goals').update({'is_completed': status}).eq('id', id);
  }
}