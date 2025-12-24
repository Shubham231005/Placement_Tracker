import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart'; // Ensure this file has your keys!
import 'screens/dashboard_screen.dart';

void main() async {
  // 1. Setup Flutter Binding (Required for Async code in main)
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Initialize the Supabase Database Connection
  // (Make sure you updated constants.dart with your actual keys)
  await Supabase.initialize(
    url: AppConstants.supabaseUrl,
    anonKey: AppConstants.supabaseAnonKey,
  );

  // 3. Run the App
  runApp(const PlacementApp());
}

class PlacementApp extends StatelessWidget {
  const PlacementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Placement OS',

      // 🎨 GLOBAL THEME SETUP
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F0F13), // Deep Space Black
        cardColor: const Color(0xFF1E1E24),               // Gunmetal Grey
        primaryColor: const Color(0xFF00E5FF),            // Cyber Cyan

        // Setup Google Fonts globally so you don't have to import it everywhere
        textTheme: GoogleFonts.poppinsTextTheme(
          ThemeData.dark().textTheme,
        ),

        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00E5FF),
          secondary: Color(0xFFFF0055), // Cyber Pink for accents
        ),
      ),

      // 🚀 START HERE
      home: const DashboardScreen(),
    );
  }
}
