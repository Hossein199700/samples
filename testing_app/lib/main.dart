import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MathverseApp());
}

class MathverseApp extends StatelessWidget {
  const MathverseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainMenu(),
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mathverse 🚀")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Text(
              "MATHVERSE",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              child: const Text("🎮 Start Game"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const GamePage()),
                );
              },
            ),

            ElevatedButton(
              child: const Text("🏆 Best Score"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ScorePage()),
                );
              },
            ),

            ElevatedButton(
              child: const Text("ℹ About"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AboutPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int score = 0;
  int level = 1;
  int bestScore = 0;

  late int a;
  late int b;
  late int correctAnswer;

  List<int> options = [];

  @override
  void initState() {
    super.initState();
    loadBest();
    generateQuestion();
  }

  Future<void> loadBest() async {
    final prefs = await SharedPreferences.getInstance();
    bestScore = prefs.getInt('bestScore') ?? 0;
    setState(() {});
  }

  Future<void> saveBest() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('bestScore', bestScore);
  }

  void generateQuestion() {
    final random = Random();
    int max = 10 + (level * 5);

    a = random.nextInt(max) + 1;
    b = random.nextInt(max) + 1;
    correctAnswer = a + b;

    options = [
      correctAnswer,
      correctAnswer + 1,
      correctAnswer - 1,
      correctAnswer + 2,
    ];

    options.shuffle();
    setState(() {});
  }

  void check(int value) async {
    if (value == correctAnswer) {
      score++;

      if (score % 3 == 0) level++;

      if (score > bestScore) {
        bestScore = score;
        await saveBest();
      }
    }

    generateQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Game 🎮")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Text("Score: $score", style: const TextStyle(fontSize: 22)),
          Text("Level: $level", style: const TextStyle(fontSize: 20)),
          Text("Best: $bestScore", style: const TextStyle(fontSize: 18)),

          const SizedBox(height: 30),

          Text(
            "$a + $b = ?",
            style: const TextStyle(fontSize: 30),
          ),

          const SizedBox(height: 20),

          ...options.map((e) {
            return ElevatedButton(
              onPressed: () => check(e),
              child: Text(e.toString()),
            );
          }),
        ],
      ),
    );
  }
}

class ScorePage extends StatelessWidget {
  const ScorePage({super.key});

  Future<int> getBest() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('bestScore') ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Best Score 🏆")),
      body: Center(
        child: FutureBuilder<int>(
          future: getBest(),
          builder: (context, snapshot) {
            final score = snapshot.data ?? 0;
            return Text(
              "Best Score: $score",
              style: const TextStyle(fontSize: 28),
            );
          },
        ),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About ℹ")),
      body: const Center(
        child: Text(
          "Mathverse 🚀\nA simple math learning game",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
