import 'package:firebase_demo/Widget/round_button.dart';
import 'package:firebase_demo/login_screen.dart';
import 'package:firebase_demo/utlis.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  //bool loading =false;
  final _formKey=GlobalKey<FormState>();
  TextEditingController emailController= TextEditingController();
  TextEditingController passwordController=TextEditingController();
  // authentication of firebase
  FirebaseAuth _auth= FirebaseAuth.instance;

  @override
  void dispose(){
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(// exist the app
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('SignIn'),
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:CrossAxisAlignment.center,
              children: [
                Form(
                  key:_formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          label: Text('Email'),
                          hintText: ('Enter the email'),
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator :(value){
                          if(value!.isEmpty){
                            return 'please Enter Email';
                          }
                          if (!value.contains('@')|| !value.contains('.')){
                            return 'please Enter Valid Email';
                          }
                          else {
                            return null;
                          }
                        },

                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          label: Text('password'),
                          hintText: ('Enter the email'),

                          prefixIcon: Icon(Icons.lock),
                        ),
                        validator :(value){
                          if(value!.isEmpty){
                            return 'please Enter password';
                          }
                          if (value.length>6){
                            return 'Enter at least 6 words';
                          }
                          else {
                            return null;
                          }
                        },

                      ),
                    ],
                  ),
                ),


                SizedBox(height: 20,),
                RoundButton(
                    title: 'SignIn',

                    onTap: (){

                      if (_formKey.currentState!.validate()){

                        // use for firebase
                        _auth.createUserWithEmailAndPassword(
                            email: emailController.text.toString(),
                            password: passwordController.text.toString()).then((value){

                        }).onError((error,stackTrace){
                          //show the exception
                          Utlis().toastMessage(error.toString());

                        });

                      }

                    }),
                SizedBox(height: 35,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: [
                    Text('Already have an account?  ',style: TextStyle(fontSize: 12),),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));

                      },

                      child: Text('Login ',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color:Colors.deepPurple),),
                    )
                  ],
                ),

              ],

            ),
          ),
        ),

      ),
    );
  }
}
