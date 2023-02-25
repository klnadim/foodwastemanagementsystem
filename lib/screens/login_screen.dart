import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_waste_management_system/screens/admin_panel.dart';
import 'package:food_waste_management_system/screens/donar_dashboard_screen.dart';
import 'package:food_waste_management_system/screens/home_screen.dart';
import 'package:food_waste_management_system/screens/ngo_dashboard.dart';
import 'package:food_waste_management_system/screens/signup_screen.dart';
import 'package:food_waste_management_system/utils/styles.dart';
// import 'Student.dart';
// import 'Teacher.dart';
// import 'register.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure3 = true;
  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   emailController.dispose();
  //   passwordController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: allbgcolor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: const Color(0xffe6efff),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.70,
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(12),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                            fontSize: 40,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green)),

                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Email',
                            // hintStyle: TextStyle(color),
                            enabled: true,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black45),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black45),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email cannot be empty";
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("Please enter a valid email");
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            emailController.text = value!;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: _isObscure3,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(_isObscure3
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _isObscure3 = !_isObscure3;
                                  });
                                }),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Password',
                            enabled: true,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 15.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.black45),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.black45),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            RegExp regex = RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return "Password cannot be empty";
                            }
                            if (!regex.hasMatch(value)) {
                              return ("please enter valid password min. 6 character");
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            passwordController.text = value!;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(5),
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 58, 93, 109)),
                            // shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))))
                          ),
                          // shape:  border(
                          //     borderRadius:
                          //         BorderRadius.all(Radius.circular(20.0))),
                          // elevation: 5.0,
                          // height: 40,
                          onPressed: () {
                            setState(() {
                              visible = true;
                            });
                            signIn(emailController.text.trim(),
                                passwordController.text.trim());
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          // color: Colors.white,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Visibility(
                            maintainSize: true,
                            maintainAnimation: true,
                            maintainState: true,
                            visible: visible,
                            child: Container(
                                child: CircularProgressIndicator(
                              color: Colors.white,
                            ))),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              color: const Color(0xffe6efff),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),

                    ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(5),
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 58, 93, 109)),
                        // shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))))
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "SignUp",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    )
                    // MaterialButton(
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.all(
                    //       Radius.circular(20.0),
                    //     ),
                    //   ),
                    //   elevation: 5.0,
                    //   height: 40,
                    //   onPressed: () {
                    //     Navigator.pushReplacement(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => SignUpScreen(),
                    //       ),
                    //     );
                    //   },
                    //   color: Colors.blue[900],
                    //   child: Text(
                    //     "Register Now",
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //       fontSize: 20,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    print(user);
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('rool') == "Admin") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AdminPanelScreen(),
            ),
          );
        } else if (documentSnapshot.get('rool') == "NGO") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => NgoDashboardScreen(),
            ),
          );
        } else if (documentSnapshot.get('rool') == "DONAR") {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => DonarDashboardScreen(),
              ));
        } else {
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => HomeScreen(),
          //   ),
          // );
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        route();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          return showDialog(
              context: context,
              builder: (contex) => AlertDialog(
                    title: Text("No user found for that email."),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ));
          // print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          Text('Wrong password provided for that user.');
        }
      }
    }
  }
}
