// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:studentapp_new/models/model.dart';

ValueNotifier<List<StudentModel>> studentlistnotifier = ValueNotifier([]);
late Database database;
Future initializeDatabase() async {
  database = await openDatabase(
    'student.db',
    version: 1,
    // onUpgrade: (db, oldVersion, newVersion) {
    //   if (oldVersion < 2) {
    //     db.exicute('ALTER TABLE studenttable ADD CLOUMN address TEXT');
    //   }
    // },
    onCreate: (database, version) async {
      await database.execute(
          "CREATE TABLE studenttable (id INTEGER PRIMARY KEY, name TEXT, age TEXT, place TEXT, addno TEXT, image TEXT)");
    },
  );
  return database;
}

addStudent(StudentModel studentModel) async {
  await database.rawInsert(
      'INSERT INTO studenttable(name, age, place, addno, image) VALUES(?,?,?,?,?)',
      [
        studentModel.name,
        studentModel.age,
        studentModel.place,
        studentModel.addNO,
        studentModel.image
      ]);

  await getAllStudents();
}

getAllStudents() async {
  final values = await database.rawQuery('SELECT * FROM studenttable');
  studentlistnotifier.value.clear();
  // ignore: avoid_function_literals_in_foreach_calls
  values.forEach((mapping) {
    final student = StudentModel.fromMap(mapping);

    studentlistnotifier.value.add(student);
    // ignore: invalid_use_of_protected_member
    studentlistnotifier.notifyListeners();
  });
}

updateStudent(StudentModel studentModel) async {
  await database.rawUpdate(
    'UPDATE studenttable SET name = ?, age = ?, place = ?, addno = ?, image = ? WHERE id = ?',
    [
      studentModel.name,
      studentModel.age,
      studentModel.place,
      studentModel.addNO,
      studentModel.image,
      studentModel.id,
    ],
  );
  await getAllStudents();
}

deleteStudent(int id) async {
  await database.rawDelete('DELETE FROM studenttable WHERE id = ?', [id]);
  await getAllStudents();
}
