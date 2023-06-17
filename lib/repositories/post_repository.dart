import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/models.dart';

abstract class PostRepository {
  Future<List<Post>> getUserPosts(int userId);
}

class PostRepositoryImpl implements PostRepository {
  final Dio _dio;

  const PostRepositoryImpl({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<List<Post>> getUserPosts(int userId) async {
    final String url =
        'https://jsonplaceholder.typicode.com/posts?userId=$userId';
    final Response<String> response = await _dio.get<String>(url);
    final List<Map<String, dynamic>> postMaps =
        List<Map<String, dynamic>>.from(jsonDecode(response.data!));
    final List<Post> posts =
        postMaps.map((Map<String, dynamic> d) => Post.fromMap(d)).toList();

    return posts;
  }
}
