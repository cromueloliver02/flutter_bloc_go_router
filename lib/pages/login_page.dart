import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'pages.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const String name = 'login';
  static const String path = '/$name';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LOGIN PAGE')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ElevatedButton(
              onPressed: () => context.goNamed(HomePage.name),
              child: const Text('Login'),
            ),
          ),
        ),
      ),
    );
  }
}
