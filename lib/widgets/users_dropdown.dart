import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';

class UsersDropdown extends StatelessWidget {
  const UsersDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (ctx, state) => DropdownButtonFormField(
        hint: const Text('Select user'),
        items: state.userList
            .map((d) => DropdownMenuItem(
                  value: d.id,
                  child: Text(d.name),
                ))
            .toList(),
        onChanged: (value) {},
      ),
    );
  }
}
