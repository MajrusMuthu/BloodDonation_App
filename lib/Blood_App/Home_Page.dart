// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:bloodapp/Blood_App/Input_Page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final CollectionReference donor =
      FirebaseFirestore.instance.collection("donor");
  void deleteDonor(docId) {
    donor.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Blood Donation App",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const InputPage()),
          );
        },
        backgroundColor: Colors.red,
        child: const Icon(
          Icons.add_rounded,
          size: 30,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder(
        stream: donor.orderBy('name').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final DocumentSnapshot donorSnap = snapshot.data!.docs[index];

                final Map<String, dynamic>? data =
                    donorSnap.data() as Map<String, dynamic>?;

                if (data != null && data.containsKey('group')) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 234, 232, 232),
                            blurRadius: 5,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 25,
                                child: Text(
                                  data['group'] ?? '',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  data['name'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  data['phone'].toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/Update',
                                        arguments: {
                                          'name': donorSnap['name'],
                                          'phone':
                                              donorSnap['phone'].toString(),
                                          'group': donorSnap['group'],
                                          'id': donorSnap.id
                                        });
                                  },
                                  icon: Icon(Icons.edit),
                                  iconSize: 30,
                                  color: Colors.green,
                                ),
                                IconButton(
                                  onPressed: () {
                                    deleteDonor(donorSnap.id);
                                  },
                                  icon: Icon(Icons.delete_forever_rounded),
                                  iconSize: 30,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container(
                    child: Text(
                      'Group field does not exist',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
