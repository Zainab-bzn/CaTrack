import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'DashboardScreen.dart';

class CatInfoScreen extends StatefulWidget {
  const CatInfoScreen({super.key});

  @override
  State<CatInfoScreen> createState() => _CatInfoScreenState();
}

class _CatInfoScreenState extends State<CatInfoScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();

  String _selectedBreed = 'Persian';
  String _catType = 'Indoor';

  final List<String> _breeds = [
    'Persian',
    'Siamese',
    'Maine Coon',
    'Ragdoll',
    'British Shorthair',
    'Sphynx',
    'Bengal',
    'Scottish Fold'
  ];

  void _saveInfo() {
    String name = _nameController.text;
    String age = _ageController.text;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DashboardScreen(catName: name, catAge: age),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Welcome to CatTrack!',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.pink[200],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Lottie.asset('assets/animations/cat_intro_animation.json', height: 200),
            const SizedBox(height: 20),
            const Text(
              'Cat Info',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                filled: true,
                fillColor: Colors.blueGrey[50],
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(
                labelText: 'Age',
                filled: true,
                fillColor: Colors.blueGrey[50],
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField(
              value: _selectedBreed,
              items: _breeds
                  .map((breed) => DropdownMenuItem(
                value: breed,
                child: Text(breed),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedBreed = value!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Breed',
                filled: true,
                fillColor: Colors.blueGrey[50],
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _colorController,
              decoration: InputDecoration(
                labelText: 'Color',
                filled: true,
                fillColor: Colors.blueGrey[50],
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Type:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    title: const Text("🏠 Indoor"),
                    value: 'Indoor',
                    groupValue: _catType,
                    onChanged: (value) {
                      setState(() {
                        _catType = value!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: const Text("🌳 Outdoor"),
                    value: 'Outdoor',
                    groupValue: _catType,
                    onChanged: (value) {
                      setState(() {
                        _catType = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveInfo,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[200],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text('Save Info', style: TextStyle(fontSize: 16)),
            )
          ],
        ),
      ),
    );
  }
}
