import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final color;
  final textcolor;
  final buttontab;
  final String? textbutton;

  MyButton(
      {Key? key, this.color, this.textbutton, this.textcolor, this.buttontab})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttontab,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
                color: color,
                child: Center(
                  child: Text(
                    textbutton!,
                    style: TextStyle(color: textcolor, fontSize: 23),
                  ),
                ))),
      ),
    );
  }
}
