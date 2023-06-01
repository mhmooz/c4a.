import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/components.dart';
import '../../../shared/cubit/cubit.dart';
import '../../../shared/cubit/states.dart';

class ArchivedTasks extends StatelessWidget {
  const ArchivedTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).archivedtasks;
        return ListView.separated(
            itemBuilder: (context, index) =>
                buildArchivedTaskItem(tasks[index], context),
            separatorBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey,
                  ),
                ),
            itemCount: tasks.length);
      },
    );
  }
}
