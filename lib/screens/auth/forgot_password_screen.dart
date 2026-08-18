import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final c = TextEditingController();
  bool sent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.lock_reset, color: Colors.green, size: 58),
                const SizedBox(height: 24),
                Text('Reset password', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900)),
                const SizedBox(height: 8),
                const Text('Enter your email and we’ll send a password reset link.'),
                const SizedBox(height: 28),
                TextField(
                  controller: c,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email_outlined)),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      if (c.text.contains('@')) setState(() => sent = true);
                    },
                    child: const Padding(padding: EdgeInsets.all(14), child: Text('Send reset link')),
                  ),
                ),
                if (sent)
                  const Padding(
                    padding: EdgeInsets.only(top: 18),
                    child: Text('Reset link sent. Check your inbox.', style: TextStyle(color: Colors.green, fontWeight: FontWeight.w700)),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
