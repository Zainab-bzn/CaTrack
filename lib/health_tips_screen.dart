import 'dart:math';
import 'package:flutter/material.dart';

class HealthTipsScreen extends StatefulWidget {
  const HealthTipsScreen({Key? key}) : super(key: key);

  @override
  State<HealthTipsScreen> createState() => _HealthTipsScreenState();
}

class _HealthTipsScreenState extends State<HealthTipsScreen> {
  final List<String> _tips = [
    "Always keep fresh water available for your cat.",
    "Brush your cat regularly to reduce shedding.",
    "Provide your cat with a scratching post to protect furniture.",
    "Regular vet checkups help catch issues early.",
    "Play with your cat daily to prevent boredom and obesity.",
    "Keep your cat's litter box clean to avoid stress.",
    "Feed your cat a balanced and appropriate diet.",
    "Spaying/neutering helps prevent health and behavior issues.",
    "Keep toxic plants and human foods away from your cat.",
    "Trim your cat's claws carefully every few weeks."
  ];

  late String _currentTip;

  @override
  void initState() {
    super.initState();
    _getRandomTip();
  }

  void _getRandomTip() {
    final random = Random();
    setState(() {
      _currentTip = _tips[random.nextInt(_tips.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cat Health Tips"),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.health_and_safety,
                size: 100, color: Colors.deepPurple),
            const SizedBox(height: 30),
            Text(
              _currentTip,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _getRandomTip,
              icon: const Icon(Icons.refresh),
              label: const Text("New Tip"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                foregroundColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
