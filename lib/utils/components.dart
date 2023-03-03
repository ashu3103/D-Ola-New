import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class HeadClipper extends StatelessWidget {
  const HeadClipper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WaveClipperTwo(flip: true),
      child: Container(
        decoration: BoxDecoration(),
        height: MediaQuery.of(context).size.height * 0.3,
        child: Center(
            child: Text("D'Ola",
                style: TextStyle(
                    fontSize: 35.0,
                    letterSpacing: 2,
                    color: Colors.white,
                    fontWeight: FontWeight.w900))),
      ),
    );
  }
}

InputDecoration customBoxStyle = const InputDecoration(
  border: OutlineInputBorder(),
  // labelText: 'Enter Age',
  labelStyle: TextStyle(
    color: Color.fromRGBO(179, 177, 177, 1),
    fontWeight: FontWeight.w700,
    fontSize: 15,
    fontFamily: 'Lato',),
    // filled: true,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide( color: Color.fromRGBO(122, 119, 118, 1))
        // borderSide: BorderSide( color: Color.fromRGBO(205, 200, 199, 1))
        // (width: 1.5, color: Color.fromRGBO(201, 195, 194, 1))
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide( color: Color.fromRGBO(122, 119, 118, 1))
  ),
);
