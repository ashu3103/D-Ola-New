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
  final dynamic list;
  const IncomingRides({Key? key, required this.list, required this.ethClient}) : super(key: key);

  @override
  State<IncomingRides> createState() => _IncomingRidesState();
}

class _IncomingRidesState extends State<IncomingRides> {
  String source = "Delhi";
  String destination = "Mumbai";
  String fare = "100";
  String date = "1/1/23";
  String rideReq = "Accept Ride Request";
  bool isDisabled = false;
  dynamic list = [];
  dynamic email;
  dynamic l;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text("Incoming Rides"),
      actions: [
        IconButton(onPressed: ()async{
          final FirebaseAuth auth = FirebaseAuth.instance;
          email = auth.currentUser!.email;
          l = await getDriver(email, widget.ethClient);
          await updateAllCurrentRideRequests(l[0][6], widget.ethClient);
          print("Updated!!");
          list = await getAllCurrentRideRequests(widget.ethClient);
          print("Incoming Print");
          setState(() {
            list = list[0];
          });
          print(list);
        }, icon: Icon(Icons.refresh))
      ],),
      body: SingleChildScrollView(
        // child: FutureBuilder(
        //   future: ,
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < list.length; i++)
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
                                Text("Source:${list[i][0]}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600)),
                                Text("Fare:${list[i][2]}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("Destination:${list[i][1]}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600)),
                                Text("Date:${list[i][4]}",
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
                                      await acceptIncomingRide(email, list[i][5], l[0][6], widget.ethClient),
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CurrentRide(
                                                    fare: list[i][2].toString(),
                                                    riderAdd: list[i][0],
                                                    destination: list[i][1], ethClient: widget.ethClient)),
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
