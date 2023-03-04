import 'package:dola/screens/pastRides.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:dola/helpers/shared_prefs.dart';
import 'package:dola/screens/prepare_ride.dart';
import 'package:dola/screens/incomingRides.dart';
import 'package:dola/authentication/homePage.dart';

class Home extends StatefulWidget {
  const Home({Key? key,required this.role}) : super(key: key);
  final String role;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  LatLng currentLocation = getCurrentLatLngFromSharedPrefs();
  late String currentAddress;
  late CameraPosition _initialCameraPosition;

  @override
  void initState() {
    super.initState();
    _initialCameraPosition = CameraPosition(target: currentLocation, zoom: 14);
    currentAddress = getCurrentAddressFromSharedPrefs();
    print("access");
     print("rolee");
    print(widget.role);
    print( dotenv.env['MAPBOX_ACCESS_TOKEN']);
   
    
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title:  Text("D'Ola")
      ),
      drawer:  Drawer(
        child:ListView(
          children:<Widget>[
             UserAccountsDrawerHeader(accountName:  Text("rijul"), accountEmail: new Text("rijul@gmail.com"),
            currentAccountPicture:  CircleAvatar(
              backgroundImage: NetworkImage('https://thumbs.dreamstime.com/b/default-avatar-profile-icon-vector-default-avatar-profile-icon-vector-social-media-user-image-vector-illustration-227787227.jpg'),
            ),),
            ListTile(
              leading: Icon(Icons.local_taxi),
              title: const Text('Book Ride'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PrepareRide()),
                                );
              },
            ),
            if(widget.role=="Driver")
                   ListTile(
               leading: Icon(Icons.local_taxi),
              title: const Text('Incoming Rides'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
               Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const IncomingRides()),
                                );
              },
            ),
            ListTile(
               leading: Icon(Icons.local_taxi),
              title: const Text('Past Rides'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PastRides()),
                                );
              },
            ),
              ListTile(
               leading: Icon(Icons.local_taxi),
              title: const Text('Logout'),
              onTap: () {
               Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HomePage()),
                                );
              },
            ),
          ]
        )
      ) ,
        body: Stack(
      children: [
        MapboxMap(
          initialCameraPosition: _initialCameraPosition,
          accessToken:dotenv.env['MAPBOX_ACCESS_TOKEN'],
          myLocationEnabled: true,
        ),
        Positioned(
          bottom: 0,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Hi there!',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      const Text('You are currently here:'),
                      Text(currentAddress,
                          style: TextStyle(color: Colors.blue[900]!)),
                      const SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: () =>  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PrepareRide()),
                                ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[900]!,
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
        ),
      ],
    ));
  }
}
