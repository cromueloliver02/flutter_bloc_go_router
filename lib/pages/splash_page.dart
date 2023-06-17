import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../blocs/blocs.dart';
import '../configs/configs.dart';
import 'pages.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const String name = 'splash';
  static const String path = '/$name';

  static final List<BlocProvider> blocProviders = [
    BlocProvider<UsersBloc>.value(value: sl<UsersBloc>()),
  ];

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final List<BlocListener> _listeners = [
    BlocListener<UsersBloc, UsersState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: _usersListener,
    ),
    BlocListener<AuthBloc, AuthState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: _authListener,
    ),
  ];

  static void _usersListener(BuildContext ctx, UsersState state) {
    if (state.status != UsersStatus.success) return;

    ctx.read<AuthBloc>().add(AuthStarted());
  }

  static void _authListener(BuildContext ctx, AuthState state) {
    if (state.user == null) ctx.goNamed(LoginPage.name);

    if (state.user != null) ctx.goNamed(HomePage.name);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: _listeners,
      child: Scaffold(
        appBar: AppBar(title: const Text('SPLASH PAGE')),
        body: const Center(child: Text('Splash Page')),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<UsersBloc>().add(UsersStarted());
  }
}
