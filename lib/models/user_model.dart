import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String username;
  final String name;
  final String email;

  const User({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
  });

  @override
  List<Object> get props => [id, username, name, email];

  @override
  String toString() {
    return 'User(id: $id, username: $username, name: $name, email: $email)';
  }

  User copyWith({
    int Function()? id,
    String Function()? username,
    String Function()? name,
    String Function()? email,
  }) {
    return User(
      id: id != null ? id() : this.id,
      username: username != null ? username() : this.username,
      name: name != null ? name() : this.name,
      email: email != null ? email() : this.email,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'username': username});
    result.addAll({'name': name});
    result.addAll({'email': email});

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt() ?? 0,
      username: map['username'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
