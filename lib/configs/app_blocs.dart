import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';

class AppBlocs {
  static final List<BlocProvider> globalBlocs = [
    BlocProvider<AuthBloc>(create: (ctx) => AuthBloc()),
  ];
}
