import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:dola/helpers/shared_prefs.dart';

class PastRides extends StatefulWidget {
  const PastRides({Key? key}) : super(key: key);

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
            for (var i = 0; i < 10; i++)
              Padding(
                  padding: EdgeInsets.only(left:17,right:17,top:15),
                  child: Container(
                      padding: EdgeInsets.all(20),
                      height: 100,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 203, 203, 203),
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Source:$source",style:TextStyle(fontSize: 12,fontWeight: FontWeight.w600)),
                              Text("Fare:$fare",style:TextStyle(fontSize: 12,fontWeight: FontWeight.w600)),
                            ],
                          ),
                          
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Destination:$destination",style:TextStyle(fontSize: 12,fontWeight: FontWeight.w600)),
                              Text("Date:$date",style:TextStyle(fontSize: 12,fontWeight: FontWeight.w600)),
                            ],
                          ),
                         
                        ],
                      ))),
                       Container(height:50, child:VerticalDivider(color: Colors.blue,)),
          ])),
    );
  }
}
