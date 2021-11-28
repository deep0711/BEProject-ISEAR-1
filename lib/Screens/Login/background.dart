import 'package:flutter/material.dart';

class BackGround extends StatelessWidget {
  final Widget child;
  const BackGround({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // Gives the Size of The Screen
    return Container(
        color: Colors.greenAccent,
        height: size.height,
        width: double.infinity,
        alignment: Alignment.center,
        child: Stack(children: <Widget>[child]));
  }
}
