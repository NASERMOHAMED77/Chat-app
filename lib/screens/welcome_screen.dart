// ignore_for_file: prefer_const_constructors

import 'package:chatapp/screens/register_screen.dart';
import 'package:chatapp/screens/singin_screen.dart';
import 'package:chatapp/wigets/widgets_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppLogo(),
          SizedBox(
            height: 50,
          ),
          AppButtton(
            title: 'Sign In',
            x: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => SingInScreen())));
            },
          ),
          SizedBox(
            height: 30,
          ),
          AppButtton(
            title: 'Register',
            x: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => RegisterScreen())));
            },
          )
        ],
      )),
    );
  }
}
