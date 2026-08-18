import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../home/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  const RegisterScreen({required this.onThemeToggle, super.key});
  @override State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final name = TextEditingController();
  final email = TextEditingController();
  final pass = TextEditingController();
  bool hide = true;

  void create() {
    if (name.text.trim().length < 2 || !email.text.contains('@') || pass.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please complete all fields correctly.')));
      return;
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen(onThemeToggle: widget.onThemeToggle)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Create your account', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900)),
                const SizedBox(height: 8),
                const Text('Build smarter farming habits with AgriSmart.'),
                const SizedBox(height: 28),
                TextField(controller: name, decoration: const InputDecoration(labelText: 'Full name', prefixIcon: Icon(Icons.person_outline))),
                const SizedBox(height: 14),
                TextField(controller: email, decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email_outlined))),
                const SizedBox(height: 14),
                TextField(controller: pass, obscureText: hide, decoration: InputDecoration(labelText: 'Password', helperText: 'At least 6 characters', prefixIcon: const Icon(Icons.lock_outline), suffixIcon: IconButton(onPressed: () => setState(() => hide = !hide), icon: Icon(hide ? Icons.visibility_outlined : Icons.visibility_off_outlined)))),
                const SizedBox(height: 20),
                SizedBox(width: double.infinity, child: FilledButton(onPressed: create, child: const Padding(padding: EdgeInsets.all(14), child: Text('Create account')))),
                const SizedBox(height: 12),
                Center(child: TextButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen(onThemeToggle: widget.onThemeToggle))), child: const Text('Already have an account? Sign in'))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
