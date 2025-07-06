import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/Widget/round_button.dart';
import 'package:firebase_demo/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_demo/utlis.dart';
import 'package:firebase_demo/post.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // to handle null values if email and password null

  final _formKey=GlobalKey<FormState>();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  // authentication instance
  final _auth=FirebaseAuth.instance;
  @override
  void dispose(){
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  //function login
  void logIn(){
    _auth.signInWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString()).then((value){
          Utlis().toastMessage(value.user!.email.toString());
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Instagram()));

    }).onError((error,stackTrace){
      //show the exception
      Utlis().toastMessage(error.toString());

    });


  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
        title: Text('Login'),
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

        body:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key:_formKey,
                  child:Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          helperText: 'Enter email like ali@gmail.com',
                          prefixIcon: Icon(Icons.email),
                        ),
                          validator:(value){
                            if(value!.isEmpty){
                              return 'Enter email';
                            }
                            if (!value.contains('@') || !value.contains('.')) {
                              return 'Enter a valid email';
                            }

                            else
                              return null;

                          }

                      ),

                      SizedBox(height: 20,),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'password',
                          helperText: 'Enter password unique',
                          prefixIcon: Icon(Icons.lock),
                        ),
                          validator:(value){
                            if(value!.isEmpty){
                              return 'Enter password';
                            }
                            if (value.length > 6) {
                              return 'Password must be at most 6 characters';
                            }
                            else{
                              return null;
                            }
                          }
                      ),
                    ],
                  )
                ),


                SizedBox(height: 50,),
                RoundButton(

                  title: 'login',


                  onTap: (){
                    // show error message its null or ...
                    if (_formKey.currentState!.validate()){
                      logIn();

                    }
                  },
                ),
                SizedBox(height: 35,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Text('Already have an account?  ',style: TextStyle(fontSize: 12),),
                   InkWell(
                     onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInScreen()));

                     },

                     child: Text('SignIn ',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color:Colors.deepPurple),),
                   )
                 ],
                ),

              ],

            )
          ),
        )
      ),
    );
  }
}
