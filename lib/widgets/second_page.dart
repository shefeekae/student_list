import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_details/functions/db_functions.dart';
import 'package:student_details/widgets/edit_student.dart';
import 'package:student_details/widgets/first_page_widget.dart';
import '../model/data_model.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key, required this.data});
  final StudentModel data;
  @override
  Widget build(BuildContext context) {
    // getAllStudents();

    Provider.of<DatabaseFunctions>(context).getAllStudents;

    return ChangeNotifierProvider(
      create: (context) => DatabaseFunctions(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Student Details'),
              backgroundColor: const Color.fromARGB(255, 39, 38, 36),
            ),
            body: SafeArea(
              child: Consumer<DatabaseFunctions>(
                builder: (context, provider, child) {
                  return Column(
                    children: [
                      Card(
                        child: ListTile(
                          title: Text('Name : ${data.name}'),
                        ),
                      ),
                      Card(
                        child: ListTile(title: Text('Age : ${data.age} ')),
                      ),
                      Card(
                        child:
                            ListTile(title: Text('Contact : ${data.phone} ')),
                      ),
                      Card(
                        child: ListTile(
                            title: Text('Studendt ID : ${data.studentId}')),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 40,
                              width: 120,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EditStudent(data: data),
                                      ));
                                },
                                icon: const Icon(Icons.edit_note),
                                label: const Text('Edit'),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromARGB(255, 39, 38, 36)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                              width: 120,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  if (data.id != null) {
                                    provider.deleteStudent(data.id!);
                                  }
                                  Navigator.pop(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const FirstPage(),
                                      ));
                                },
                                icon: const Icon(Icons.delete),
                                label: const Text('Delete'),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromARGB(255, 39, 38, 36)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
