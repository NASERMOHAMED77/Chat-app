// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:chatapp/screens/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

late User singedinuser;

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late String massagetext;
  @override
  void initState() {
    getcurrentuser();
    super.initState();
  }

  void getcurrentuser() {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        singedinuser = user;
        print(singedinuser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // void massagestream() async {
  //   await for (var snapshot
  //       in FirebaseFirestore.instance.collection('massages').snapshots()) {
  //     for (var massege in snapshot.docs) {
  //       print(massege.data());
  //     }
  //   }
  // }

  var massagecontrollar = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: (() => Navigator.pop(context)),
            // ignore: prefer_const_constructors
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.blue,
            )),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return WelcomeScreen();
                })));
              },
              icon: Icon(
                Icons.close,
                color: Colors.blue,
              ))
        ],
        title: Row(
          children: [
            Image.asset(
              'images/x.png',
              height: 30,
              width: 50,
            ),
            Text(
              'Chat',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MassageView(),
          Container(
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.blue, width: 3))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: massagecontrollar,
                    onChanged: ((value) {
                      massagetext = value;
                    }),
                    keyboardType: TextInputType.text,
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      label: Text(
                        'Write your massage here',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: (() {
                      FirebaseFirestore.instance.collection('massages').add({
                        'sender': singedinuser.email,
                        'text': massagetext,
                        'time': FieldValue.serverTimestamp()
                      });
                      massagecontrollar.clear();
                    }),
                    icon: Icon(
                      Icons.send,
                      color: Colors.blue,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MassageView extends StatelessWidget {
  const MassageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('massages')
            .orderBy('time')
            .snapshots(),
        builder: ((context, snapshot) {
          List<Massageline> massagewidgets = [];
          if (!snapshot.hasData) {
            Center(child: CircularProgressIndicator());
          }
          final massages = snapshot.data!.docs.reversed;
          for (var massage in massages) {
            final massagetext = massage.get('text');
            final sender = massage.get('sender');
            final currentuser = singedinuser.email;
            final massagewidget = Massageline(
              massagetext: massagetext,
              isme: currentuser == sender ? true : false,
              sender: sender,
            );
            massagewidgets.add(massagewidget);
            if (currentuser == sender) {}
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: massagewidgets,
            ),
          );
        }));
  }
}

class Massageline extends StatelessWidget {
  Massageline({super.key, this.massagetext, this.sender, required this.isme});
  final String? massagetext;
  final String? sender;
  final bool isme;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              sender.toString(),
              style: TextStyle(fontSize: 12),
            ),
          ),
          Material(
            elevation: 15,
            borderRadius: isme
                ? BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))
                : BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
            color: isme ? Colors.blue : Colors.grey.shade400,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                massagetext.toString(),
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
