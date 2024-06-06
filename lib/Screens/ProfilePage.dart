import 'package:bloggie/Navigations/BottomTabBar.dart';
import 'package:bloggie/Widgets/addPhoto.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  static const String path = "lib/src/pages/profile/profile1.dart";

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _takenPhoto;
  File? _pickedImageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.deepOrange,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
            height: 100.0,
            width: 100.0,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, width: 5.0),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              iconSize: 20.0,
              icon: const Icon(
                Icons.arrow_back_ios_new_sharp,
                size: 16,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const BottomTabBar(),
                ));
              },
            ),
          ),
        ),
        title: const Text("View Profile"),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 200,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: const [0.5, 0.9],
                    colors: [Colors.blue, Colors.blue.shade300])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.lightBlue.shade300,
                      child: CircleAvatar(
                        radius: 50,
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ImageInput(
                              onPickImage: (image) {
                                _takenPhoto = image;
                              },
                            )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Ani Prince",
                  style: TextStyle(fontSize: 22.0, color: Colors.white),
                ),
                const Text(
                  "Enugu, Nigeria",
                  style: TextStyle(fontSize: 14.0, color: Colors.white),
                )
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Colors.lightBlue.shade300,
                  child: const ListTile(
                    title: Text(
                      "14",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0),
                    ),
                    subtitle: Text(
                      "READS",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: const Color.fromARGB(255, 147, 208, 239),
                  child: const ListTile(
                    title: Text(
                      "0",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0),
                    ),
                    subtitle: Text(
                      "SAVES",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const ListTile(
            title: Text(
              "Email",
              style: TextStyle(color: Colors.blueAccent, fontSize: 12.0),
            ),
            subtitle: Text(
              "aniprince442@gmail.com",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          const Divider(),
          const ListTile(
            title: Text(
              "Phone",
              style: TextStyle(color: Colors.blueAccent, fontSize: 12.0),
            ),
            subtitle: Text(
              "+234 9018225533",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          const Divider(),
          const ListTile(
            title: Text(
              "Twitter",
              style: TextStyle(color: Colors.blueAccent, fontSize: 12.0),
            ),
            subtitle: Text(
              "@chelloobee",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          const Divider(),
          const ListTile(
            title: Text(
              "Date Joined",
              style: TextStyle(color: Colors.blueAccent, fontSize: 12.0),
            ),
            subtitle: Text(
              "14th Dec 2023",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
