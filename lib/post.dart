import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_demo/add_post.dart';
import 'package:firebase_demo/utlis.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Instagram extends StatefulWidget {
  const Instagram({super.key});

  @override
  State<Instagram> createState() => _InstagramState();
}

class _InstagramState extends State<Instagram> {
   TextEditingController updateController=TextEditingController();
  final auth=FirebaseAuth.instance;
  final ref=FirebaseDatabase.instance.ref('post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post'),
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
      body:Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                defaultChild: Text('loading'),
                itemBuilder:(context,snapshot,animation,index){
                  return ListTile(
                    title: Text(snapshot.child('title').value.toString()),
                    subtitle: Text(snapshot.child('id').value.toString()),
                    trailing: PopupMenuButton(
                      icon: Icon(Icons.more_vert),
                        itemBuilder: (context)=>[
                          PopupMenuItem(
                            onTap: (){
                              //Navigator.pop(context);
                              showMyDialog(snapshot.child('title').value.toString(),snapshot.child('id').value.toString());
                            },
                            value:1,
                              child: ListTile(
                            leading: Icon(Icons.edit),
                            title: Text('Edit'),
                          )),
                          PopupMenuItem(
                            onTap: (){
                             // Navigator.pop(context);
                              ref.child(snapshot.child('id').value.toString()).remove();
                            },
                              value:1,
                              child: ListTile(

                                leading: Icon(Icons.delete_outline_rounded),
                                title: Text('Delete'),
                              ))
                        ]),

                  );

                }),
          )



        ],
      ),
       floatingActionButton: FloatingActionButton(onPressed:(){
        Navigator.push(
          context,MaterialPageRoute(builder: (context)=>AddPost())
        );

      },
        child: Icon(Icons.add),
      ),





    );
  }
  Future<void> showMyDialog( String title,String id)  async{
    updateController.text=title;

    return showDialog(
      context:context,
      builder:(BuildContext context){
        return AlertDialog(
          title: Text('update'),
          content: Container(
            child: TextField(
              controller: updateController,
              decoration: InputDecoration(
                hintText: 'Edit',
              ),

            ),
          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child:Text('Cancel')),
            TextButton(onPressed: (){
              Navigator.pop(context);
              ref.child(id).update({
                'title': updateController.text.toLowerCase()}
              ).then((value){

              }).onError((error,stacktrace){
                Utlis().toastMessage(error);
              });
            }, child:Text('update'))
          ],
        );

      }
      );

  }
}
