import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodi/config/config.dart';
import 'package:foodi/home/Complaints/addComplaints.dart'; // Ensure this package provides the correct styling parameters

class ViewingAllComplaints extends StatefulWidget {
  const ViewingAllComplaints({Key? key}) : super(key: key);

  @override
  _ViewingAllComplaintsState createState() => _ViewingAllComplaintsState();
}

class _ViewingAllComplaintsState extends State<ViewingAllComplaints> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Complaints',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Foodi
            .orangeColor, // Assuming Foodi.orangeColor is defined in your config
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('complaints').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            return ListView.builder(
              itemCount: snapshot.data?.docs.length ?? 0,
              itemBuilder: (context, index) {
                var complaintDoc =
                    snapshot.data?.docs[index].data() as Map<String, dynamic>;
                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Title: ${complaintDoc['complaintTitle'] ?? 'N/A'}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Description: ${complaintDoc['complaintDescription'] ?? 'N/A'}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Status: ${complaintDoc['status'] ?? 'Pending'}",
                        style: TextStyle(
                          fontSize: 16,
                          color: complaintDoc['status'] == 'Pending'
                              ? Colors.orange
                              : Colors.green,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Date: ${complaintDoc['date'].toDate().toString() ?? 'N/A'}", // Make sure 'date' is a Timestamp
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
