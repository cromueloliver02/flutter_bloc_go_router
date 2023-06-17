import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';

class PostList extends StatelessWidget {
  const PostList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'POSTS',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        BlocBuilder<PostListBloc, PostListState>(
          buildWhen: (prev, curr) => prev.status != curr.status,
          builder: (ctx, state) => ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.postList.length,
            itemBuilder: (ctx, idx) => ListTile(
              leading: const Icon(Icons.person, size: 30),
              title: Text(
                state.postList[idx].title,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(state.postList[idx].body),
            ),
          ),
        ),
      ],
    );
  }
}
