import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class HeadClipper extends StatelessWidget {
  const HeadClipper({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WaveClipperTwo(flip: true),
      child: Container(
        decoration: BoxDecoration(
           
        ),
        height: MediaQuery.of(context).size.height * 0.3,
        child: Center(child: Text("D'Ola", style: TextStyle(fontSize: 35.0, letterSpacing: 2,color: Colors.white, fontWeight: FontWeight.w900))),
      ),
    );
  }
}

InputDecoration customBoxStyle = InputDecoration(
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2.0, color: Color(0xff14279B))
  ),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2.0, color: Color(0xff14279B))
  ),
);