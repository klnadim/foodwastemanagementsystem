import 'package:flutter/material.dart';


class DrawerWigets extends StatelessWidget {
   DrawerWigets({Key? key,required this.text,required this.iconData}) : super(key: key);


String text;
IconData iconData;



  @override
  Widget build(BuildContext context) {

    return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.only(top: 10),
                    height: 150,
                    width: double.infinity,
                    color: Colors.black12,
                    child: Column(
                      children:  [
                        CircleAvatar(radius: 45,backgroundImage: Image.asset("assets/images/testimage.JPG").image),
                        const SizedBox(
                          height: 5,
                        ),
                        Text("klnadim27@gmail.com")
                      ],
                    ),
                  ),
                ),
              ),
              Card(child:  ListTile(title: Text(text), leading: Icon(iconData))),
              const Divider(
                color: Colors.black26,
              ),
              
            ],
          ),
        );
    
  }
  
}