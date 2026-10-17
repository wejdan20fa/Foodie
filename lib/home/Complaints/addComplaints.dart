import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodi/DialogBox/loadingDialog.dart';
import 'package:foodi/config/config.dart';

class AddComplaintsPage extends StatefulWidget {
  const AddComplaintsPage({Key? key}) : super(key: key);

  @override
  _AddComplaintsPageState createState() => _AddComplaintsPageState();
}

class _AddComplaintsPageState extends State<AddComplaintsPage> {
  final TextEditingController _complaintTitle = TextEditingController();
  final TextEditingController _complaintDescription = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Complaints'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.all(15),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Foodi.greenColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "Complaint Details",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                margin: const EdgeInsets.all(5),
                                child: TextFormField(
                                  controller: _complaintTitle,
                                  decoration: InputDecoration(
                                    hintText: "Complaint Title",
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Foodi.orangeColor,
                                      ),
                                    ),
                                    isCollapsed: false,
                                    isDense: true,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Foodi.orangeColor,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.all(10),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Complaint Title';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                margin: const EdgeInsets.all(5),
                                child: TextFormField(
                                  controller: _complaintDescription,
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    hintText: "Complaint Description",
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Foodi.orangeColor,
                                      ),
                                    ),
                                    isCollapsed: false,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.all(20),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Foodi.orangeColor,
                                      ),
                                    ),
                                  ),
                                  maxLines: 5,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Put Complaint Description';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(5),
                                    width: MediaQuery.of(context).size.width,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          ValidatingData();
                                        }
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          Foodi.orangeColor,
                                        ),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                        ),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 40, vertical: 8),
                                        child: Text(
                                          "Add Complaints",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ValidatingData() async {
    showDialog(
        context: context,
        builder: (c) {
          return const LoadingAlertDialog(
            message: "Validating Data",
          );
        });
    addingComplaint();
  }

  void addingComplaint() async {
    String? currentUser = FirebaseAuth.instance.currentUser?.uid;
    await FirebaseFirestore.instance.collection("complaints").add({
      'complaintTitle': _complaintTitle.text.trim(),
      'complaintDescription': _complaintDescription.text.trim(),
      "date": DateTime.now(),
      "status": "Pending",
      "uploaded": currentUser,
    }).then((value) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Complaint was added"),
        ),
      );
      setState(() {
        _complaintTitle.clear();
        _complaintDescription.clear();
      });
    });
  }
}
