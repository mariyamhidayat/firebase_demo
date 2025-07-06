import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/post.dart';
import 'package:firebase_demo/login_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final auth=FirebaseAuth.instance;


  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 150,),
            Text('firebase demo', style: TextStyle(fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.purple),)
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    final user= auth.currentUser;
    //check user null nhi ha tw instagram screen pe jump ho which means user already login
    if(user!=null){
      Timer(Duration(seconds: 3), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Instagram()),);
    });
    }
    else{
    Timer(Duration(seconds: 3), () {
    Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => LoginScreen()),
    );
    });
    }
  }
}
