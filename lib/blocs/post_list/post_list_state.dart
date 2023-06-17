part of 'post_list_bloc.dart';

enum PostListStatus { initial, loading, success, failure }

class PostListState extends Equatable {
  final List<Post> postList;
  final PostListStatus status;

  const PostListState({
    required this.postList,
    required this.status,
  });

  factory PostListState.initial() {
    return const PostListState(
      postList: <Post>[],
      status: PostListStatus.initial,
    );
  }

  @override
  List<Object> get props => [postList, status];

  @override
  String toString() => 'PostListState(postList: $postList, status: $status)';

  PostListState copyWith({
    List<Post> Function()? postList,
    PostListStatus Function()? status,
  }) {
    return PostListState(
      postList: postList != null ? postList() : this.postList,
      status: status != null ? status() : this.status,
    );
  }
}
