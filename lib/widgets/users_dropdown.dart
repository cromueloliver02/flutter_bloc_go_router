import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../cubits/cubits.dart';
import '../models/models.dart';

class UsersDropdown extends StatelessWidget {
  const UsersDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      buildWhen: (prev, curr) => prev.status != curr.status,
      builder: (ctx, state) => DropdownButtonFormField(
        hint: const Text('Select user'),
        items: state.userList
            .map((d) => DropdownMenuItem<User>(
                  value: d,
                  child: Text(d.name),
                ))
            .toList(),
        onChanged: ctx.read<UserFormCubit>().onUserChanged,
      ),
    );
  }
}
