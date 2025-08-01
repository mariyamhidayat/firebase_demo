import 'package:flutter/material.dart';
// which is component and reuse
class RoundButton extends StatelessWidget {
  final String title;

  final VoidCallback onTap;
  const  RoundButton({Key? key,
    required this.title,
    required this.onTap,

  }):super(key:key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,

        decoration: BoxDecoration(
          color:Colors.deepPurple,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Center(child:
          Text(title,style: TextStyle(color: Colors.white),)),
        ),
      ),
    );
  }
}
