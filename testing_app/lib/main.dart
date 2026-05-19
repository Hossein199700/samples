import 'package:flutter/material.dart';

void main() {
  runApp(const MathverseApp());
}

// ---------------- ADMINS ----------------
const Map<String, String> admins = {
  "Hossein_1997": "1234567",
  "AmirAli_1997": "1234567",
};

// ---------------- APP ----------------
class MathverseApp extends StatelessWidget {
  const MathverseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Mathverse School PRO",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginPage(),
    );
  }
}

// ---------------- LOGIN ----------------
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final username = TextEditingController();
  final password = TextEditingController();

  void login() {
    final u = username.text.trim();
    final p = password.text.trim();

    if (admins[u] == p) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AdminPanel()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const StudentPanel()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: username,
              decoration: const InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: password,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: login,
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- STUDENT PANEL ----------------
class StudentPanel extends StatelessWidget {
  const StudentPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Student 🎓")),
      body: ListView(
        children: [
          ListTile(
            title: const Text("🏆 Leaderboard"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LeaderboardPage()),
              );
            },
          ),
          ListTile(
            title: const Text("📚 Assignments"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AssignmentPage()),
              );
            },
          ),
          ListTile(
            title: const Text("💬 Feedback"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FeedbackPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ---------------- DATA ----------------
List<Map<String, dynamic>> students = [
  {"name": "Ali", "score": 95},
  {"name": "Sara", "score": 88},
  {"name": "Reza", "score": 76},
];

List<String> assignments = [
  "Math Homework",
  "Science Project",
  "English Essay",
];

List<String> feedbacks = [];

// ---------------- LEADERBOARD ----------------
class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sorted = [...students];
    sorted.sort((a, b) => b["score"].compareTo(a["score"]));

    return Scaffold(
      appBar: AppBar(title: const Text("Leaderboard 🏆")),
      body: ListView.builder(
        itemCount: sorted.length,
        itemBuilder: (context, i) {
          return ListTile(
            leading: Text("#${i + 1}"),
            title: Text(sorted[i]["name"]),
            trailing: Text("${sorted[i]["score"]} ⭐"),
          );
        },
      ),
    );
  }
}

// ---------------- ASSIGNMENTS ----------------
class AssignmentPage extends StatelessWidget {
  const AssignmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Assignments 📚")),
      body: ListView.builder(
        itemCount: assignments.length,
        itemBuilder: (context, i) {
          return ListTile(
            leading: const Icon(Icons.book),
            title: Text(assignments[i]),
          );
        },
      ),
    );
  }
}

// ---------------- FEEDBACK ----------------
class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final controller = TextEditingController();

  void send() {
    if (controller.text.trim().isEmpty) return;

    setState(() {
      feedbacks.add(controller.text.trim());
      controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Feedback 💬")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(controller: controller),
          ),
          ElevatedButton(
            onPressed: send,
            child: const Text("Send"),
          ),
          Expanded(
            child: ListView(
              children: feedbacks
                  .map((f) => ListTile(title: Text(f)))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}

// ---------------- ADMIN ----------------
class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Admin Panel 👑",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
