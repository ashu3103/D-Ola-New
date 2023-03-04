import 'package:dola/authentication/loginPage.dart';
import 'package:dola/authentication/registerPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              // gradient: LinearGradient(
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   colors: [
              //     Color(0xffE6E6E6),
              //     Color(0xff14279B)
              //   ],
              // )
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
               
                  Text("D'Ola", style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w900, color:  Colors.blue[900]!,)),
                  // Text('IFY', style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w900, color: Colors.black))
                ],
              ),
                 Image.asset("assets/image/main-bg.png",width:MediaQuery.of(context).size.width*.6),
              // SizedBox(height: MediaQuery.of(context).size.height * 0.25),
              Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
             Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginPage()),
                                );
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            Colors.blue[900]!,),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ))),
                    child: Container(
                        padding: const EdgeInsets.all(12),
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        )),
                  ),
                )),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
             Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegistrationPage()),
                                );
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            Colors.blue[900]!,),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ))),
                    child: Container(
                        padding: const EdgeInsets.all(12),
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                          'Register',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        )),
                  ),
                )),
               
            ],
          ),
        ),
      ),
    );
  }
}