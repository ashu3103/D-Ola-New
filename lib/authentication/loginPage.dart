import 'package:dola/authentication/registerPage.dart';
import 'package:dola/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dola/utils/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:web3dart/web3dart.dart';

class LoginPage extends StatefulWidget {
  final Web3Client ethClient;
  const LoginPage({Key? key, required this.ethClient}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loginObscure = true;
  String username = '';
  String password = '';
  // FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool showpinner = false;
  bool invalidCredentials = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showpinner,
        color: Colors.blue[900]!,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                HeadClipper(),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.05, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email',
                          style: TextStyle(
                            color: Color.fromRGBO(94, 90, 90, 1),
                              fontWeight: FontWeight.bold, fontSize: 16.0)),
                      SizedBox(height: 10.0),
                      TextField(
                        onChanged: (val) {
                          username = val;
                        },
                        cursorColor: Color.fromARGB(255, 92, 90, 90),
                        style: TextStyle(
                            color: Color.fromARGB(255, 92, 90, 90), fontWeight: FontWeight.bold),
                        decoration: customBoxStyle,
                      ),
                      SizedBox(height: 25.0),
                      Text('Password',
                          style: TextStyle(
                            color: Color.fromRGBO(94, 90, 90, 1),
                              fontWeight: FontWeight.bold, fontSize: 16.0)),
                      SizedBox(height: 10.0),
                      TextField(
                        onChanged: (val) {
                          password = val;
                        },
                        cursorColor: Color.fromRGBO(94, 90, 90, 1),
                        obscureText: loginObscure,
                        decoration: customBoxStyle.copyWith(
                          suffixIcon: IconButton(
                            icon:
                                Icon(Icons.remove_red_eye, color: Colors.grey),
                            onPressed: () {
                              setState(() {
                                loginObscure =
                                    loginObscure == true ? false : true;
                              });
                            },
                          ),
                        ),
                      ),
                      Visibility(
                          visible: invalidCredentials,
                          child: Center(
                              child: Text(
                                  'Invalid Email or password entered',
                                  style: TextStyle(color: Colors.red)))),
                      SizedBox(height: 35.0),
                      Center(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              showpinner = true;
                            });
                            try {
                              final user =
                                  await auth.signInWithEmailAndPassword(
                                      email: username, password: password);
                              if (user != null) {
                                setState(() {
                                  showpinner = false;
                                  invalidCredentials = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Logged In!')),
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Home(role:"Rider", ethClient: widget.ethClient)),
                                );
                              }
                            } catch (e) {
                              setState(() {
                                invalidCredentials = true;
                                showpinner = false;
                              });
                              print(e);
                            }
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
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w700),
                                textAlign: TextAlign.center,
                              )),
                        ),
                      )),
                      SizedBox(height: 5.0),
                      Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(right: 15.0),
                        child: Text('Forgot Password?',
                            style: TextStyle(
                                color:Colors.grey[700],
                                fontSize: 15.0, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: 40.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account ?  ',
                              style: TextStyle(  color:Colors.grey[700], fontSize:15,fontWeight: FontWeight.bold)),
                          GestureDetector(
                            onTap: () {
                            Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RegistrationPage(ethClient: widget.ethClient,)),
                                );
                            },
                            child:  Text('Register',
                                style: TextStyle(
                                    color: Colors.blue[900]!,
                                    fontWeight: FontWeight.bold)),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
