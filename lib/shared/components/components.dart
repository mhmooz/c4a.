import 'package:c4a/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';

Widget defaultButton({
  double width = 200,
  double height = 60,
  bool isUpperCase = true,
  double fontsize = 30,
  Color fontColor = Colors.white,
  Color backgroundColor = Colors.black,
  double radius = 25,
  required Function() function,
  required String text,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: backgroundColor),
      child: MaterialButton(
        onPressed: function,
        child: Text(isUpperCase ? text.toUpperCase() : text,
            style: TextStyle(color: fontColor, fontSize: fontsize)),
      ),
    );

Widget defaultFormField({
  required TextEditingController? controller,
  required String hintText,
  required TextInputType keyboardType,
  required Icon prefix,
  required String? Function(String?)? validat,
  bool isPassword = false,
  bool enable_Suggestion = false,
  bool auto_correct = false,
  Color hint_color = Colors.black,
  Color fillColor = Colors.white,
  double radius = 25,
  bool filled = true,
  Function()? onTap,
  Function()? show_password,
  Icon? suffix,
  Function()? suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: hint_color),
          prefixIcon: prefix,
          suffixIcon: suffix != null
              ? IconButton(onPressed: suffixPressed, icon: suffix)
              : null,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(radius)),
          filled: filled,
          fillColor: fillColor),
      validator: validat,
      enableSuggestions: enable_Suggestion,
      autocorrect: auto_correct,
      keyboardType: keyboardType,
      obscureText: isPassword ? true : false,
      onTap: onTap,
    );

Widget buildTaskItem(Map model, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        child: Container(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.black,
              child: Center(child: Text('${model['time']}')),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${model['title']}",
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                  ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .updateData(status: 'done', id: model['id']);
                },
                icon: Icon(Icons.check_box)),
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .updateData(status: 'archived', id: model['id']);
                },
                icon: Icon(Icons.archive_outlined)),
          ],
        )),
      ),
    );

Widget seperatorLine() => Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey,
      ),
    );
