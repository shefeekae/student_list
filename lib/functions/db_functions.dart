// ignore_for_file: no_leading_underscores_for_local_identifiers, invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:student_details/model/data_model.dart';

class DatabaseFunctions extends ChangeNotifier {
  List<StudentModel> studentList = [];

  // ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

  Future<void> addStudent(StudentModel value) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    final _id = await studentDB.add(value);
    value.id = _id;

    final data = StudentModel(
        name: value.name,
        age: value.age,
        studentId: value.studentId,
        phone: value.phone,
        id: _id);

    await studentDB.put(_id, data);

    // studentListNotifier.value.add(value);
    // studentListNotifier.notifyListeners();

    studentList.add(value);
    notifyListeners();
  }

  Future<void> getAllStudents() async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');

    // studentListNotifier.value.clear();
    // studentListNotifier.value.addAll(studentDB.values);
    // studentListNotifier.notifyListeners();

    studentList.clear();
    studentList.addAll(studentDB.values);
    notifyListeners();
  }

  Future<void> deleteStudent(int id) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    await studentDB.delete(id);
    getAllStudents();
  }

  Future<void> updateStudent(StudentModel data) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    await studentDB.put(data.id, data);
    getAllStudents();
  }
}
