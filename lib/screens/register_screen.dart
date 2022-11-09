import 'package:chatapp/screens/chat_screen.dart';
import 'package:chatapp/wigets/widgets_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final emailcontrolar = TextEditingController();
  final passwordcontrolar = TextEditingController();
  final style =
      TextStyle(color: Colors.blue, fontSize: 20, fontWeight: FontWeight.w600);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            SizedBox(
              height: 30,
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
              height: 30,
            ),
            AppButtton(title: 'Register', x:  () async {
                  try {
                    final newuser = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: emailcontrolar.text.trim(),
                            password: passwordcontrolar.text.trim());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => ChatScreen())));
                  } catch (e) {
                    print(e);
                  }
                }),
          ],
        ),
      )),
    );
  }
}
