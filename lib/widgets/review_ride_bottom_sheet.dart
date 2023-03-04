import 'package:dola/screens/rideStatus.dart';
import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import '../helpers/shared_prefs.dart';
import '../screens/turn_by_turn.dart';
import 'package:dola/services/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

Widget reviewRideBottomSheet(
    BuildContext context, String distance, String dropOffTime, Web3Client ethClient) {
  String sourceAddress = getSourceAndDestinationPlaceText('source');
  String destinationAddress = getSourceAndDestinationPlaceText('destination');
  print("dist");
  print(distance);
  print(double.parse(distance));
  int passDistance = double.parse(distance).round();
  String fare=(double.parse(distance)*8).toString();
  print(fare);

  return Positioned(
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
                Text('$sourceAddress ➡ $destinationAddress',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.blue[900]!)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    tileColor: Colors.grey[200],
                    leading: const Image(
                        image: AssetImage('assets/image/sport-car.png'),
                        height: 50,
                        width: 50),
                    title: const Text('Premier',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Text('$distance km, $dropOffTime drop off'),
                    trailing:  Text('$fare Rs',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      String? email = auth.currentUser!.email;  
                      dynamic l = await getRider(email!, ethClient);
                      print(l[0][4]);
                      await createRideRequest(sourceAddress, destinationAddress, DateTime.now().toString(), email,passDistance, l[0][4], ethClient);
                      Navigator.push(context,
                        MaterialPageRoute(builder: (_) => RideStatus(ethClient: ethClient)));
                      },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(20)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Start your premier ride now'),
                        ])),
              ]),
        ),
      ),
    ),
  );
}
