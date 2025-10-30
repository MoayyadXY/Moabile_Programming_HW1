import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _user = TextEditingController();
  final _pass = TextEditingController();

  Future<void> _login() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUser = prefs.getString('username');
    final savedPass = prefs.getString('password');
    final ok = _user.text == savedUser && _pass.text == savedPass;

    if (!mounted) return; // don't use context if widget got disposed
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(ok ? 'Log In Successful!' : 'Log In Failed!'),
        content: Text(
          ok ? 'You will be redirected to the Main Page!' : 'Please try again!',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (ok) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const MainPage()),
                );
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar('Department Application'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Login',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            InputField(controller: _user, label: 'Username'),
            const SizedBox(height: 16),
            InputField(controller: _pass, label: 'Password', obscure: true),
            const SizedBox(height: 24),
            FullWidthButton(onPressed: _login, text: 'Log In'),
            const SizedBox(height: 16),
            const Center(child: Text('or')),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SignUpPage()),
              ),
              child: const Center(
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _user = TextEditingController();
  final _pass = TextEditingController();

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _user.text);
    await prefs.setString('password', _pass.text);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('User registered successfully!')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar('Department Application'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Sign Up',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            InputField(controller: _user, label: 'Username'),
            const SizedBox(height: 16),
            InputField(controller: _pass, label: 'Password', obscure: true),
            const SizedBox(height: 24),
            FullWidthButton(onPressed: _save, text: 'Sign Up'),
          ],
        ),
      ),
    );
  }
}
