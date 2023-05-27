import 'package:c4a/modules/todo_app/archived_screen/archived_screen.dart';
import 'package:c4a/modules/todo_app/done_tasks_screen/donr_tasks.dart';
import 'package:c4a/modules/todo_app/new_tasks_screen/new_tasks.dart';
import 'package:c4a/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import '../shared/components/constants.dart';

class TODO_App extends StatefulWidget {
  const TODO_App({super.key});

  @override
  State<TODO_App> createState() => _TODO_AppState();
}

class _TODO_AppState extends State<TODO_App> {
  late Database database;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  IconData fabIcon = Icons.edit;
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
              if (formKey.currentState!.validate()) {
                insertToDataBase(
                        title: title_controller.text,
                        time: time_controller.text,
                        date: date_controller.text)
                    .then((value) {
                  Navigator.pop(context);
                  isBottomSheetShown = false;
                  setState(() {
                    fabIcon = Icons.edit;
                  });
                });
              }
            } else {
              scaffoldKey.currentState!
                  .showBottomSheet((context) => Form(
                        key: formKey,
                        child: Column(
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
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            defaultFormField(
                                controller: time_controller,
                                hintText: 'Task Time',
                                keyboardType: TextInputType.datetime,
                                prefix: Icon(Icons.watch_later),
                                validat: (value) {
                                  if (value!.isEmpty) {
                                    return 'Time Must Not Be Empty';
                                  }
                                  return null;
                                },
                                onTap: () {
                                  showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now())
                                      .then((value) => time_controller.text =
                                          value!.format(context).toString());
                                }),
                            SizedBox(
                              height: 5,
                            ),
                            defaultFormField(
                                onTap: () {
                                  showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate:
                                              DateTime.parse("2023-06-25"))
                                      .then((value) => date_controller.text =
                                          DateFormat.yMMMd().format(value!));
                                },
                                controller: date_controller,
                                hintText: 'Task Date',
                                keyboardType: TextInputType.datetime,
                                prefix: Icon(Icons.calendar_month_outlined),
                                validat: (value) {
                                  if (value!.isEmpty) {
                                    return 'Date Must Not Be Empty';
                                  }
                                  return null;
                                })
                          ],
                        ),
                      ))
                  .closed
                  .then((value) {
                isBottomSheetShown = false;
                setState(() {
                  fabIcon = Icons.edit;
                });
              });
              isBottomSheetShown = true;
              setState(() {
                fabIcon = Icons.add;
              });
            }
          },
          child: Icon(fabIcon),
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

  Future createDataBase() async {
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
        getDataFromDataBase(database).then((value) {
          tasks = value;
          print(tasks);
          print('data base opened');
        });
      },
    );
  }

  Future insertToDataBase(
      {required String title,
      required String time,
      required String date}) async {
    return database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks(title, time, date, status) VALUES("$title","$time","$date","new")')
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

  Future<List<Map>> getDataFromDataBase(database) async {
    return await database .rawQuery('SELECT * FROM tasks');
  }
  
}
