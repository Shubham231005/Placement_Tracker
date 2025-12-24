import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../constants.dart'; // Make sure this file exists!

class VoiceAgentScreen extends StatefulWidget {
  const VoiceAgentScreen({super.key});

  @override
  State<VoiceAgentScreen> createState() => _VoiceAgentScreenState();
}

class _VoiceAgentScreenState extends State<VoiceAgentScreen> {
  final TextEditingController _controller = TextEditingController();
  final FlutterTts flutterTts = FlutterTts();

  String _status = "Shinobi Online 🟢";
  String _aiResponse = "";
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initVoice();
  }

  // 🗣️ SETUP: Tries to find a better "Human" voice
  void _initVoice() async {
    await flutterTts.setLanguage("en-US");

    // 1. Pitch 1.0 is normal, 0.5 is deep/robot, 1.2 is energetic
    await flutterTts.setPitch(1.0);

    // 2. Rate 0.4 is conversational (not too fast)
    await flutterTts.setSpeechRate(0.4);

    // 3. Try to pick a high-quality voice if available
    try {
      List<dynamic> voices = await flutterTts.getVoices;
      // Look for "network" or "quality" voices usually hidden by default
      var bestVoice = voices.firstWhere(
          (v) =>
              v["name"].toString().contains("en-us") &&
              v["name"].toString().toLowerCase().contains("network"),
          orElse: () => null);

      if (bestVoice != null) {
        await flutterTts.setVoice(
            {"name": bestVoice["name"], "locale": bestVoice["locale"]});
        print("✅ Using Enhanced Voice: ${bestVoice["name"]}");
      }
    } catch (e) {
      print("⚠️ Using default system voice");
    }
  }

  Future<void> _sendMessage() async {
    if (_controller.text.isEmpty) return;
    FocusScope.of(context).unfocus();

    setState(() {
      _isLoading = true;
      _status = "Thinking... 🧠";
      _aiResponse = "";
    });

    try {
      // 📡 Uses the URL from your constants.dart file
      final response = await http.post(
        Uri.parse(AppConstants.aiApiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"query": _controller.text}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String aiReply = data['response'];

        setState(() {
          _status = "Speaking... 🗣️";
          _aiResponse = aiReply;
        });

        await flutterTts.speak(aiReply);

        setState(() => _status = "Shinobi Online 🟢");
      } else {
        setState(() => _status = "Server Error: ${response.statusCode}");
      }
    } catch (e) {
      setState(() => _status = "Connection Failed ❌");
      print("Error: $e");
    } finally {
      setState(() => _isLoading = false);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AI COACH",
            style: GoogleFonts.teko(fontSize: 24, letterSpacing: 2)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Status Badge
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(20),
                  border:
                      Border.all(color: Colors.cyanAccent.withOpacity(0.3))),
              child: Text(
                _status,
                style:
                    GoogleFonts.poppins(fontSize: 12, color: Colors.cyanAccent),
              ),
            ),

            const SizedBox(height: 20),

            // AI Response Area
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                    color: const Color(0xFF1E1E24),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white12),
                    boxShadow: [
                      BoxShadow(color: Colors.black45, blurRadius: 10)
                    ]),
                child: SingleChildScrollView(
                  child: Text(
                    _aiResponse.isEmpty
                        ? "Ready to prepare for placements.\nAsk me about DSA, Projects, or Interviews."
                        : _aiResponse,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: _aiResponse.isEmpty ? Colors.grey : Colors.white,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Input Area
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: GoogleFonts.poppins(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFF1E1E24),
                      hintText: "Type your question...",
                      hintStyle: GoogleFonts.poppins(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: _isLoading ? null : _sendMessage,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: const Color(0xFF00E5FF),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0xFF00E5FF).withOpacity(0.3),
                              blurRadius: 10)
                        ]),
                    child: _isLoading
                        ? const Padding(
                            padding: EdgeInsets.all(12),
                            child:
                                CircularProgressIndicator(color: Colors.black))
                        : const Icon(Icons.send_rounded, color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
