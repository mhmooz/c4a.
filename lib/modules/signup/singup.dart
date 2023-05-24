import 'package:c4a/shared/components/components.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var formKey = GlobalKey<FormState>();

  final username_controller = TextEditingController();

  final email_controller = TextEditingController();

  final pass_controller = TextEditingController();
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.message),
            color: Colors.white,
          ),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.search), color: Colors.white)
        ],
        backgroundColor: Colors.purple,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.home),
      ),
      body: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            defaultFormField(
                controller: username_controller,
                hintText: 'Username',
                keyboardType: TextInputType.text,
                validat: (value) {
                  if (value == "") {
                    return 'Username Must Not Be Empty';
                  }
                  return null;
                },
                prefix: const Icon(Icons.man)),
            const SizedBox(
              height: 20,
            ),
            defaultFormField(
                controller: email_controller,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
                validat: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Email Must Not Be Empty';
                  }
                  return null;
                },
                prefix: const Icon(Icons.email)),
            const SizedBox(height: 20),
            defaultFormField(
                suffix: isPassword
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
                suffixPressed: () {
                  setState(() {
                    isPassword = !isPassword;
                  });
                },
                controller: pass_controller,
                hintText: 'Password',
                keyboardType: TextInputType.visiblePassword,
                validat: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Password is too short';
                  }
                  return null;
                },
                prefix: const Icon(Icons.lock),
                isPassword: isPassword),
            const SizedBox(
              height: 20,
            ),
            defaultButton(
                function: () {
                  if (formKey.currentState!.validate()) {}
                },
                text: 'sign up')
          ],
        ),
      ),
    );
  }
}
