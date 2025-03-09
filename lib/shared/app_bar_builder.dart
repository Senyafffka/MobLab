import 'package:flutter/material.dart';
import 'package:my_resume/const/ui/box_decorations.dart';

abstract class AppBarBuilder{
  static AppBar build(BuildContext context,String title){
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(
        title,
        style: const TextStyle(fontSize: 40, color: Colors.white),
      ),
      actions: [
        IconButton(
            onPressed: (){

            },
            icon: const Icon(Icons.error_outline_outlined , color: Colors.white,)
        )
      ],
      flexibleSpace: Container(
        decoration: gradientBack,
      ),
    );
  }
}