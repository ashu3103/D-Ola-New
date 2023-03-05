import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:dola/helpers/shared_prefs.dart';
import 'package:dola/screens/prepare_ride.dart';
import 'package:web3dart/web3dart.dart';
import 'package:dola/services/functions.dart';
import 'package:dola/ui/rate_ride.dart';
class RideStatus extends StatefulWidget {
  final Web3Client ethClient;
  const RideStatus({Key? key, required this.ethClient}) : super(key: key);

  @override
  State<RideStatus> createState() => _RideStatusState();
}

class _RideStatusState extends State<RideStatus> {
  LatLng currentLocation = getCurrentLatLngFromSharedPrefs();
  late String currentAddress;
  late CameraPosition _initialCameraPosition;
  bool isAccepted = false;
  bool started = false;
  bool completed = false;

  @override
  void initState() {
    super.initState();
    _initialCameraPosition = CameraPosition(target: currentLocation, zoom: 14);
    currentAddress = getCurrentAddressFromSharedPrefs();
    print("access");
    print(dotenv.env['MAPBOX_ACCESS_TOKEN']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Ride Status"),
          actions: [
            IconButton(
              onPressed: () async {
                final FirebaseAuth auth = FirebaseAuth.instance;
                dynamic email = auth.currentUser!.email;
                dynamic list = await getRideStatus(email, widget.ethClient);
                print(list);
                setState(() {
                  isAccepted = list[0];
                  started = list[1];
                  completed = list[2];
                });
              }, 
              icon: Icon(Icons.refresh)
              )
          ],
          ),
        body: Column(
          children: [
            // MapboxMap(
            //   initialCameraPosition: _initialCameraPosition,
            //   accessToken:dotenv.env['MAPBOX_ACCESS_TOKEN'],
            //   myLocationEnabled: true,
            // ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              
                child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * .1,
                      top: MediaQuery.of(context).size.width * .1),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        IntrinsicHeight(
                            child: Row(children: [
                            Icon(Icons.check_circle_outline_outlined,
                                color: Colors.green),
                          SizedBox(width: 10),
                          const Text(
                            'Looking for Cab',
                            style: TextStyle(
                                color: Color.fromARGB(255, 103, 102, 102),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )
                        ])),
                        Container(
                            padding: EdgeInsets.only(left: 10),
                            height: 80,
                            child:
                                VerticalDivider(width: 2, color: Colors.grey)),
                        const SizedBox(height: 20),
                        IntrinsicHeight(
                            child: Row(children: [
                          if (isAccepted)
                            Icon(Icons.check_circle_outline_outlined,
                                color: Colors.green),
                          if(!isAccepted)Icon(Icons.circle_outlined),
                          const Text(
                            'Driver Approaching',
                            style: TextStyle(
                                color: Color.fromARGB(255, 103, 102, 102),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )
                        ])),
                        Container(
                            padding: EdgeInsets.only(left: 10),
                            height: 80,
                            child:
                                VerticalDivider(width: 2, color: Colors.grey)),
                        IntrinsicHeight(
                            child: Row(children: [
                          if (started)
                            Icon(Icons.check_circle_outline_outlined,
                                color: Colors.green),
                          if(!started)Icon(Icons.circle_outlined),
                          SizedBox(width: 10),
                          const Text(
                            'Picked Up',
                            style: TextStyle(
                                color: Color.fromARGB(255, 103, 102, 102),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )
                        ])),
                        // Container(
                        //     padding: EdgeInsets.only(left: 10),
                        //     height: 80,
                        //     child:
                        //         VerticalDivider(width: 2, color: Colors.grey)),
                        // IntrinsicHeight(
                        //     child: Row(children: [
                        //   if (completed)
                        //     Icon(Icons.check_circle_outline_outlined,
                        //         color: Colors.green),
                        //   if(!completed)Icon(Icons.circle_outlined),
                        //   SizedBox(width: 10),
                        //   const Text(
                        //     'Dropped Off',
                        //     style: TextStyle(
                        //         color: Color.fromARGB(255, 103, 102, 102),
                        //         fontSize: 18,
                        //         fontWeight: FontWeight.bold),
                        //   )
                        // ])),
                      ]),
                ),
            ),
            if (started) SizedBox(height: 25),
            if (started)
              ElevatedButton(
                  onPressed: started == true ? () async { 
                      // call pay function...
                      final FirebaseAuth auth = await FirebaseAuth.instance;
                      dynamic riderEmail = auth.currentUser!.email;
                      dynamic _rider = await getRider(riderEmail, widget.ethClient);
                      dynamic _ride = await getOngoingRide(riderEmail, widget.ethClient);
                      print(_ride[0][2].runtimeType);
                      await payFare(riderEmail, _rider[0][4], _ride[0][2], widget.ethClient);
                      Navigator.push(context,
                      MaterialPageRoute(builder: (_) => RateRide(ethClient:widget.ethClient)));
                    } : null,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900]!,
                      padding: const EdgeInsets.all(20)),
                  child: Container(
                    width: MediaQuery.of(context).size.width * .4,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(30)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Pay Now'),
                        ]),
                  )),
          ],
        ));
  }
}
