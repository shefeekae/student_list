import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_details/functions/db_functions.dart';
import 'package:student_details/widgets/screen_home.dart';
import 'package:student_details/widgets/second_page.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // getAllStudents();
    Provider.of<DatabaseFunctions>(context).getAllStudents();

    // final data = Provider.of<DatabaseFunctions>(context).studentList;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: MySearch());
              },
              icon: const Icon(Icons.search))
        ],
        title: const Text('Student List'),
        backgroundColor: const Color.fromARGB(255, 39, 38, 36),
      ),
      body: SafeArea(
        child: Consumer<DatabaseFunctions>(
          builder: (context, provider, child) => ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SecondPage(data: provider.studentList[index]),
                      ));
                },
                leading: const CircleAvatar(
                  radius: 28,
                  backgroundImage: AssetImage('lib/Images/12693195.jpg'),
                ),
                title: Text(
                  provider.studentList[index].name,
                  selectionColor: Colors.black,
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: provider.studentList.length,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => const ScreenHome())));
        },
        backgroundColor: const Color.fromARGB(255, 39, 38, 36),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MySearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final listItems = query.isEmpty
        ? Provider.of<DatabaseFunctions>(context).studentList
        : Provider.of<DatabaseFunctions>(context)
            .studentList
            .where((element) => element.name
                .toLowerCase()
                .startsWith(query.toLowerCase().toString()))
            .toList();

    return listItems.isEmpty
        ? const Center(child: Text("No Data Found!"))
        : ListView.builder(
            itemCount: listItems.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.only(left: 15.00, right: 15.00),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundImage:
                              AssetImage('lib/Images/12693195.jpg'),
                        ),
                        title: Text(listItems[index].name),
                        subtitle:
                            Text("Age : ${(listItems[index].age.toString())}"),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) =>
                                  SecondPage(data: listItems[index])));
                        },
                      ),
                      const Divider(
                        thickness: 3,
                        color: Colors.grey,
                      ),
                    ],
                  ));
            });
  }
}
