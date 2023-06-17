import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/models.dart';

abstract class UserRepository {
  Future<List<User>> getUsers();
}

class UserRepositoryImpl implements UserRepository {
  final Dio _dio;

  const UserRepositoryImpl({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<List<User>> getUsers() async {
    final Response<String> response =
        await _dio.get<String>('https://jsonplaceholder.typicode.com/users');
    final List<Map<String, dynamic>> userMaps =
        List<Map<String, dynamic>>.from(jsonDecode(response.data!));
    final List<User> users =
        userMaps.map((Map<String, dynamic> d) => User.fromMap(d)).toList();

    return users;
  }
}
