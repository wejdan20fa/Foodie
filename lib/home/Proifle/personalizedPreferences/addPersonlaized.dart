// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:foodi/DialogBox/loadingDialog.dart';
// import 'package:foodi/config/config.dart';

// class AddPersonalizedChoicesPage extends StatefulWidget {
//   const AddPersonalizedChoicesPage({Key? key}) : super(key: key);

//   @override
//   _AddPersonalizedChoicesPageState createState() =>
//       _AddPersonalizedChoicesPageState();
// }

// class _AddPersonalizedChoicesPageState
//     extends State<AddPersonalizedChoicesPage> {
//   final List<String> _foodOptions = [
//     "Italian",
//     "American",
//     "Japanese",
//     "Chinese",
//     "Mediterranean",
//     "Indian",
//     "Mexican"
//   ];

//   String?
//       _selectedOption; // Changed from a map to a single string to hold only one choice
//   bool _isLoading = true; // Indicates if the page is loading data

//   @override
//   void initState() {
//     super.initState();
//     _fetchPreferences();
//   }

//   Future<void> _fetchPreferences() async {
//     String? userId = FirebaseAuth.instance.currentUser?.uid;
//     if (userId != null) {
//       try {
//         var doc = await FirebaseFirestore.instance
//             .collection("users")
//             .doc(userId)
//             .get();
//         var data = doc.data();
//         _selectedOption = data?['personalized']
//             as String?; // Assumes stored as a single string
//       } catch (e) {
//         print("Error fetching user preferences: $e");
//       }
//     }
//     setState(() {
//       _isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Personalized Choices'),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: _isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : ListView.builder(
//                 itemCount: _foodOptions.length,
//                 itemBuilder: (context, index) {
//                   return RadioListTile<String>(
//                     title: Text(_foodOptions[index]),
//                     value: _foodOptions[index],
//                     groupValue: _selectedOption,
//                     onChanged: (String? value) {
//                       setState(() {
//                         _selectedOption = value;
//                       });
//                     },
//                   );
//                 },
//               ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _submitChoices,
//         backgroundColor: Foodi.orangeColor,
//         child: const Icon(
//           Icons.save,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }

//   void _submitChoices() async {
//     showDialog(
//       context: context,
//       builder: (c) => const LoadingAlertDialog(message: "Adding Data"),
//     );
//     String? currentUser = FirebaseAuth.instance.currentUser?.uid;
//     if (currentUser != null && _selectedOption != null) {
//       await FirebaseFirestore.instance
//           .collection("users")
//           .doc(currentUser)
//           .update({
//         "personalized":
//             _selectedOption, // Update with the single selected option
//       }).then((value) {
//         Foodi.sharedPreferences?.setString("personalized", _selectedOption!);
//         Navigator.pop(context);
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text("Preferences Updated Successfully!"),
//           ),
//         );
//       });
//     }
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodi/DialogBox/loadingDialog.dart';
import 'package:foodi/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPersonalizedChoicesPage extends StatefulWidget {
  const AddPersonalizedChoicesPage({Key? key}) : super(key: key);

  @override
  _AddPersonalizedChoicesPageState createState() =>
      _AddPersonalizedChoicesPageState();
}

class _AddPersonalizedChoicesPageState
    extends State<AddPersonalizedChoicesPage> {
  final List<String> _foodOptions = [
    "Italian",
    "American",
    "Japanese",
    "Chinese",
    "Mediterranean",
    "Indian",
    "Mexican"
  ];

  final List<String> _allergiesOptions = [
    "Garlic",
    "Onions",
    "Peanuts",
    "Dairy",
    "Gluten",
    "Shellfish",
  ];

  final List<String> _diseasesOptions = [
    "Diabetes",
    "Hypertension",
    "Anemia",
    "Heart Disease",
  ];

  String? _selectedOption; // Holds the selected food option
  List<String> _selectedAllergies = []; // Holds the selected allergies
  List<String> _selectedDiseases = []; // Holds the selected diseases
  bool _isLoading = true; // Indicates if the page is loading data

  @override
  void initState() {
    super.initState();
    _fetchPreferences();
  }

  Future<void> _fetchPreferences() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      try {
        var doc = await FirebaseFirestore.instance
            .collection("users")
            .doc(userId)
            .get();
        var data = doc.data();
        _selectedOption = data?['personalized'] as String?;
        _selectedAllergies = List<String>.from(data?['allergies'] ?? []);
        _selectedDiseases = List<String>.from(data?['diseases'] ?? []);
      } catch (e) {
        print("Error fetching user preferences: $e");
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Personalized Choices'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  const ListTile(
                    title: Text('Select Preferred Food Option'),
                  ),
                  ..._foodOptions.map((option) {
                    return RadioListTile<String>(
                      title: Text(option),
                      value: option,
                      groupValue: _selectedOption,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedOption = value;
                        });
                      },
                    );
                  }).toList(),
                  const Divider(),
                  const ListTile(
                    title: Text('Select Allergies'),
                  ),
                  ..._allergiesOptions.map((allergy) {
                    return CheckboxListTile(
                      title: Text(allergy),
                      value: _selectedAllergies.contains(allergy),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            _selectedAllergies.add(allergy);
                          } else {
                            _selectedAllergies.remove(allergy);
                          }
                        });
                      },
                    );
                  }).toList(),
                  const Divider(),
                  const ListTile(
                    title: Text('Select Diseases'),
                  ),
                  ..._diseasesOptions.map((disease) {
                    return CheckboxListTile(
                      title: Text(disease),
                      value: _selectedDiseases.contains(disease),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            _selectedDiseases.add(disease);
                          } else {
                            _selectedDiseases.remove(disease);
                          }
                        });
                      },
                    );
                  }).toList(),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitChoices,
        backgroundColor: Foodi.orangeColor,
        child: const Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
    );
  }

  void _submitChoices() async {
    showDialog(
      context: context,
      builder: (c) => const LoadingAlertDialog(message: "Adding Data"),
    );
    String? currentUser = FirebaseAuth.instance.currentUser?.uid;
    if (currentUser != null && _selectedOption != null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser)
          .update({
        "personalized": _selectedOption,
        "allergies": _selectedAllergies,
        "diseases": _selectedDiseases,
      }).then((value) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("personalized", _selectedOption!);
        prefs.setStringList("allergies", _selectedAllergies);
        prefs.setStringList("diseases", _selectedDiseases);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Preferences Updated Successfully!"),
          ),
        );
      });
    }
  }
}
