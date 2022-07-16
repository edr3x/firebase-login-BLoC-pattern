import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget {
  static const String routeName = '/signin-page';
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Signin Page"),
      ),
    );
  }
}