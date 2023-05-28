import 'package:bloc/bloc.dart';
import 'package:c4a/layout/the_todo_app.dart';
import 'package:c4a/modules/bmi_calculator/bmi_cal.dart';
import 'package:c4a/modules/login/login.dart';
import 'package:c4a/modules/messenger/messenger.dart';
import 'package:c4a/modules/simple_counter/simple_counter.dart';
import 'package:c4a/modules/signup/singup.dart';
import 'package:c4a/modules/todo_app/task_insert_screen/task_insert_screen.dart';
import 'package:c4a/modules/users/users.dart';
import 'package:c4a/modules/welcome/welcome.dart';
import 'package:c4a/shared/bloc_observer.dart';
import 'package:flutter/material.dart';

import 'layout/todo_app_layout.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: '/', routes: {
      '/': (context) => const Welcome(),
      '/login': (context) => const LogIn(),
      '/signup': (context) => const SignUp(),
      '/messenger': (context) => const Messenger(),
      '/users_data': (context) => Usersdata(),
      '/simplecounter': (context) => const SimpleCounter(),
      '/bmical': (context) => const BmiCalculator(),
      '/todo_app': (context) => TODO_App(),
      '/task_insert': (context) => TaskInsert(),
    });
  }
}
