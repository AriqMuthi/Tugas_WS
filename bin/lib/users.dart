import 'dart:convert';
import 'controller.dart';

class Users{
  final int? id_user;
  final String? nama_user;
  final String? jk_user;
  final int? id_role;

  Users({
  required this.id_user,
  required this.nama_user,
  required this.jk_user,
  required this.id_role,
  });

  Map<String, dynamic> toMap() => {
    'id_user': id_user,
    'nama_user': nama_user,
    'jk_user': jk_user,
    'id_role': id_role
  };

  final Controller ctrl = Controller();

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    id_user: json['id_user'],
    nama_user: json['nama_user'],
    jk_user: json['jk_user'],
    id_role: json['id_role']
  );
}

Users userFromJson(String str) => Users.fromJson(json.decode(str));