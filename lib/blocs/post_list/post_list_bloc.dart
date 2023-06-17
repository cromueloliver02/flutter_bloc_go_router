import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../configs/configs.dart';
import '../../models/models.dart';
import '../../repositories/repositories.dart';

part 'post_list_event.dart';
part 'post_list_state.dart';

class PostListBloc extends Bloc<PostListEvent, PostListState> {
  final Completer<void> _loadedCompleter = Completer<void>();
  final PostRepository _postRepository;

  PostListBloc({
    required PostRepository postRepository,
  })  : _postRepository = postRepository,
        super(PostListState.initial()) {
    on<PostListStarted>(_onPostListStarted);
  }

  Future<void> get loaded => _loadedCompleter.future;

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
      _loadedCompleter.complete();
    } catch (err) {
      emit(state.copyWith(status: () => PostListStatus.failure));
      _loadedCompleter.completeError(err);
    }
  }

  @override
  Future<void> close() {
    sl.resetLazySingleton(instance: this);
    return super.close();
  }
}
