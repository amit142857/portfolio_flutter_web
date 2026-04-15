import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const ModernPortfolioApp());
}

class ModernPortfolioApp extends StatelessWidget {
  const ModernPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amit Yadav | Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF060606),
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      home: const PortfolioScaffold(),
    );
  }
}

class PortfolioScaffold extends StatefulWidget {
  const PortfolioScaffold({super.key});

  @override
  State<PortfolioScaffold> createState() => _PortfolioScaffoldState();
}

class _PortfolioScaffoldState extends State<PortfolioScaffold> {
  final ScrollController _scrollController = ScrollController();
  final String cvUrl =
      "https://drive.google.com/file/d/1xH1Jm0hVWZhzmwGI9UEGWxh1NWqfGKeS/view?usp=share_link";

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: AppBar(
              backgroundColor: Colors.black.withOpacity(0.3),
              elevation: 0,
              title: const Text(
                'AMIT.DEV',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: -150,
            right: -100,
            child: _buildGlow(Colors.blueAccent.withOpacity(0.15)),
          ),
          Positioned(
            bottom: 100,
            left: -100,
            child: _buildGlow(Colors.cyanAccent.withOpacity(0.1)),
          ),
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                _buildHeroSection(),
                _buildProjectsGrid(),
                _buildExperienceTimeline(),
                _buildFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlow(Color color) {
    return Container(
      width: 500,
      height: 500,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: color, blurRadius: 250, spreadRadius: 50)],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "FLUTTER DEVELOPER",
            style: TextStyle(
              letterSpacing: 8,
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "AMIT YADAV",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width > 600 ? 80 : 40,
              fontWeight: FontWeight.w900,
              letterSpacing: -2,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Building robust, scalable mobile applications with Clean Architecture.",
            style: TextStyle(fontSize: 18, color: Colors.white54),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 20,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.description_outlined),
                label: const Text("VIEW FULL CV"),
                onPressed: () => _launchUrl(cvUrl),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 20,
                  ),
                ),
              ),
              OutlinedButton.icon(
                icon: const Icon(Icons.mail_outline),
                label: const Text("GET IN TOUCH"),
                onPressed: () => _launchUrl("mailto:ydvamit82@gmail.com"),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 20,
                  ),
                  side: const BorderSide(color: Colors.white24),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "SELECTED WORKS",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Container(height: 4, width: 60, color: Colors.blueAccent),
          const SizedBox(height: 50),
          LayoutBuilder(
            builder: (context, constraints) {
              int columns = constraints.maxWidth > 1100 ? 2 : 1;
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: columns,
                crossAxisSpacing: 30,
                mainAxisSpacing: 30,
                childAspectRatio: constraints.maxWidth > 600 ? 1.5 : 0.8,
                children: [
                  _projectCard(
                    "Calilio",
                    "VoIP-based application using Twilio voice for calls and SMS.",
                    "Integrated Twilio Services for VoIP calling, implemented GraphQL API, and translated complex Figma designs into responsive UI.",
                    "Flutter, Dart, GraphQL, Twilio, Bloc, Clean Architecture",
                    "https://www.calilio.com",
                  ),
                  _projectCard(
                    "Drop Social Media",
                    "A Social media app with offline support and WebSocket integration for real-time interaction.",
                    "Lead the mobile team, synchronized local caching with sqflite for offline uploads, and implemented WebSocket chat features.",
                    "Flutter, REST API, Websocket, Bloc, sqflite",
                    "https://play.google.com/store/apps/details?id=com.gcc.drop",
                  ),
                  _projectCard(
                    "Mume",
                    "Fintech application for Mume Group Qatar for secure online payments.",
                    "Integrated secure wallet loading via Credit/Debit cards and connected RESTful APIs for transaction history.",
                    "Flutter, Firebase, RESTful API, Payment Integration",
                    "https://play.google.com/store/apps/details?id=com.mume",
                  ),
                  _projectCard(
                    "SMS Receiver",
                    "Utility app for receiving OTPs via global virtual phone numbers.",
                    "Led the team to integrate RESTful APIs for dynamic number management and Webhooks for real-time message notifications.",
                    "Flutter, Webhooks, RESTful API, Real-time Updates",
                    "https://freesmstoday.com/",
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _projectCard(
    String title,
    String about,
    String role,
    String tech,
    String url,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      padding: const EdgeInsets.all(35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              IconButton(
                onPressed: () => _launchUrl(url),
                icon: const Icon(Icons.open_in_new, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            "ABOUT",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white38,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            about,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white70,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "MY ROLE",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white38,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            role,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white70,
              height: 1.4,
            ),
          ),
          const Spacer(),
          Text(
            tech,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.cyanAccent,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceTimeline() {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "WORK HISTORY",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),
          _timelineTile(
            "Ganesha Computing",
            "Mid-Level Flutter Developer",
            "2023 - 2025",
          ),
          _timelineTile(
            "Varosa Technology",
            "Junior Flutter Developer",
            "2021 - 2023",
          ),
          _timelineTile("Eastern Hawk", "Flutter Developer", "2021"),
        ],
      ),
    );
  }

  Widget _timelineTile(String company, String role, String date) {
    return ListBody(
      children: [
        Row(
          children: [
            const CircleAvatar(radius: 5, backgroundColor: Colors.blueAccent),
            const SizedBox(width: 20),
            Text(
              date,
              style: const TextStyle(
                color: Colors.white30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 30),
          child: Container(
            padding: const EdgeInsets.only(left: 20, top: 10),
            decoration: const BoxDecoration(
              border: Border(left: BorderSide(color: Colors.white10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  role,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(company, style: const TextStyle(color: Colors.white54)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80),
      width: double.infinity,
      color: Colors.black,
      child: Column(
        children: [
          const Text(
            "© 2026 Amit Yadav",
            style: TextStyle(color: Colors.white24),
          ),
          const SizedBox(height: 10),
          const Text(
            "Handcrafted with Flutter Web",
            style: TextStyle(color: Colors.white10, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
