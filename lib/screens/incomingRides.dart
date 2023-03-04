import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:dola/helpers/shared_prefs.dart';

class IncomingRides extends StatefulWidget {
  const IncomingRides({Key? key}) : super(key: key);

  @override
  State<IncomingRides> createState() => _IncomingRidesState();
}

class _IncomingRidesState extends State<IncomingRides> {
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
                      // height: 100,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 203, 203, 203),
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children:[
                      Row(
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
                      ),
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
