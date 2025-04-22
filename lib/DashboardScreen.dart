import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'feeding_time_screen.dart';
import 'mood_music_screen.dart';
import 'water_intake_screen.dart';
import 'health_tips_screen.dart';

class DashboardScreen extends StatelessWidget {
  final String catName;
  final String catAge;

  const DashboardScreen({
    super.key,
    required this.catName,
    required this.catAge,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header Row
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Back Button
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 10),
                  // Cat Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name: $catName",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Age: $catAge",
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Animation
                  SizedBox(
                    height: 100,
                    child: Lottie.asset(
                      'assets/animations/dashboard_animation.json',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error, color: Colors.red);
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Dashboard Options
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.all(16),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildDashboardTile(
                    context,
                    icon: Icons.restaurant_menu,
                    label: "Feeding Time",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const FeedingTimeScreen(),
                      ),
                    ),
                  ),
                  _buildDashboardTile(
                    context,
                    icon: Icons.local_drink,
                    label: "Water Intake",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const WaterIntakeScreen(),
                      ),
                    ),
                  ),
                  _buildDashboardTile(
                    context,
                    icon: Icons.music_note,
                    label: "Mood Music",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MoodMusicScreen(),
                      ),
                    ),
                  ),
                  _buildDashboardTile(
                    context,
                    icon: Icons.health_and_safety,
                    label: "Health Tips",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HealthTipsScreen(),
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

  Widget _buildDashboardTile(BuildContext context,
      {required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.pink[200],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 6,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
