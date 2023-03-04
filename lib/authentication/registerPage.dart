// import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dola/utils/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:dola/authentication/homePage.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

String email = '';
String password = '';
String phoneno = '';
String role = '';
bool show = false;
String public_key_driver = '';
bool formCompleted = false;
String phone = '';
FirebaseAuth auth = FirebaseAuth.instance;

class _RegistrationPageState extends State<RegistrationPage> {
  void validateForm() {
    if (email.length != 0 &&
        password.length > 5 &&
        phone.length != 10 &&
        (role == 'Rider' || (role == 'Driver' && public_key_driver != ''))) {
      formCompleted = true;
    } else {
      formCompleted = false;
    }
  }

  bool signupObscure = true;
  // FirebaseAuth _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        color: Colors.blue[900]!,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * .05,
                    right: MediaQuery.of(context).size.width * .05),
                child: Column(
                  children: [
                    // HeadClipper(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .2,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Email',
                                style: TextStyle(
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0)),
                            SizedBox(height: 10.0),
                            TextField(
                              onChanged: (val) {
                                email = val;
                                setState(() {
                                  validateForm();
                                });
                              },
                              cursorColor: Colors.grey[700],
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold),
                              decoration: customBoxStyle.copyWith(
                                  hintText: 'Enter your e-mail id',
                                  hintStyle: TextStyle(fontSize: 15)),
                            ),
                            const SizedBox(height: 15.0),
                            Text('Password',
                                style: TextStyle(
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0)),
                            SizedBox(height: 10.0),
                            TextField(
                              onChanged: (val) {
                                password = val;
                                setState(() {
                                  validateForm();
                                });
                              },
                              cursorColor: Colors.grey[700],
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold),
                              obscureText: signupObscure,
                              decoration: customBoxStyle.copyWith(
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.remove_red_eye,
                                        color: Colors.grey),
                                    onPressed: () {
                                      setState(() {
                                        signupObscure = signupObscure == true
                                            ? false
                                            : true;
                                      });
                                    },
                                  ),
                                  hintText: 'Minimum 6 characters requires',
                                  hintStyle: TextStyle(fontSize: 15)),
                            ),
                            SizedBox(height: 15.0),
                            
                            Text('Phone Number',
                                style: TextStyle(
                                  color:Colors.grey[700],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0)),
                            SizedBox(height: 10.0),
                            TextField(
                              onChanged: (val) {
                                phoneno = val;
                                setState(() {
                                  validateForm();
                                });
                              },
                              cursorColor: Colors.grey[700],
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold),
                              obscureText: signupObscure,
                              decoration: customBoxStyle.copyWith(
                                  hintText: 'Enter your phone number',
                                  hintStyle: TextStyle(fontSize: 15)),
                            ),
                            SizedBox(height: 15.0),
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                ListTile(
                                  title: const Text('Rider'),
                                  leading: Radio(
                                    value: "Rider",
                                    groupValue: role,
                                    activeColor: Colors.blue[900]!,
                                    onChanged: (value) {
                                      setState(() {
                                        role = value.toString();
                                        show = false;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text('Driver'),
                                  leading: Radio(
                                    value: "Driver",
                                    groupValue:role,
                                    activeColor: Colors.blue[900]!,
                                    onChanged: (value) {
                                      setState(() {
                                        role = value.toString();
                                        show = true;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            if (show)
                              Text('Public Key of Driver',
                                  style: TextStyle(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0)),
                            if (show) SizedBox(height: 10.0),
                            if (show)
                              TextField(
                                onChanged: (val) {
                                  password = val;
                                  setState(() {
                                    validateForm();
                                  });
                                },
                                cursorColor: Colors.grey[700],
                                style: TextStyle(
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.bold),
                                obscureText: signupObscure,
                                decoration: customBoxStyle.copyWith(
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.remove_red_eye,
                                          color: Colors.grey),
                                      onPressed: () {
                                        setState(() {
                                          signupObscure = signupObscure == true
                                              ? false
                                              : true;
                                        });
                                      },
                                    ),
                                    hintText: 'Minimum 6 characters requires',
                                    hintStyle: TextStyle(fontSize: 15)),
                              ),
                            
                            SizedBox(height: 10),
                            Center(
                                child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (formCompleted) {
                                    setState(() {
                                      showSpinner = true;
                                    });
                                    try {
                                      final newUser = await auth
                                          .createUserWithEmailAndPassword(
                                              email: email, password: password);
                                      print(newUser);
                                      print(password);
                                      if (newUser != null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Registered Successfully!')),
                                        );
                                        Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HomePage()),
                                );
                                        setState(() {
                                          showSpinner = false;
                                        });
                                      }
                                    } catch (e) {
                                      print(e);
                                    }
                                  } else {
                                    null;
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: Text(
                                      'Register',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700),
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                            )),
                          ]),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
