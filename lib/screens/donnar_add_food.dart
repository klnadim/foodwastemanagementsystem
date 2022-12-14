import 'package:flutter/material.dart';

class DonnarAddFood extends StatefulWidget {
  const DonnarAddFood({Key? key}) : super(key: key);

  @override
  State<DonnarAddFood> createState() => _DonnarAddFoodState();
}

class _DonnarAddFoodState extends State<DonnarAddFood> {

final GlobalKey<FormState> _formKey = GlobalKey();

TextEditingController foodItemCon = TextEditingController();
TextEditingController descriotionCon = TextEditingController();
TextEditingController addressCon = TextEditingController();
TextEditingController cityCon = TextEditingController();
TextEditingController pickDateCon = TextEditingController();
TextEditingController weightCon = TextEditingController();
TextEditingController contactCon = TextEditingController();
TextEditingController foodImageCon = TextEditingController();



String foodItem = "";
String descriotion = "";
String bodyTemp = "";
  var measure;



  void _submit() {
    showDialog<void>(
      context: context,
      barrierDismissible: true, // user can tap anywhere to close the pop up
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Your information has been submitted'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text("Full name:",
                        style: TextStyle(fontWeight: FontWeight.w700))),
                Align(
                  alignment: Alignment.topLeft,
                  // child: Text(firstName + " " + lastName),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text("Body Temperature:",
                        style: TextStyle(fontWeight: FontWeight.w700))),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("$bodyTemp ${measure == 1 ? "??C" : "??F"}"),
                )
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.grey,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  child: const Text('Go to profile'),
                  onPressed: () async {
                    FocusScope.of(context)
                        .unfocus(); // unfocus last selected input field
                    Navigator.pop(context);
                    await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MyProfilePage())) // Open my profile
                        .then((_) => _formKey.currentState
                            ?.reset()); // Empty the form fields
                    setState(() {});
                  }, // so the alert dialog is closed when navigating back to main page
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    FocusScope.of(context)
                        .unfocus(); // Unfocus the last selected input field
                    _formKey.currentState?.reset(); // Empty the form fields
                  },
                )
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Food Added "),
        // actions: <Widget>[
        //   IconButton(
        //     icon: const Icon(Icons.account_circle, size: 32.0),
        //     tooltip: 'Profile',
        //     onPressed: () {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => MyProfilePage(),
        //           ));
        //     },
        //   ),
        // ],
      ), 
      
        body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              const Align(
                alignment: Alignment.topLeft,
                child: Text("Enter your data",
                    style: TextStyle(
                      fontSize: 24,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Food Items',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          border: OutlineInputBorder()),
                      onFieldSubmitted: (value) {
                        setState(() {
                          // firstName = value.capitalize();
                          // firstNameList.add(firstName);
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          // firstName = value.capitalize();
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty || value.length < 3) {
                          return 'This field is required and cannot be empty';
                        } 
                        // else if (value.contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                        //   return 'First Name cannot contain special characters';
                        // }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Description',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty ) {
                          return 'This field is required and cannot be empty';
                        } 
                        // else if (value.contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                        //   return 'Last Name cannot contain special characters';
                        // }
                      },
                      onFieldSubmitted: (value) {
                        setState(() {
                          // lastName = value.capitalize();
                          // lastNameList.add(lastName);
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          // lastName = value.capitalize();
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Address',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty ) {
                          return 'This field is required and cannot be empty';
                        } 
                        // else if (value.contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                        //   return 'Last Name cannot contain special characters';
                        // }
                      },
                      onFieldSubmitted: (value) {
                        setState(() {
                          // lastName = value.capitalize();
                          // lastNameList.add(lastName);
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          // lastName = value.capitalize();
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'City',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty ) {
                          return 'This field is required and cannot be empty';
                        } 
                        // else if (value.contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                        //   return 'Last Name cannot contain special characters';
                        // }
                      },
                      onFieldSubmitted: (value) {
                        setState(() {
                          // lastName = value.capitalize();
                          // lastNameList.add(lastName);
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          // lastName = value.capitalize();
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Pick Date',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty ) {
                          return 'This field is required and cannot be empty';
                        } 
                        // else if (value.contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                        //   return 'Last Name cannot contain special characters';
                        // }
                      },
                      onFieldSubmitted: (value) {
                        setState(() {
                          // lastName = value.capitalize();
                          // lastNameList.add(lastName);
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          // lastName = value.capitalize();
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Weights',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty ) {
                          return 'This field is required and cannot be empty';
                        } 
                        // else if (value.contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                        //   return 'Last Name cannot contain special characters';
                        // }
                      },
                      onFieldSubmitted: (value) {
                        setState(() {
                          // lastName = value.capitalize();
                          // lastNameList.add(lastName);
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          // lastName = value.capitalize();
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),




                    TextFormField(
                      maxLength: 11,
                      decoration: const InputDecoration(
                          labelText: 'Contact Number',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            
                            value.contains(RegExp(r'^[a-zA-Z\-]'))) {
                          return 'Use only numbers!';
                        }
                      },
                      onFieldSubmitted: (value) {
                        setState(() {
                          bodyTemp = value;
                          // bodyTempList.add(bodyTemp);
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          bodyTemp = value;
                        });
                      },
                    ),
                    
                    
                    
                    const SizedBox(
                      height: 20,
                    ),
                    // DropdownButtonFormField(
                    //     decoration: const InputDecoration(
                    //         enabledBorder: OutlineInputBorder(
                    //           borderRadius:
                    //               BorderRadius.all(Radius.circular(20.0)),
                    //           borderSide:
                    //               BorderSide(color: Colors.grey, width: 0.0),
                    //         ),
                    //         border: OutlineInputBorder()),
                    //     items:const [
                    //        DropdownMenuItem(
                    //         child: Text("??C"),
                    //         value: 1,
                    //       ),
                    //        DropdownMenuItem(
                    //         child: Text("??F"),
                    //         value: 2,
                    //       )
                    //     ],
                    //     hint: const Text("Select item"),
                    //     onChanged: (value) {
                    //       setState(() {
                    //         measure = value;
                    //         // measureList.add(measure);
                    //       });
                    //     },
                    //     onSaved: (value) {
                    //       setState(() {
                    //         measure = value;
                    //       });
                    //     }),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(60)),
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          _submit();
                        }
                      },
                      child: const Text("Submit"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
     
class MyProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: <Widget>[
          Row(children: <Widget>[
            const Text("New data",
                style: TextStyle(
                  fontSize: 24,
                )),
            const Spacer(),
            ElevatedButton(
              child: const Text('New'),
              onPressed: () => Navigator.pop(context),
            )
          ]), 
        ]),
      ),
    );
  }
}

extension StringExtension on String {
  // Method used for capitalizing the input from the form
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
