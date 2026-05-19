import 'package:flutter/material.dart';

void main() {
  runApp(const MathverseApp());
}

class MathverseApp extends StatelessWidget {
  const MathverseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mathverse',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mathverse 🚀")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Mathverse Game",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Start Game 🎮"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const GamePage()),
                );
              },
            )
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

  void answer(bool correct) {
    setState(() {
      if (correct) score++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Game 🎮")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Score: $score", style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 20),

          const Text(
            "5 + 3 = ?",
            style: TextStyle(fontSize: 28),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () => answer(true),
            child: const Text("8"),
          ),

          ElevatedButton(
            onPressed: () => answer(false),
            child: const Text("10"),
          ),
        ],
      ),
    );
  }
}
