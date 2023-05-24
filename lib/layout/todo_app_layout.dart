import 'dart:ui';

import 'package:c4a/modules/todo_app/archived_screen/archived_screen.dart';
import 'package:c4a/modules/todo_app/done_tasks_screen/donr_tasks.dart';
import 'package:c4a/modules/todo_app/new_tasks_screen/new_tasks.dart';
import 'package:c4a/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class TODO_App extends StatefulWidget {
  const TODO_App({super.key});

  @override
  State<TODO_App> createState() => _TODO_AppState();
}

class _TODO_AppState extends State<TODO_App> {
  late Database database;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isBottomSheetShown = false;
  final title_controller = TextEditingController();
  final time_controller = TextEditingController();
  final date_controller = TextEditingController();
  int currentIndex = 0;
  List<Widget> screens = [
    const NewTasksScreen(),
    const DoneTasksScreen(),
    const ArchivedTasksScreen(),
  ];
  List<String> titles = [
    "New Tasks",
    "Done Tasks",
    "Archived Tasks",
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          centerTitle: true,
          title: Text(titles[currentIndex]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (isBottomSheetShown) {
              Navigator.pop(context);
              isBottomSheetShown = false;
            } else {
              scaffoldKey.currentState!.showBottomSheet((context) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      defaultFormField(
                        controller: title_controller,
                        hintText: 'Task Title',
                        keyboardType: TextInputType.text,
                        prefix: Icon(Icons.title),
                        validat: (value) {
                          if (value!.isEmpty) {
                            return "Title Must Not Be Empty";
                          }
                        },
                      ),
                    ],
                  ));
              isBottomSheetShown = true;
            }
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.grey[900],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          backgroundColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: "NEW TASKS"),
            BottomNavigationBarItem(
                icon: Icon(Icons.check_box), label: 'DONE TASKS'),
            BottomNavigationBarItem(
                icon: Icon(Icons.archive_outlined), label: 'ARCHIVED TASKS')
          ],
        ),
        body: screens[currentIndex],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    createDataBase();
  }

  void createDataBase() async {
    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) async {
        print('database created ');
        await database.execute(
            'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)');
        try {
          print('table created');
        } catch (error) {
          print("error when creating table: $error");
        }
      },
      onOpen: (database) {
        print('data base opened');
      },
    );
  }

  void insertToDataBase() {
    database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks(title, date, time, status) VALUES("my first taks","feb","noon","new")')
          .then(
        (value) {
          print("$value inserted successfully");
        },
      ).catchError((error) {
        print("Error when inserting New Record: $error");
      });
      return Future.value();
    });
  }
}
