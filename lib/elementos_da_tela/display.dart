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
          alignment: Alignment.bottomRight,
          child: Padding(
              padding: EdgeInsets.only(bottom: 15.0,right: 15.0),
              child: Text(
                widget.display,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            )),
      ),
    );
  }
}