import 'dart:convert';

import 'controller.dart';

class User {
  final int id_barang;
  final String? nama_barang;
  final int jml_stok;
  String? tanggal_masuk;
  String? tanggal_keluar;
  final int role_id;
  final int is_active;

  User({
    required this.id_barang,
    required this.nama_barang,
    required this.jml_stok,
    required this.tanggal_masuk,
    required this.tanggal_keluar,
    required this.role_id,
    required this.is_active,
  });
  Map<String, dynamic> toMap() => {
        'id_barang': id_barang,
        'nama_barang': nama_barang,
        'jml_stok': jml_stok,
        'tanggal_masuk': tanggal_masuk,
        'tanggal_keluar': tanggal_keluar,
        'role_id': role_id,
        'is_active': is_active
      };
  final Controller ctrl = Controller();

  factory User.fromJson(Map<String, dynamic> json) => User(
      id_barang: json['id_barang'],
      nama_barang: json['nama_barang'],
      jml_stok: json['jml_stok'],
      tanggal_masuk: json['tanggal_masuk'],
      tanggal_keluar: json['tanggal_keluar'],
      role_id: json['role_id'],
      is_active: 1);
}

User produkFromJson(String str) => User.fromJson(json.decode(str));
