import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:student_details/functions/db_functions.dart';
import 'package:student_details/widgets/add_student_widget.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // getAllStudents();
    Provider.of<DatabaseFunctions>(context).getAllStudents();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 39, 38, 36),
        title: const Text('Add Student'),
      ),
      body: SafeArea(
          child: Column(
        children: const [
          AddStudentWidget(),
        ],
      )),
    );
  }
}
