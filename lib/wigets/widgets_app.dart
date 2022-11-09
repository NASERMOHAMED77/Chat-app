import 'package:chatapp/screens/singin_screen.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'images/x.png',
        height: 200,
      ),
    );
  }
}

class AppButtton extends StatelessWidget {
  AppButtton({Key? key, required this.title, required this.x})
      : super(key: key);
  String title;
  final Function x;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => x(),
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(5),
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.5),
                  offset: Offset(2, 2),
                  spreadRadius: 2,
                  blurRadius: 10)
            ],
            gradient: LinearGradient(colors: [
              Colors.blue,
              Colors.blue,
              Colors.blue,
              Colors.blue,
              Colors.blue,
              Colors.blue,
            ])),
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class DefultformField extends StatelessWidget {
  DefultformField({
    Key? key,
    required this.emailcontrolar,
    required this.style,
    required this.validator,
    required this.obscure,
    required this.keyboard,
    required this.label,
    required this.hinttext,
    required this.icon,
  }) : super(key: key);

  final TextEditingController emailcontrolar;
  final TextStyle style;
  final Function validator;
  final bool obscure;
  final TextInputType keyboard;
  final String label;
  final String hinttext;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      child: TextFormField(
        controller: emailcontrolar,
        validator: (value) {
          return validator();
        },
        obscureText: obscure,
        keyboardType: keyboard,
        decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: Colors.blue,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            label: Text(
              label,
              style: style,
            ),
            hintText: hinttext,
            hintStyle: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.w400),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.blue, width: 1.5),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.blue,
              ),
            )),
      ),
    );
  }
}
