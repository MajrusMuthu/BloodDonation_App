// ignore_for_file: avoid_print, unnecessary_cast, prefer_const_constructors, non_constant_identifier_names, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => InputPageState();
}

class InputPageState extends State<InputPage> {
  TextEditingController donorName = TextEditingController();
  TextEditingController donorPhone = TextEditingController();
  final List<String> bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-'
  ];
  String? selectedGroup;
  final CollectionReference donor =
      FirebaseFirestore.instance.collection("donor");

  void addDonor() {
    final data = {
      'name': donorName.text,
      'phone': donorPhone.text,
      'group': selectedGroup
    };
    donor.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Donor Details",
            style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              controller: donorName,
              cursorColor: Colors.red,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                labelText: "Donor Name",
                labelStyle: TextStyle(color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              controller: donorPhone,
              keyboardType: TextInputType.number,
              maxLength: 10,
              cursorColor: Colors.red,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                labelText: "Mobile Number",
                labelStyle: TextStyle(color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: 250,
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 242, 0, 0)),
                  ),
                ),
                elevation: 10,
                hint: const Text("Select your Blood Group"),
                dropdownColor: Colors.grey.shade100,
                items: bloodGroups.map(
                  (group) => DropdownMenuItem(
                    value: group,
                    child: Text(group),
                  ),
                ).toList(),
                onChanged: (val) {
                  setState(() {
                    selectedGroup = val as String?;
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  addDonor();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                ),
                child: const Text('SUBMIT'),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
