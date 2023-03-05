import 'package:web3dart/web3dart.dart';
import 'package:flutter/services.dart';
import 'package:dola/utils/constants.dart';

Future<DeployedContract> loadContract() async {
  String abi = await rootBundle.loadString('assets/abi.json');
  final contract = DeployedContract(ContractAbi.fromJson(abi, 'Dola'),
      EthereumAddress.fromHex(contractAddress));
  return contract;
}

Future<String> callFunction(String funcname, List<dynamic> args,
    Web3Client ethClient, String privateKey, BigInt value) async {
  EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
  DeployedContract contract = await loadContract();
  final ethFunction = contract.function(funcname);
  final result = await ethClient.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: ethFunction,
        parameters: args,
        value: EtherAmount.fromUnitAndValue(EtherUnit.ether, value),
      ),
      chainId: null,
      fetchChainIdFromNetworkId: true);
  return result;
}

Future<List<dynamic>> ask(
    String funcName, List<dynamic> args, Web3Client ethClient) async {
  final contract = await loadContract();
  final ethFunction = contract.function(funcName);
  final result =
  ethClient.call(contract: contract, function: ethFunction, params: args);
  return result;
}

Future<String> registerRider(String name, String phone, String email, String pvtKey, Web3Client ethClient) async {
  var response = await callFunction('registerRider', [name, phone, email, pvtKey], ethClient, pvtKey, BigInt.from(0));
  print('Rider registered successfully');
  return response;
}

Future<String> registerDriver(String address, String name, String phone, String email, String pvtKey, Web3Client ethClient) async {
  var response = await callFunction('registerDriver', [EthereumAddress.fromHex(address), name, phone, email, pvtKey], ethClient, pvtKey, BigInt.from(0));
  print('Driver registered successfully');
  return response;
}

Future<List> getRider(String email, Web3Client ethClient) async {
  List<dynamic> result = await ask('getRider', [email], ethClient);
  print(result);
  return result;
}

Future<List> getDriver(String email, Web3Client ethClient) async {
  List<dynamic> result = await ask('getDriver', [email], ethClient);
  print(result);
  return result;
}

Future<String> createRideRequest (String source, String destination, String dateOfRide, String riderEmail,int distance, String pvtKey, Web3Client ethClient) async {

  List<dynamic> args = [source,destination,dateOfRide,riderEmail];
  // print(args.runtimeType);
  print(args);
  var response = await callFunction('createRideRequest', [source,destination,dateOfRide,riderEmail,BigInt.from(1),BigInt.from(distance)], ethClient, pvtKey, BigInt.from(0));
  print('created ride successfully');
  return response;
}

Future<String> acceptIncomingRide (String driverEmail, String riderEmail, String pvtKey, Web3Client ethClient) async {

  var response = await callFunction('acceptIncomingRide', [driverEmail,riderEmail], ethClient, pvtKey, BigInt.from(0));
  print('Accepted incoming successfully');
  return response;
}

Future<String> pickUp (String driverEmail, String pvtKey, Web3Client ethClient) async {

  var response = await callFunction('pickUp', [driverEmail], ethClient, pvtKey, BigInt.from(0));
  print('Pick Up successfully');
  return response;
}

Future<String> payFare (String riderEmail, String pvtKey, BigInt _fare, Web3Client ethClient) async {

  var response = await callFunction('payFare', [riderEmail], ethClient, pvtKey, _fare);
  print('Payment ended successfully');
  return response;
}


Future<List> getRideStatus(String riderEmail, Web3Client ethClient) async {
  List<dynamic> result = await ask('getRideStatus', [riderEmail], ethClient);
  print(result);
  return result;
}

Future<List> getUserRides(String userEmail, Web3Client ethClient) async {
  print("LAst rides from backend");
  List<dynamic> result =  await ask('getUserRides', [userEmail], ethClient);
  
  print(result);
  return result;
}

Future<String> updateAllCurrentRideRequests (String pvtKey, Web3Client ethClient) async {
  var response = await callFunction('updateAllCurrentRideRequests', [], ethClient, pvtKey, BigInt.from(0));
  print('Updated list successfully');
  return response;
}

Future<List> getAllCurrentRideRequests (Web3Client ethClient) async {
  List<dynamic> result =  await ask('getAllCurrentRideRequests', [], ethClient);
  print(result);
  return result;
}

Future<List> getOngoingRide (String email, Web3Client ethClient) async {
  List<dynamic> result =  await ask('getOngoingRide', [email], ethClient);
  print(result);
  return result;
}

Future<List> getUserType (String email, Web3Client ethClient) async {
  List<dynamic> result =  await ask('getUserType', [email], ethClient);
  print(result);
  return result;
}
