import 'dart:convert';

import 'package:mysql1/mysql1.dart';
import 'package:shelf/shelf.dart';
import 'package:intl/intl.dart';
import 'role_user.dart';
import 'users.dart';

class Controller {
  String getDateNow() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm:ss');
    final String dateNow = formatter.format(now);
    return dateNow;
  }

/* Connection MYSQLI */
  Future<MySqlConnection> ConnectSql() async {
    var settings = ConnectionSettings(
        host: '127.0.0.1', port: 3306, user: 'root', db: 'db_egudang');

    var cn = await MySqlConnection.connect(settings);
    return cn;
  }
/* END Connection MYSQLI */

/* ROLE USER */

  //Get All Role User
  Future<Response> getAllRoleUsers(Request request) async {
    var conn = await ConnectSql();
    var sql = "SELECT * FROM role_user";
    var users = await conn.query(sql, []);

    return Response.ok(users.toString());
  }

  //Post/Tambah Role User
  Future<Response> postRoleUser(Request request) async {
    String body = await request.readAsString();
    Role_User roles = roleFromJson(body);

    var conn = await ConnectSql();
    var sql = "INSERT INTO role_user (nama_role) VALUES ('${roles.nama_role}')";
    var result = await conn.query(sql, []);

    // Kembalikan informasi yang lebih relevan
    return Response.ok(jsonEncode({
      'message': 'Role berhasil ditambah',
      'nama_role': roles.nama_role,
    }));
  }

  //Put/Edit Role User
  Future<Response> putRoleUsers(Request request) async{
    String body = await request.readAsString();
    Role_User roles = roleFromJson(body);

    var conn = await ConnectSql();
    var sql = "UPDATE role_user SET nama_role='${roles.nama_role}' WHERE id_role='${roles.id_role}'";
    var result = await conn.query(sql, []);

    // Kembalikan informasi yang lebih relevan
    return Response.ok(jsonEncode({
      'message': 'Role berhasil diubah',
      'nama_role': roles.nama_role,
    }));
  }

  //Delete Role User
  Future<Response> deleteRoleUsers(Request request) async{
    String body = await request.readAsString();
    Role_User roles = roleFromJson(body);

    var conn = await ConnectSql();
    var sql = "DELETE FROM role_user WHERE id_role='${roles.id_role}'";
    var result = await conn.query(sql, []);

    // Kembalikan informasi yang lebih relevan
    return Response.ok(jsonEncode({
      'message': 'Role berhasil dihapus'
    }));
  }

/* END ROLE USER */

  /*USER*/
  //Get All User With INNER JOIN
  Future<Response> getAllUsers(Request request) async {
    var conn = await ConnectSql();
    var sql =
        "SELECT id_user, nama_user, jk_user, nama_role, CASE WHEN is_active_user = 0 THEN 'tidak aktif' WHEN is_active_user = 1 THEN 'aktif' END AS is_active_user FROM role_user INNER JOIN user ON role_user.id_role = user.id_role";
    var result = await conn.query(sql, []);

    return Response.ok(result.toString());
  }

  //Post/Tambah Users
  Future<Response> postUsers(Request request) async {
    String body = await request.readAsString();
    Users roles = Users.fromJson(body);

    var conn = await ConnectSql();
    var sql = "INSERT INTO user (nama_role) VALUES ('${roles.nama_role}')";
    var result = await conn.query(sql, []);

    // Kembalikan informasi yang lebih relevan
    return Response.ok(jsonEncode({
      'message': 'User berhasil ditambah',
      'nama_user': Users.nama_user,
    }));
  }

  /*END USER*/
}
