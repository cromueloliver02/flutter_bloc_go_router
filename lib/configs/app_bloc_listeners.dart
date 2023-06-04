import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../pages/pages.dart';
import 'configs.dart';

class AppListeners {
  static final List<BlocListener> globalListeners = [
    BlocListener<AuthBloc, AuthState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: _authListener,
    ),
  ];

  static void _authListener(BuildContext ctx, AuthState state) {
    if (state.user == null) {
      AppRouter.router.goNamed(LoginPage.name);
    }

    if (state.user != null) {
      AppRouter.router.goNamed(HomePage.name);
    }
  }
}
