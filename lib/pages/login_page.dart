import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../configs/configs.dart';
import '../cubits/cubits.dart';
import '../widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const String name = 'login';
  static const String path = name;

  static final List<BlocProvider> blocProviders = [
    BlocProvider<UserListBloc>.value(value: sl<UserListBloc>()),
    BlocProvider<SignInCubit>(create: (ctx) => sl<SignInCubit>()),
    BlocProvider<UserFormCubit>(create: (ctx) => sl<UserFormCubit>()),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('LOGIN PAGE'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: [
                  const UsersDropdown(),
                  const SizedBox(height: 20),
                  BlocBuilder<UserFormCubit, UserFormState>(
                    buildWhen: (prev, curr) =>
                        prev.selectedUser != curr.selectedUser,
                    builder: (ctx, state) => ElevatedButton(
                      onPressed: state.selectedUser != null
                          ? () => ctx
                              .read<SignInCubit>()
                              .signIn(state.selectedUser!)
                          : null,
                      child: const Text('Login'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
