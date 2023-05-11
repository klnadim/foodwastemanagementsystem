import 'dart:io';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_waste_management_system/screens/donar/donationMade/on_going_req.dart';
import 'package:food_waste_management_system/utils/methods.dart';
import 'package:food_waste_management_system/widgets/dialog_box.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../widgets/custom_snackbar.dart';

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

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  String foodItem = "";
  String descriotion = "";
  String bodyTemp = "";

//For Date and Time Picke
  double? _height;
  double? _width;
  String? _setTime, _setDate;
  String? _hour, _minute, _time;
  String? dateTime;

  String? _vTime;
  String? _vDateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
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

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour! + ' : ' + _minute!;
        _timeController.text = _time!;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();

        print(_vTime =
            formatDate(DateTime.now(), [HH, ':', nn, ':', ss]).toString());
      });
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

    await addFoodSubmit(
        foodItemCon.text,
        descriotionCon.text,
        addressCon.text,
        cityCon.text,
        validityHourCon.text,
        int.parse(foodPersonCon.text),
        contactCon.text,
        _dateController.text,
        _timeController.text,
        _vTime!,
        imgUrls,
        user!.uid,
        "");

    clearAllField();
  }

  @override
  void initState() {
    _dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    super.initState();
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
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    dateTime = DateFormat.yMd().format(DateTime.now());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text("Food Added "),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
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
                        onFieldSubmitted: (value) {},
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
                        },
                        onFieldSubmitted: (value) {},
                        onChanged: (value) {},
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
                        onFieldSubmitted: (value) {},
                        onChanged: (value) {},
                      ),
                      const SizedBox(
                        height: 20,
                      ),
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
                        },
                        onFieldSubmitted: (value) {},
                        onChanged: (value) {},
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
                        },
                        onFieldSubmitted: (value) {},
                        onChanged: (value) {},
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.topEnd,
                            // fit: StackFit.loose,
                            children: [
                              SizedBox(
                                width: _width! / 2.2,
                                child: TextFormField(
                                  controller: _dateController,
                                  onSaved: (String? val) {
                                    _setDate = val;
                                  },
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                      labelText: 'Validity Date',
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0)),
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 0.0),
                                      ),
                                      border: OutlineInputBorder()),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This field is required and cannot be empty';
                                    }
                                  },
                                  onFieldSubmitted: (value) {},
                                  onChanged: (value) {},
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  _selectDate(context);
                                },
                                // highlightColor: Colors.greenAccent,

                                child: Icon(Icons.calendar_month, size: 50),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Stack(
                            alignment: AlignmentDirectional.topEnd,
                            // fit: StackFit.loose,
                            children: [
                              SizedBox(
                                width: _width! / 2.5,
                                child: TextFormField(
                                  controller: _timeController,
                                  onSaved: (String? val) {
                                    _setDate = val;
                                  },
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                      labelText: 'Time',
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0)),
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 0.0),
                                      ),
                                      border: OutlineInputBorder()),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This field is required and cannot be empty';
                                    }
                                  },
                                  onFieldSubmitted: (value) {},
                                  onChanged: (value) {},
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  _selectTime(context);
                                },
                                // highlightColor: Colors.greenAccent,

                                child: Icon(Icons.timer, size: 50),
                              ),
                            ],
                          )
                        ],
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
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar(
                                                      "Add Your Food Successfully.",
                                                      "",
                                                      () {}));
                                              Navigator.pop(
                                                  context); //close Dialog

                                              Navigator.pushNamed(
                                                  context, '/requestMode');
                                            },
                                            child: Text('Confirm')),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(
                                                context); //close Dialog
                                          },
                                          child: Text('Cancel'),
                                        ),
                                      ],
                                    );
                                  });

                              // Navigator.pop(context);
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
      ),
    );
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
