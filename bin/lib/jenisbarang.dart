import 'dart:convert';
// import 'dart:ffi';
import 'controller.dart';

class Jenis_Barang {
  final int? id_jenis_barang;
  final String kode_jenis_barang;
  final String nama_jenis_barang;

  Jenis_Barang(
      {this.id_jenis_barang,
      required this.kode_jenis_barang,
      required this.nama_jenis_barang});

  Map<String, dynamic> toMap() => {
        'id_jenis_barang': id_jenis_barang,
        'kode_jenis_barang': kode_jenis_barang,
        'nama_jenis_barang': nama_jenis_barang
      };

  final Controller ctrl = Controller();

  factory Jenis_Barang.fromJson(Map<String, dynamic> json) => Jenis_Barang(
      id_jenis_barang: json['id_jenis_barang'],
      kode_jenis_barang: json['kode_jenis_barang'],
      nama_jenis_barang: json['nama_jenis_barang']);
}

Jenis_Barang jenisFromJson(String str) =>
    Jenis_Barang.fromJson(json.decode(str));
