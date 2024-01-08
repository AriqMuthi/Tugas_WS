import 'dart:convert';
import 'dart:html'; 
import 'package:shelf/shelf.dart';

import 'controller.dart';

class Barang{
  final int? id_barang;
  final String? kode_barang;
  final String? nama_barang;
  final String? id_jns_barang;
  final int? stok_barang;

  Barang({
    required this.id_barang,
    required this.kode_barang,
    required this.nama_barang,
    required this.id_jns_barang,
    required this.stok_barang,
  });

  Map<String, dynamic> toMap() => {
    'id_barang': id_barang,
    'kode_barang': kode_barang,
    'nama_barang': nama_barang,
    'id_jenis_barang': id_jns_barang,
    'stok_barang': stok_barang
  };

  final Controller ctrl = Controller();

  factory Barang.fromJson(Map<String, dynamic> json) => Barang(
    id_barang : json['id_barang'],
    kode_barang : json['kode_barang'],
    nama_barang : json['nama_barang'],
    id_jns_barang : json['id_jenis_barang'],
    stok_barang : json['stok_barang']
  );

}

Barang roleFromJson(String str) => Barang.fromJson(json.decode(str));