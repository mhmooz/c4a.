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
