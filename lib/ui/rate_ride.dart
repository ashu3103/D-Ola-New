import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:web3dart/web3dart.dart';

import '../screens/home.dart';

class RateRide extends StatelessWidget {
  final Web3Client ethClient;
  const RateRide({Key? key, required this.ethClient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text('Payment Done', style: Theme.of(context).textTheme.titleLarge),
      Icon(Icons.check_circle_outline_outlined,size:30,color:Colors.green),
       Text('Rate your Ride', style: Theme.of(context).textTheme.titleLarge),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Center(
          child: RatingBar.builder(
            initialRating: 0,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
        ),
      ),
      ElevatedButton(
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => Home(role:"Driver", ethClient: ethClient,name: "g",email:"fe"))),
          child: const Text('Start another ride'))
    ]));
  }
}
