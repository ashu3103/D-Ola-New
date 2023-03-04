import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:dola/helpers/shared_prefs.dart';
import 'package:dola/screens/prepare_ride.dart';

class RideStatus extends StatefulWidget {
  const RideStatus({Key? key}) : super(key: key);

  @override
  State<RideStatus> createState() => _RideStatusState();
}

class _RideStatusState extends State<RideStatus> {
  LatLng currentLocation = getCurrentLatLngFromSharedPrefs();
  late String currentAddress;
  late CameraPosition _initialCameraPosition;
  bool isAccepted=false;

  @override
  void initState() {
    super.initState();
    _initialCameraPosition = CameraPosition(target: currentLocation, zoom: 14);
    currentAddress = getCurrentAddressFromSharedPrefs();
    print("access");
    print( dotenv.env['MAPBOX_ACCESS_TOKEN']);
    
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ride Status")),
        body: Stack(
      children: [
        // MapboxMap(
        //   initialCameraPosition: _initialCameraPosition,
        //   accessToken:dotenv.env['MAPBOX_ACCESS_TOKEN'],
        //   myLocationEnabled: true,
        // ),
       SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(children:[
                        if(isAccepted)
                        Icon(Icons.check_circle_outline_outlined,color:Colors.green),
                        Icon(Icons.circle_outlined),
                        SizedBox(width:10),
                      const Text(
                        'Looking for Cab',
                        style: TextStyle(
                          color:Colors.grey,
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )]),
                      const SizedBox(height: 20),
                      const Text('You are currently here:'),
                      Text(currentAddress,
                          style: const TextStyle(color: Color.fromRGBO(255, 114, 94, 1))),
                      const SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const PrepareRide())),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(255, 114, 94, 1),
                              padding: const EdgeInsets.all(20)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('Where do you wanna go today?'),
                              ])),
                    ]),
              ),
            ),
          ),
      ],
    ));
  }
}
