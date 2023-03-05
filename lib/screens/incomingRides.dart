import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:dola/helpers/shared_prefs.dart';
import 'package:dola/screens/currentRide.dart';
import 'package:dola/services/functions.dart';
import 'package:web3dart/web3dart.dart';

class IncomingRides extends StatefulWidget {
  final Web3Client ethClient;
  final List<dynamic> incomingRides;
  final email;
  final pvtKey;
  const IncomingRides({Key? key, required this.incomingRides, required this.ethClient, required this.email, required this.pvtKey}) : super(key: key);

  @override
  State<IncomingRides> createState() => _IncomingRidesState();
}

class _IncomingRidesState extends State<IncomingRides> {
  // String source = "Delhi";
  // String destination = "Mumbai";
  // String fare = "100";
  // String date = "1/1/23";
  String rideReq = "Accept Ride Request";
  bool isDisabled = false;
  List<dynamic> refreshedRideShow = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text("Incoming Rides"),
      actions: [
        IconButton(
          onPressed: () async {
            dynamic refreshedIncomingRides_tuple = await getAllCurrentRideRequests(widget.ethClient);
            setState(() {
              refreshedRideShow = refreshedIncomingRides_tuple[0];
            });
            
        }, 
        icon: Icon(Icons.refresh))
      ],
      ),
      body: SingleChildScrollView(
        child: refreshedRideShow.length == 0 ? Center(child:CircularProgressIndicator()) : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < refreshedRideShow.length; i++)
              Padding(
                  padding: EdgeInsets.only(left: 17, right: 17, top: 15),
                  child: Container(
                      padding: EdgeInsets.all(20),
                      // height: 100,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 203, 203, 203),
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("Source:${refreshedRideShow[i][0]}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600)),
                                Text("Fare:${refreshedRideShow[i][2]}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("Destination:${refreshedRideShow[i][1]}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600)),
                                Text("Date:${refreshedRideShow[i][4]}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              print("btn status");
                              print(isDisabled);
                              isDisabled
                                  ? null
                                  : {
                                      setState(() {
                                        rideReq = "Ride Accepted";
                                        isDisabled = true;
                                      }),
                                      

                                      await acceptIncomingRide(widget.email, widget.incomingRides[i][5], widget.pvtKey, widget.ethClient),
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CurrentRide(
                                                    fare: widget.incomingRides[i][2].toString(),
                                                    riderAdd: widget.incomingRides[i][0],
                                                    destination: widget.incomingRides[i][1], ethClient: widget.ethClient)),
                                      )
                                    };
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                  Colors.blue[900]!,
                                ),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ))),
                            child: Container(
                                padding: const EdgeInsets.all(12),
                                // width: MediaQuery.of(context).size.width * 0.,
                                child: Text(
                                  rideReq,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                )),
                          ),
                        ),
                      ]))),
            Container(
              height: 50,
              child: VerticalDivider(
                color: Colors.blue,
              ),
            ),
          ],
        ),
      
      ),
    );
  }
}
