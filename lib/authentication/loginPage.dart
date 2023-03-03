import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dola/utils/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

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
        color: Color.fromRGBO(255, 114, 94, 1),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                HeadClipper(),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Username',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0)),
                      SizedBox(height: 10.0),
                      TextField(
                        onChanged: (val) {
                          username = val;
                        },
                        cursorColor: Colors.black,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        decoration: customBoxStyle,
                      ),
                      SizedBox(height: 25.0),
                      Text('Password',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0)),
                      SizedBox(height: 10.0),
                      TextField(
                        onChanged: (val) {
                          password = val;
                        },
                        cursorColor: Colors.black,
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
                                  'Invalid Username or password entered',
                                  style: TextStyle(color: Colors.red)))),
                      SizedBox(height: 35.0),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            showpinner = true;
                          });
                          try {
                            final user = await auth.signInWithEmailAndPassword(
                                email: username, password: password);
                            if (user != null) {
                              setState(() {
                                showpinner = false;
                                invalidCredentials = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Logged In!')),
                              );
                              Navigator.pushNamed(context, '/home');
                            }
                          } catch (e) {
                            setState(() {
                              invalidCredentials = true;
                              showpinner = false;
                            });
                            print(e);
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          margin: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text('Login',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white)),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 114, 94, 1),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(right: 15.0),
                        child: Text('Forgot Password?',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: 40.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account ?  ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/register');
                            },
                            child: Text('Register',
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 114, 94, 1),
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
