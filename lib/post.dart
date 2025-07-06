import 'package:firebase_demo/utlis.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Instagram extends StatefulWidget {
  const Instagram({super.key});

  @override
  State<Instagram> createState() => _InstagramState();
}

class _InstagramState extends State<Instagram> {
  final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram'),
        actions:[
          IconButton(onPressed:(){
            auth.signOut().then((value){

            }).onError((error,stacktrace){
              Utlis().toastMessage(error.toString());

            });
          },
              icon:Icon(Icons.logout_outlined)
          )
        ],
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,

            ),
          ),
        ),
      ),


    );
  }
}
