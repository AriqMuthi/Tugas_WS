import 'dart:convert';
// import 'dart:ffi';
import 'controller.dart';

class Role_User {

  final int? id_role;
  final String? nama_role;

  Role_User({
    this.id_role,
    required this.nama_role
  });

  Map<String, dynamic> toMap() => {
    'id_role': id_role,
    'nama_role': nama_role
  };

  final Controller ctrl = Controller();

  factory Role_User.fromJson(Map<String, dynamic> json) => Role_User(
    id_role: json['id_role'],
    nama_role: json['nama_role']
  );

}

Role_User roleFromJson(String str) => Role_User.fromJson(json.decode(str));
