import 'dart:convert';

import 'package:mysql1/mysql1.dart';
import 'package:shelf/shelf.dart';
import 'package:intl/intl.dart';
import 'users.dart';

class Controller {
  String getDateNow() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm:ss');
    final String dateNow = formatter.format(now);
    return dateNow;
  }

  /*SQL Connection*/
  Future<MySqlConnection> connectSql() async {
    var setting = ConnectionSettings(
        host: '127.0.0.1',
        port: 3306,
        user: 'root',
        db: 'barang');
    var cn = await MySqlConnection.connect(setting);
    return cn;
  }

  /*USER*/
  Future<Response> getProdukData(Request request) async {
    var conn = await connectSql();
    var sql = "SELECT * FROM PRODUK";
    var produk = await conn.query(sql, []);
    return Response.ok(produk.toString());
  }

  Future<Response> getProdukFilter(Request request) async {
    String body = await request.readAsString();
    var obj = json.decode(body);
    var name = "%" + obj['name'] + "%";

    var conn = await connectSql();
    var sql = "SELECT * FROM USER WHERE nama_barang like ?";
    var produk = await conn.query(sql, [name]);
    return Response.ok(produk.toString());
  }

  Future<Response> postProdukData(Request request) async {
    String body = await request.readAsString();
    User produk = produkFromJson(body);

    var conn = await connectSql();
    var sqlExecute = """
        INSERT INTO produk (nama_barang, jml_stok, tanggal_masuk, tanggal_keluar, role_id, is_active) VALUES
        (
          '${produk.id_barang}','${produk.nama_barang}','${produk.jml_stok}','${produk.tanggal_masuk}','${produk.tanggal_keluar}',
          '${produk.role_id}','${produk.is_active}'
        )        
    """;

    var execute = await conn.query(sqlExecute, []);

    var sql = "SELECT * FROM produk WHERE nama_barang = ?";
    var produkResponse = await conn.query(sql, [produk.nama_barang]);

    return Response.ok(produkResponse.toString());
  }

  Future<Response> putProdukData(Request request) async {
    String body = await request.readAsString();
    User produk = produkFromJson(body);
    produk.tanggal_keluar = getDateNow();

    var conn = await connectSql();
    var sqlExecute = """
        UPDATE produk SET nama_barang ='${produk.nama_barang}', jml_stok = '${produk.jml_stok}',role_id = '${produk.role_id}'
        WHERE id_barang ='${produk.id_barang}'
    """;

    var execute = await conn.query(sqlExecute, []);

    var sql = "SELECT * FROM produk WHERE id_barang = ?";
    var produkResponse = await conn.query(sql, [produk.id_barang]);

    return Response.ok(produkResponse.toString());
  }

  Future<Response> deleteProduk(Request request) async {
    String body = await request.readAsString();
    User produk = produkFromJson(body);

    var conn = await connectSql();
    var sqlExecute = """ 
      DELETE FROM produk WHERE id_barang ='${produk.id_barang}'
    """;

    var execute = await conn.query(sqlExecute, []);

    var sql = "SELECT * FROM produk WHERE id_barang = ?";
    var produkResponse = await conn.query(sql, [produk.id_barang]);

    return Response.ok(produkResponse.toString());
  }

  /*ROLE*/

  /*MOTIVASI*/
}
