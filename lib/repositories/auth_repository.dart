import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../models/models.dart' show User;

abstract class AuthRepository {
  Stream<User?> get userStateChanges;

  Future<void> signIn();

  Future<void> signOut();
}

class AuthRepositoryImpl implements AuthRepository {
  final SharedPreferences _prefs;

  const AuthRepositoryImpl({
    required SharedPreferences prefs,
  }) : _prefs = prefs;

  @override
  Stream<User?> get userStateChanges async* {
    try {
      final String? initialUserJson = _prefs.getString(kAuthUser);

      yield initialUserJson != null ? User.fromJson(initialUserJson) : null;

      final Stream<User?> userStream = Stream.periodic(
        const Duration(milliseconds: 500),
        (int tick) {
          final String? userJson = _prefs.getString(kAuthUser);

          return userJson != null ? User.fromJson(userJson) : null;
        },
      );

      User? previousUser;

      await for (final User? user in userStream) {
        if (user != previousUser) {
          previousUser = user;
          yield user;
        }
      }
    } catch (err) {
      debugPrint('Error: $err');
      rethrow;
    }
  }

  @override
  Future<void> signIn() async {
    try {
      const User user = User(
        id: '001',
        username: 'chrissy936',
        name: 'Chris Inglis',
        email: 'chrissy@gmail.com',
      );

      await _prefs.setString(kAuthUser, user.toJson());
    } catch (err) {
      debugPrint('Error: $err');
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _prefs.remove(kAuthUser);
    } catch (err) {
      debugPrint('Error: $err');
      rethrow;
    }
  }
}
