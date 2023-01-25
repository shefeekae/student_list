import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:student_details/model/data_model.dart';
import 'package:student_details/widgets/first_page_widget.dart';

import '../functions/db_functions.dart';

class AddStudentWidget extends StatefulWidget {
  const AddStudentWidget({Key? key}) : super(key: key);

  @override
  State<AddStudentWidget> createState() => _AddStudentWidgetState();
}

class _AddStudentWidgetState extends State<AddStudentWidget> {
  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _studentIdController = TextEditingController();

  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Name is required';
                } else if (value.contains('@') || value.contains('.')) {
                  return 'Enter Valid Name';
                } else {
                  return null;
                }
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Name',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Age is required';
                } else if (!RegExp(r'^[0-9]{1,2}').hasMatch(value) ||
                    (value.length) > 2) {
                  return 'Enter valid age';
                } else {
                  return null;
                }
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.number,
              controller: _ageController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Age'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              validator: (value) {
                if ((_phoneController.text.length < 1)) {
                  return 'Phone Number is required';
                } else if ((!RegExp(r'^\d{10}').hasMatch(value!)) ||
                    ((_phoneController.text.length) > 10)) {
                  return 'Enter valid Phone Number';
                } else {
                  return null;
                }
              },
              controller: _phoneController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Contact'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              // autofocus: true,
              validator: (value) {
                if ((value?.length) != 5) {
                  return 'Enter Valid Student ID';
                } else {
                  return null;
                }
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.number,
              controller: _studentIdController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Student ID'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              onPressed: () {
                onAddStudentButtonClicked(context);

                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Data Added')));
                  Navigator.pop(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const FirstPage())));
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Update'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 39, 38, 36)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onAddStudentButtonClicked(BuildContext context) async {
    final name = _nameController.text.trim();
    final age = _ageController.text.trim();
    final studentId = _studentIdController.text.trim();
    final phone = _phoneController.text.trim();

    if (name.isEmpty || age.isEmpty || studentId.isEmpty || phone.isEmpty) {
      return;
    }

    final student =
        StudentModel(name: name, age: age, studentId: studentId, phone: phone);

    // addStudent(student);

    Provider.of<DatabaseFunctions>(context, listen: false).addStudent(student);
  }
}

final _formKey = GlobalKey<FormState>();
