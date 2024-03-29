import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_waste_management_system/utils/styles.dart';
import 'package:food_waste_management_system/widgets/custom_snackbar.dart';
import 'package:food_waste_management_system/widgets/dialog_box.dart';

import '../../../models/arguments_return.dart';
import '../../../utils/methods.dart';

class RequestFoodView extends StatefulWidget {
  // final String id;

  const RequestFoodView({
    Key? key,
  }) : super(key: key);
  static const routeName = '/requestFoodView';

  @override
  State<RequestFoodView> createState() => _RequestFoodViewState();
}

bool isDonar = false;

bool isFoodConfirmed = false;

Map? listData;

String? vEmail;
String? vProfilePic;
String? vAddress;
String? vCity;
String? vMobile;
String? vStatus;
String? vUserName;

vUserInfo(String userID) {
  getUsersInfo(userID);
}

class _RequestFoodViewState extends State<RequestFoodView> {
  final TextEditingController _rejectCon = TextEditingController();
  @override
  void initState() {
    gUserData();

    super.initState();
  }

  isFoodRequestConfirmed(docId) {
    var foodRequest = FirebaseFirestore.instance
        .collection('foodRequest')
        .where('documentId', isEqualTo: docId)
        .where('status', isEqualTo: 'confirmed');

    foodRequest.get().then((value) {
      if (value.docs.isNotEmpty) {
        isFoodConfirmed = true;
      } else {
        isFoodConfirmed = false;
      }
      // value.docs.forEach((element) {

      // });
    });
    print(isFoodConfirmed);
  }

  gUserData() async {
    var getUserInfoNGO = await getUsersInfo(getUserId());

    if (getUserInfoNGO != null) {
      vEmail = getUserInfoNGO[0]['email'];
    }
  }

  pGet(String requestId) async {
    var li = await retriveProfileData(requestId);

    print(li);

    if (li != null) {
      listData = li;

      vProfilePic = listData![0]['photoUrl'];
      vUserName = listData![0]['fullName'];
      vMobile = listData![0]['number'];
      vAddress = listData![0]['address'];

      vCity = listData![0]['city'];
    }
  }

  bool dataAvailable = false;

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('addFood');

    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    pGet(args.uid);
    isFoodRequestConfirmed(args.documentId);

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: Text("Food Details"),
          centerTitle: true,
        ),
        body: FutureBuilder<DocumentSnapshot>(
          future: users.doc(args.documentId).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return Text("Document does not exist");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;

              List images = data['imagesUrls'];

              String? vDate = data['date'];

              String _vTime = data['time'];

              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                            color: Colors.grey[300],
                            height: 330,
                            child: Column(
                              children: [
                                Center(
                                    child: Text(
                                  isFoodConfirmed == true ? "Confirmed" : "",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                                Center(
                                    child: Text(
                                  "Requested From:",
                                  style: textstyle(),
                                )),
                                CircleAvatar(
                                  backgroundImage: NetworkImage('$vProfilePic'),
                                  radius: 50,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  ' $vUserName',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '$vEmail',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Card(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  child: ListTile(
                                    leading: Icon(Icons.phone),
                                    title: Text('$vMobile'),
                                  ),
                                ),
                                Card(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  child: ListTile(
                                    leading: Icon(Icons.location_on),
                                    title: Text('$vAddress'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Text(vUserName!),
                          // Text(vEmail!),
                          // Text(vMobile!),

                          isFoodConfirmed
                              ? Container()
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () async {
                                          await updateConInFoodRequestStatus(
                                              status: "confirmed",
                                              addFoodDocId: args.documentId,
                                              requesterUserId: args.uid);

                                          await updateConInAddFoodStatus(
                                                  addFoodDocId: args.documentId,
                                                  status: "confirmed")
                                              .then((value) {
                                            Navigator.pushNamed(
                                                context, '/donarDashboard');
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar(
                                                    "Request Confirmed",
                                                    "",
                                                    () {}));
                                          });
                                        },
                                        child: Text("Confirm")),
                                    ElevatedButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(
                                                    "Enter Rejection reason!",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                  content: TextField(
                                                    controller: _rejectCon,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            "Reject Purpose"),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text("Cancel")),
                                                    TextButton(
                                                      onPressed: () async {
                                                        await updateConInFoodAddStatusReject(
                                                            status: "rejected",
                                                            addFoodDocId:
                                                                args.documentId,
                                                            requesterUserId:
                                                                args.uid,
                                                            rejectionReason:
                                                                _rejectCon
                                                                    .text);

                                                        await updateConInFoodRequestStatusReject(
                                                                status:
                                                                    "rejected",
                                                                addFoodDocId: args
                                                                    .documentId,
                                                                requesterUserId:
                                                                    args.uid,
                                                                rejectionReason:
                                                                    _rejectCon
                                                                        .text)
                                                            .then((value) {
                                                          Navigator.pushNamed(
                                                              context,
                                                              '/donarDashboard');
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  snackBar(
                                                                      "Rejected Done",
                                                                      "",
                                                                      () {}));
                                                        });
                                                      },
                                                      child: Text("Submit"),
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                        child: Text("Reject"))
                                  ],
                                )
                        ],
                      ),
                    ),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 380.0,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 200,
                                width: double.infinity,
                                child: PageView.builder(
                                  itemCount: images.length,
                                  pageSnapping: true,
                                  itemBuilder: (context, pagePosition) {
                                    return Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.white, width: 4),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        margin: EdgeInsets.all(10),
                                        child: Image.network(
                                          images[pagePosition],
                                          fit: BoxFit.fill,
                                        ));
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                data['foodItems'],
                                style: TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Card(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 5.0),
                                clipBehavior: Clip.antiAlias,
                                color: Color.fromARGB(255, 200, 255, 230),
                                elevation: 5.0,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 22.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              "Persons",
                                              style: TextStyle(
                                                color: Colors.redAccent,
                                                fontSize: 22.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              data['foodPerson'].toString(),
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.pinkAccent,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "Valid For",
                                              style: TextStyle(
                                                color: Colors.redAccent,
                                                fontSize: 22.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              "[$vDate" + " " + "$_vTime ]",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.pinkAccent,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "City",
                                              style: TextStyle(
                                                color: Colors.redAccent,
                                                fontSize: 22.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              data['city'],
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.pinkAccent,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Description:",
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontStyle: FontStyle.normal,
                              fontSize: 25.0),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          data['description'],
                          style: TextStyle(
                            fontSize: 20.0,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                            letterSpacing: 2.0,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              );
            }

            return Text("loading");
          },
        ));
  }
}
