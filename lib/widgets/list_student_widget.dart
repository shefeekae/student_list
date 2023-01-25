import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:student_details/functions/db_functions.dart';

class ListStudentWidget extends StatelessWidget {
  const ListStudentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DatabaseFunctions(),
      child: Builder(
        builder: (context) {
          return Consumer<DatabaseFunctions>(
            builder: (context, provider, child) {
              return ListView.separated(
                itemBuilder: (ctx, index) {
                  final data = provider.studentList[index];
                  return ListTile(
                      title: Text(data.name),
                      subtitle: Text(data.age),
                      trailing: IconButton(
                          onPressed: () {
                            if (data.id != null) {
                              provider.deleteStudent(data.id!);
                            }
                          },
                          icon: const Icon(Icons.delete)));
                },
                separatorBuilder: (ctx, index) {
                  return const Divider();
                },
                itemCount: provider.studentList.length,
              );
            },
          );
        },
      ),
    );
  }
}
