import 'package:c4a/shared/components/components.dart';
import 'package:c4a/sql.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewTasksScreen extends StatefulWidget {
  const NewTasksScreen({super.key});

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {
  SqlDb sqlDb = SqlDb();
  Future<List<Map>> readData() async {
    List<Map> response = await sqlDb.readData('SELECT * FROM tasks');
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: readData(),
        builder: (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return buildTaskItem(snapshot.data![index], Set());
                },
                separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                itemCount: snapshot.data!.length);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
