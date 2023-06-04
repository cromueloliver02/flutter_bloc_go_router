import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const String name = 'splash';
  static const String path = '/$name';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SPLASH PAGE')),
      body: const Center(child: Text('Splash Page')),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthStarted());
  }
}
