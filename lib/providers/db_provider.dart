import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:salesforce/model/employee_model.dart';
import 'package:salesforce/model/user_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  // Create the database and the Employee table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'salesforce.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      print('Criando tabelas');
      await db.execute('CREATE TABLE Employee('
          'id INTEGER PRIMARY KEY,'
          'email TEXT,'
          'firstName TEXT,'
          'lastName TEXT,'
          'avatar TEXT'
          ')');

      await db.execute('CREATE TABLE usuario('
          'co_usuario INTEGER PRIMARY KEY,'
          'no_usuario varchar(100),'
          'no_senha varchar(50)'
          ')');
    });
  }

  // Insert employee on database
  createEmployee(Employee newEmployee) async {
    await deleteAllEmployees();
    final db = await database;
    final res = await db.insert('Employee', newEmployee.toJson());

    return res;
  }

  // Insert usuario on database
  createUsuario(Usuario newUsuario) async {
    final db = await database;
    final res = await db.insert('usuario', newUsuario.toJson());

    return res;
  }

  // Delete all employees
  Future<int> deleteAllEmployees() async {
    print('Deletando Employees');
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Employee');

    return res;
  }

  // Delete all usuario
  Future<int> deleteAllUsuario() async {
    print('Deletando Usuarios');
    final db = await database;
    final res = await db.rawDelete('DELETE FROM usuario');

    return res;
  }

  Future<List<Employee>> getAllEmployees() async {
    print('Get EMPLOYEE');
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM EMPLOYEE");

    List<Employee> list =
        res.isNotEmpty ? res.map((c) => Employee.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<Usuario>> getAllUsuario() async {
    print('Get USUARIO');
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM USUARIO");

    List<Usuario> list =
        res.isNotEmpty ? res.map((c) => Usuario.fromJson(c)).toList() : [];

    return list;
  }
}
