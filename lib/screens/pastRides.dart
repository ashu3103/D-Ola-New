import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:dola/helpers/shared_prefs.dart';

class PastRides extends StatefulWidget {
  const PastRides({Key? key, required this.rides}) : super(key: key);
  final List<dynamic>rides;
  @override
  State<PastRides> createState() => _PastRidesState();
}

class _PastRidesState extends State<PastRides> {
  String source = "Delhi";
  String destination = "Mumbai";
  String fare = "100";
  String date = "1/1/23";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Past Rides")),
      body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                for(int i=0; i<widget.rides.length; i++)
              Padding(
                  padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*.12,right:MediaQuery.of(context).size.width*.12,top:15),
                  child: Container(
                      padding: EdgeInsets.all(20),
                      height: 100,
                         decoration: BoxDecoration(
                        boxShadow: const [
                           BoxShadow(
                            color: Color.fromARGB(255, 154, 152, 152),
                            offset: const Offset(
                        1.0,
                        1.0,
                      ),
                      blurRadius: 1.0,
                      spreadRadius: 1.0,
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Source: ${widget.rides[i][0]}",style:TextStyle(fontSize: 12,fontWeight: FontWeight.w600)),
                              Text("Fare: ${widget.rides[i][2]}",style:TextStyle(fontSize: 12,fontWeight: FontWeight.w600)),
                            ],
                          ),
                          
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Destination: ${widget.rides[i][1]}",style:TextStyle(fontSize: 12,fontWeight: FontWeight.w600)),
                              Text("Date: ${widget.rides[i][4]}",style:TextStyle(fontSize: 12,fontWeight: FontWeight.w600)),
                            ],
                          ),
                         
                        ],
                      ))),
                       Container(height:50, child:VerticalDivider(color: Colors.blue,)),
          ])),
    );
  }
}
