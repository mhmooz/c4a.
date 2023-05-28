import 'package:bloc/bloc.dart';
import 'package:c4a/shared/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../../modules/todo_app/archived_screen/archived_screen.dart';
import '../../modules/todo_app/done_tasks_screen/donr_tasks.dart';
import '../../modules/todo_app/new_tasks_screen/new_tasks.dart';
import '../components/constants.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

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

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  List<Map> tasks = [];

  late Database database;
  void createDataBase() {
    openDatabase(
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
          emit(AppGetDataBaseState());
          print('data base opened');
        });
      },
    ).then((value) {
      database = value;
      emit(AppCreateDataBaseState());
    });
  }

  insertToDataBase(
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
          emit(AppInsertDataBaseState());
          getDataFromDataBase(database).then((value) {
            tasks = value;
            print(tasks);
            emit(AppGetDataBaseState());
          });
        },
      ).catchError((error) {
        print("Error when inserting New Record: $error");
      });
      return Future.value();
    });
  }

  Future<List<Map>> getDataFromDataBase(database) async {
    emit(AppGetDataBaseLoadingState());
    return await database.rawQuery('SELECT * FROM tasks');
  }

  IconData fabIcon = Icons.edit;
  bool isBottomSheetShown = false;

  void cahngeBottomSheetState({required bool isShow, required IconData icon}) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }
}
