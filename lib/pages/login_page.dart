import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../configs/configs.dart';
import '../cubits/cubits.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const String name = 'login';
  static const String path = '/$name';

  static final List<BlocProvider> blocProviders = [
    BlocProvider<SignInCubit>(create: (ctx) => sl<SignInCubit>()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LOGIN PAGE')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ElevatedButton(
              onPressed: () => context.read<SignInCubit>().signIn(),
              child: const Text('Login'),
            ),
          ),
        ),
      ),
    );
  }
}
