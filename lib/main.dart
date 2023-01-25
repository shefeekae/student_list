import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:student_details/functions/db_functions.dart';
import 'package:student_details/model/data_model.dart';
import 'package:student_details/widgets/first_page_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return ChangeNotifierProvider(
      create: (context) => DatabaseFunctions(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FirstPage(),
      ),
    );
  }
}
