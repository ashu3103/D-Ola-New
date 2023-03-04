import 'package:flutter/material.dart';
import 'package:dola/services/functions.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'package:dola/utils/constants.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late Client httpClient;
  late Web3Client ethClient;

  @override
  void initState() {
    super.initState();
    httpClient = Client();
    ethClient = Web3Client(infure_url, httpClient);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: (){
                  registerRider('Shashwat', '7742127497', 's@gmail.com', '867cc6e7a38475a92ab406d4e59113f80c5a2b1ad654e0f7a4f7f80fcec7ff72', ethClient);
                },
                child: Text('Register Rider')
            ),
            ElevatedButton(
                onPressed: (){
                  registerDriver('0x58F4d837b759fCe18A0B99Bdeb230cb6750fA641', 'Random', '123456789', 'random@gmail.com', '473aa0700c82141734112a734fb89f606724b4407c4aec8d7cb86a9cd28daa4e', ethClient);
                },
                child: Text('Register Driver')
            ),
            ElevatedButton(
                onPressed: (){
                  getRider('palak@gmail.com', ethClient);
                },
                child: Text('Get Rider Details')
            ),
            ElevatedButton(
                onPressed: (){
                  // createRideRequest('Delhi', 'Jaipur', '12/12/12', 's@gmail.com', '867cc6e7a38475a92ab406d4e59113f80c5a2b1ad654e0f7a4f7f80fcec7ff72', ethClient);
                },
                child: Text('Create Ride Request')
            ),
            ElevatedButton(
                onPressed: (){
                  acceptIncomingRide('random@gmail.com', 's@gmail.com', '473aa0700c82141734112a734fb89f606724b4407c4aec8d7cb86a9cd28daa4e', ethClient);
                },
                child: Text('Accept Ride')
            ),
            ElevatedButton(
                onPressed: (){
                  pickUp('random@gmail.com', '473aa0700c82141734112a734fb89f606724b4407c4aec8d7cb86a9cd28daa4e', ethClient);
                },
                child: Text('Picked Up')
            ),
            ElevatedButton(
                onPressed: (){
                  getRideStatus('s@gmail.com', ethClient);
                },
                child: Text('Get Ride Status')
            ),
            ElevatedButton(
                onPressed: (){
                  payFare('s@gmail.com', '867cc6e7a38475a92ab406d4e59113f80c5a2b1ad654e0f7a4f7f80fcec7ff72', 0, ethClient);
                },
                child: Text('Pay Fare')
            )
          ],
        ),
      ),
    );
  }
}
