import 'package:flutter/material.dart';

class Display extends StatefulWidget {
  const Display({
    Key? key,
    required this.display,
  }) : super(key: key);

  final String display;

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  int easterEgg = 0;

  void mostrarEasterEgg(int valor, BuildContext context){

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        mostrarEasterEgg(1, context);
      },
      child: Card(
        elevation: 5.0,
        margin: EdgeInsets.all(20.0),
        child: Align(
            child: Padding(
              padding: EdgeInsets.only(top: 20.0,right: 10.0),
              child: Text(widget.display),
            )),
      ),
    );
  }
}