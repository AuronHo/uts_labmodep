import 'dart:convert';

class UserModel {
  final int id;
  final String name;
  final String email;
  final String avatar;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // Reqres separates first and last name, so we combine them here
    return UserModel(
      id: json['id'] ?? 0,
      name: '${json['first_name']} ${json['last_name']}',
      email: json['email'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }

  // Custom parser because Reqres puts the user list inside a "data" object
  static List<UserModel> parseApiList(String responseBody) {
    final parsed = json.decode(responseBody);
    final List<dynamic> data = parsed['data']; 
    return data.map((json) => UserModel.fromJson(json)).toList();
  }
}