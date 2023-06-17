part of 'post_list_bloc.dart';

abstract class PostListEvent extends Equatable {
  const PostListEvent();

  @override
  List<Object> get props => [];
}

class PostListStarted extends PostListEvent {
  final int userId;

  const PostListStarted({
    required this.userId,
  });

  @override
  List<Object> get props => [userId];
}
