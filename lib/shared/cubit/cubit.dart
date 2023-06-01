import 'package:bloc/bloc.dart';
import 'package:c4a/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../../modules/todo_app/archived_screen/archived_screen.dart';
import '../../modules/todo_app/done_tasks_screen/donr_tasks.dart';
import '../../modules/todo_app/new_tasks_screen/new_tasks.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<String> titles = ['NEW TASKS', 'DONE TASKS', 'ARCHIVED TASKS'];
  List<Widget> screens = [NewTasks(), DoneTasks(), ArchivedTasks()];

  List<Map> newtasks = [];
  List<Map> donetasks = [];
  List<Map> archivedtasks = [];

  void changeIndex(index) {
    currentIndex = index;
    emit(ChangeIndexSatae());
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  void changeBottomSheetState(
      {required bool isShow, required IconData SheetIcon}) {
    isBottomSheetShown = isShow;
    fabIcon = SheetIcon;
    emit(BottomSheetState());
  }

  // ,,,,,,,,,,,,DATABASE VOIDS,,,,,,,,,,,,,

  late Database database;

  void createDataBase() {
    openDatabase('taskss.db', version: 1, onCreate: (database, version) async {
      print('database created ');
      await database.execute('''
      CREATE TABLE taskss (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)
''');
      try {
        print('table created');
      } catch (error) {
        print("error when creating table: $error");
      }
    }, onOpen: (database) {
      getDataFromDataBase(database);
      print('data base opened');
    }).then((value) {
      database = value;
      emit(CreateDataBaseState());
    });
  }

  insertDataBase(
      {required String title,
      required String time,
      required String date}) async {
    return database.transaction((txn) {
      txn.rawInsert('''
      INSERT INTO taskss (title, time, date, status)
      VALUES ("$title","$time","$date","new")
''').then((value) {
        print("$value inserted successfully");
        emit(InsertDataBaseState());
        getDataFromDataBase(database);
      }).catchError((error) {
        print("Error when inserting New Record: $error");
      });
      return Future.value();
    });
  }

  void getDataFromDataBase(database) {
    newtasks = [];
    donetasks = [];
    archivedtasks = [];
    emit(LoadingDataState());
    database.rawQuery('SELECT * FROM taskss').then((value) {
      print(newtasks);
      value.forEach((element) {
        if (element['status'] == 'new') {
          newtasks.add(element);
        } else if (element['status'] == 'done') {
          donetasks.add(element);
        } else {
          archivedtasks.add(element);
        }
      });
      emit(ReadDatabaseState());
    });
  }

  void updateData({required String status, required int id}) async {
    database.rawUpdate('UPDATE taskss SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDataFromDataBase(database);
      emit(UpdateDataBaseState());
    });
  }

  void deleteData({required int id}) async {
    database.rawDelete('DELETE FROM taskss WHERE id = ?', [id]).then((value) {
      getDataFromDataBase(database);
      emit(DeleteDataState());
    });
  }
}
