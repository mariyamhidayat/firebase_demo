import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_demo/Widget/round_button.dart';
import 'package:firebase_demo/utlis.dart';
import 'package:flutter/material.dart';
class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  //database connection
  final databaseRef=FirebaseDatabase.instance.ref('post');
  TextEditingController postController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add post'),
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
       body:Center(
         child: Column(
           // mainAxisAlignment: MainAxisAlignment.center,
           // crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             SizedBox(height:20 ,),
             TextFormField(
               controller: postController,
               maxLines: 4,
               decoration: InputDecoration(
                 border: OutlineInputBorder(),
              hintText: 'What is in your mind',
         ),
             ),
             SizedBox(height: 50,),
             RoundButton(title: 'Add post', onTap: (){
               // create unique id
                String id=DateTime.now().millisecondsSinceEpoch.toString();
               databaseRef.child(id).set({
               'title':postController.text.toString(),
                 'id':id,


               }).then((value){
                 Utlis().toastMessage('Post added ');
               }).onError((error,stacktrace){
                 Utlis().toastMessage(error.toString());
               });

             })
           ],


         ),
       )
    );
  }

}
