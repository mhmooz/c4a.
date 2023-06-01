// import 'package:c4a/modules/todo_app/archived_screen/archived_screen.dart';
// import 'package:c4a/sql.dart';
// import 'package:flutter/material.dart';

// import '../modules/todo_app/done_tasks_screen/donr_tasks.dart';
// import '../modules/todo_app/new_tasks_screen/new_tasks.dart';

// class TheToDoAPP extends StatefulWidget {
//   const TheToDoAPP({super.key});

//   @override
//   State<TheToDoAPP> createState() => _TheToDoAPPState();
// }

// class _TheToDoAPPState extends State<TheToDoAPP> {
//   int currentIndex = 0;

//   SqlDb sqlDb = SqlDb();
//   Future<List<Map>> readData() async {
//     List<Map> response = await sqlDb.readData('SELECT * FROM tasks');
//     return response;
//   }

//   Future<int> deleteData() async {
//     int response = await sqlDb.deleteData('DELETE FROM tasks WHERE id = 4');
//     return response;
//   }

//   List<Widget> screens = [
//     const NewTasksScreen(),
//     const DoneTasksScreen(),
//     const ArchivedTasksScreen(),
//   ];
//   List<String> titles = [
//     "New Tasks",
//     "Done Tasks",
//     "Archived Tasks",
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: Text(titles[currentIndex]),
//         centerTitle: true,
//       ),
//       body: screens[currentIndex],
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           deleteData();
//           Navigator.pushNamed(context, '/task_insert');
//         },
//         child: Icon(Icons.add),
//         backgroundColor: Colors.grey[900],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//           currentIndex: currentIndex,
//           onTap: (index) {
//             setState(() {
//               currentIndex = index;
//             });
//           },
//           type: BottomNavigationBarType.fixed,
//           backgroundColor: Colors.grey,
//           items: const [
//             BottomNavigationBarItem(icon: Icon(Icons.menu), label: "TASKS"),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.check_box), label: "DONE TASKS"),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.archive_outlined), label: "ARCHIVED TASKS"),
//           ]),
//     );
//   }
// }
