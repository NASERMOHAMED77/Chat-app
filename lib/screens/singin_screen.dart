// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'package:chatapp/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:chatapp/wigets/widgets_app.dart';

class SingInScreen extends StatelessWidget {
  SingInScreen({super.key});
  final emailcontrolar = TextEditingController();
  final passwordcontrolar = TextEditingController();
  final style =
      TextStyle(color: Colors.blue, fontSize: 15, fontWeight: FontWeight.w600);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
            ),
            AppLogo(),
            SizedBox(
              height: 30,
            ),
            DefultformField(
              emailcontrolar: emailcontrolar,
              style: style,
              hinttext: 'Enter your Email here',
              label: 'Email',
              obscure: false,
              keyboard: TextInputType.emailAddress,
              validator: () {},
              icon: Icons.email,
            ),
            DefultformField(
              emailcontrolar: passwordcontrolar,
              style: style,
              hinttext: 'Enter your PassWord here',
              label: 'PassWord',
              obscure: true,
              keyboard: TextInputType.visiblePassword,
              validator: () {},
              icon: Icons.password_outlined,
            ),
            SizedBox(
              height: 15,
            ),
            AppButtton(
                title: 'Sign In',
                x: () async {
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: emailcontrolar.text.trim(),
                        password: passwordcontrolar.text.trim());
                    final user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => ChatScreen())));
                    }
                  } catch (e) {
                    print('d');
                  }
                }),
          ],
        ),
      )),
    );
  }
}
