import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/models.dart';
import '../../repositories/repositories.dart';

part 'post_list_event.dart';
part 'post_list_state.dart';

class PostListBloc extends Bloc<PostListEvent, PostListState> {
  final PostRepository _postRepository;

  PostListBloc({
    required PostRepository postRepository,
  })  : _postRepository = postRepository,
        super(PostListState.initial()) {
    on<PostListStarted>(_onPostListStarted);
  }

  void _onPostListStarted(
    PostListStarted event,
    Emitter<PostListState> emit,
  ) async {
    try {
      emit(state.copyWith(status: () => PostListStatus.loading));

      final List<Post> posts = await _postRepository.getUserPosts(event.userId);

      emit(state.copyWith(
        postList: () => posts,
        status: () => PostListStatus.success,
      ));
    } catch (err) {
      emit(state.copyWith(status: () => PostListStatus.failure));
    }
  }
}