import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:dola/helpers/shared_prefs.dart';

class CurrentRide extends StatefulWidget {
  const CurrentRide({Key? key, required this.riderAdd,required this.destination}) : super(key: key);
  final String riderAdd;
  final String destination;
  @override
  State<CurrentRide> createState() => _CurrentRideState();
}

class _CurrentRideState extends State<CurrentRide> {
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
      appBar: AppBar(title: Text("Current Ride")),
      body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
              Padding(
                  padding: EdgeInsets.only(left:17,right:17,top:15),
                  child: Container(
                    width: MediaQuery.of(context).size.width*.8,
                      padding: EdgeInsets.all(20),
                      // height: 100,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 110, 135, 194),
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children:[
                    
                              Text("Source:$source",style:TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),
                              Text("Fare:",style:TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),
                              Text("Destination:$destination",style:TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),
                         
                        Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () async {
                          
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                   MaterialStatePropertyAll<Color>(
                                Colors.blue[900]!,
                              ),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ))),
                          child: Container(
                              padding: const EdgeInsets.all(12),
                              // width: MediaQuery.of(context).size.width * 0.,
                              child: Text(
                                'Accept Ride Request',
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              )),
                        ),
                      ),
                      ]))),
                       Container(height:50, child:VerticalDivider(color: Colors.blue,)),
          ])),
    );
  }
}
