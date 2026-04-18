import 'package:flutter/material.dart';
import '../models/user_model.dart';

class CustomDataCard extends StatelessWidget {
  final UserModel user;

  const CustomDataCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          // Using NetworkImage to load the avatar from the API
          backgroundImage: NetworkImage(user.avatar),
          backgroundColor: Colors.blueAccent,
        ),
        title: Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(user.email),
      ),
    );
  }
}