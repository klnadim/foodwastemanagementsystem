import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_waste_management_system/utils/methods.dart';
import 'package:food_waste_management_system/widgets/dialog_box.dart';
import 'package:image_picker/image_picker.dart';

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
  TextEditingController validityHourCon = TextEditingController();
  TextEditingController foodPersonCon = TextEditingController();
  TextEditingController contactCon = TextEditingController();
  // TextEditingController foodImageCon = TextEditingController();

  String foodItem = "";
  String descriotion = "";
  String bodyTemp = "";
  // Uint8List<List> _image = [];

  // var measure;

  String? selectedPerson;

  String publicOrPrivate = 'public';

  // BuildContext? dcontext;

  // dismissDailog() {
  //   if (dcontext != null) {
  //     Navigator.pop(dcontext!);
  //   }
  // }

  //Multiple Image Pick

  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;
  List<String> imgUrls = [];

  openImages() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedfiles != null) {
        imagefiles = pickedfiles;
        setState(() {});
        print("Picked");
        print(imagefiles!.length);
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  //

  // void selectMultImg(ImageSource source) async {
  //   Uint8List im = await pickMultiImag(ImageSource.gallery);
  //   setState(() {
  //     _images = im as List<XFile>;
  //     print("PickedImg");
  //   });
  // }

  // void savePhoto() async {
  //   List<String> imgUrls = [];

  //   for (int i = 0; i < images.length; i++) {
  //     String urls = await uploadToStorageMultiImg("fffff", images[i]);

  //     print(urls);
  //     // imgUrls.add(urls.toString());
  //   }
  //   // print(imgUrls);
  // }

  void _submit(List<XFile> images) async {
    // showDialog<void>(
    //   context: context,
    //   barrierDismissible: true, // user can tap anywhere to close the pop up
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: const Text('Your information has been submitted'),
    //       content: SingleChildScrollView(
    //         child: Column(
    //           children: <Widget>[
    //             const Align(
    //                 alignment: Alignment.topLeft,
    //                 child: Text("Full name:",
    //                     style: TextStyle(fontWeight: FontWeight.w700))),
    //             Align(
    //               alignment: Alignment.topLeft,
    //               // child: Text(firstName + " " + lastName),
    //             ),
    //             const SizedBox(
    //               height: 10,
    //             ),
    //             const Align(
    //                 alignment: Alignment.topLeft,
    //                 child: Text("Body Temperature:",
    //                     style: TextStyle(fontWeight: FontWeight.w700))),
    //             Align(
    //               alignment: Alignment.topLeft,
    //               child: Text("$bodyTemp ${measure == 1 ? "ºC" : "ºF"}"),
    //             )
    //           ],
    //         ),
    //       ),
    //       actions: <Widget>[
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: <Widget>[
    //             TextButton(
    //               style: TextButton.styleFrom(
    //                 primary: Colors.white,
    //                 backgroundColor: Colors.grey,
    //                 shape: const RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.all(Radius.circular(10))),
    //               ),
    //               child: const Text('Go to profile'),
    //               onPressed: () async {
    //                 FocusScope.of(context)
    //                     .unfocus(); // unfocus last selected input field
    //                 Navigator.pop(context);
    //                 // Open my profile

    //                 setState(() {});
    //               }, // so the alert dialog is closed when navigating back to main page
    //             ),
    //             TextButton(
    //               style: TextButton.styleFrom(
    //                 primary: Colors.white,
    //                 backgroundColor: Colors.blue,
    //                 shape: const RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.all(Radius.circular(10))),
    //               ),
    //               child: const Text('OK'),
    //               onPressed: () {
    //                 Navigator.of(context).pop(); // Close the dialog
    //                 FocusScope.of(context)
    //                     .unfocus(); // Unfocus the last selected input field
    //                 _formKey.currentState?.reset(); // Empty the form fields
    //               },
    //             )
    //           ],
    //         )
    //       ],
    //     );
    //   },
    // );

    User? user = FirebaseAuth.instance.currentUser;

    List<String> imgUrls = [];

    for (int i = 0; i < images.length; i++) {
      String urls = await uploadToStorageMultiImg("addFoodImage", images[i]);

      imgUrls.add(urls);
    }

    addFoodSubmit(
        foodItemCon.text,
        descriotionCon.text,
        addressCon.text,
        cityCon.text,
        validityHourCon.text,
        int.parse(foodPersonCon.text),
        contactCon.text,
        publicOrPrivate,
        DateTime.now(),
        imgUrls,
        user!.uid);

    clearAllField();
  }

  @override
  void dispose() {
    // foodImageCon.dispose();
    descriotionCon.dispose();
    addressCon.dispose();
    cityCon.dispose();
    validityHourCon.dispose();
    foodPersonCon.dispose();
    contactCon.dispose();
    imagefiles!.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                      controller: foodItemCon,
                      decoration: const InputDecoration(
                          labelText: 'Food Items',
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
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
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 3) {
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
                      controller: descriotionCon,
                      decoration: const InputDecoration(
                          labelText: 'Description',
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
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
                      controller: foodPersonCon,
                      decoration: const InputDecoration(
                          labelText: 'Person For',
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
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
                    // DropdownButtonFormField<String>(
                    //   value: selectedPerson,
                    //   hint: Text(
                    //     'Persons',
                    //   ),
                    //   onChanged: (usertype) =>
                    //       setState(() => selectedPerson = usertype!),
                    //   validator: (value) =>
                    //       value == null ? 'field required' : null,
                    //   items: ['1-5', 'DONAR']
                    //       .map<DropdownMenuItem<String>>((String value) {
                    //     return DropdownMenuItem<String>(
                    //       value: value,
                    //       child: Text(value),
                    //     );
                    //   }).toList(),
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),

                    TextFormField(
                      controller: addressCon,
                      decoration: const InputDecoration(
                          labelText: 'Address',
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
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
                      controller: cityCon,
                      decoration: const InputDecoration(
                          labelText: 'City',
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
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
                      controller: validityHourCon,
                      decoration: const InputDecoration(
                          labelText: 'Validity Hours',
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
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
                      controller: contactCon,
                      decoration: const InputDecoration(
                          labelText: 'Contact Number',
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
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
                    //         child: Text("ºC"),
                    //         value: 1,
                    //       ),
                    //        DropdownMenuItem(
                    //         child: Text("ºF"),
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
                    TextButton.icon(
                        onPressed: () {
                          openImages();
                        },
                        icon: Icon(Icons.image),
                        label: Text("Select Images")),

                    imagefiles != null
                        ? Wrap(
                            children: imagefiles!.map((imageone) {
                              return Container(
                                  child: Card(
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  child: Image.file(File(imageone.path)),
                                ),
                              ));
                            }).toList(),
                          )
                        : Container(),
                    const SizedBox(
                      height: 20,
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    Column(children: [
                      Text(
                        "Will you donated privately or publicly?",
                        style: TextStyle(fontSize: 18),
                      ),
                      Divider(),
                      RadioListTile(
                        title: Text("Public"),
                        value: "public",
                        groupValue: publicOrPrivate,
                        onChanged: (value) {
                          setState(() {
                            publicOrPrivate = value.toString();
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text("Private"),
                        value: "private",
                        groupValue: publicOrPrivate,
                        onChanged: (value) {
                          setState(() {
                            publicOrPrivate = value.toString();
                          });
                        },
                      )
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          // style: ElevatedButton.styleFrom(
                          //     minimumSize: const Size.fromHeight(60)),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.purple,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 35, vertical: 15),
                              textStyle: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400)),

                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(' Confrimation'),
                                    content: Text(
                                        'Are you sure to Donating this food?'),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              _submit(imagefiles!);
                                            }

                                            Navigator.pushNamed(
                                                context, '/addFood');
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //       builder: (context) =>
                                            //           DonnarAddFood(),
                                            //     ));
                                          },
                                          child: Text('Confirm')),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context); //close Dialog
                                        },
                                        child: Text('Cancel'),
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: const Text("Submit"),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blueGrey,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 35, vertical: 15),
                              textStyle: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                            ),
                            onPressed: () {
                              setState(() {});
                              clearAllField();
                            },
                            child: Text("Clear"))
                      ],
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

  void clearAllField() {
    foodItemCon.clear();
    descriotionCon.clear();
    addressCon.clear();
    cityCon.clear();
    validityHourCon.clear();
    foodPersonCon.clear();
    contactCon.clear();
    imagefiles!.clear();
  }
}

extension StringExtension on String {
  // Method used for capitalizing the input from the form
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
