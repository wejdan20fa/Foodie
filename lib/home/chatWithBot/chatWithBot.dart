import 'package:foodi/config/api_config.dart';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:foodi/config/config.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatWithBot extends StatefulWidget {
  @override
  _ChatWithBotState createState() => _ChatWithBotState();
}

class _ChatWithBotState extends State<ChatWithBot> {
  List<String> messages = [];
  TextEditingController _search = TextEditingController();
  int currentQuestion = 0;
  bool choicesStatus = false;

  @override
  void initState() {
    super.initState();
    messages.clear();
  }
صضص
  final model = GenerativeModel(
      model: 'gemini-pro', apiKey: ApiConfig.geminiApiKey);

  bool loading = false;

  void resetConversation() {
    setState(() {
      messages.clear();
      currentQuestion = 0;
      choicesStatus = false;
      loading = false; // Ensure loading is reset too
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> allQuestions =
        choicesStatus == true ? _choices() : _questions();
    // _questions == Suggest Luncyh Boxes or Find Alternative Ingerdients

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Foodi.orangeColor,
        title: const Text(
          'Chat With Foodie',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: resetConversation,
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: loading && messages.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Foodi.orangeColor,
                      ),
                    )
                  : ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 2.0,
                          child: ListTile(
                            tileColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue[600],
                              child: ClipOval(
                                child: Image.asset(
                                  "images/logo.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: Text(
                              messages[index],
                              style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: allQuestions,
                  ),
                ),
              ],
            ),
            if (currentQuestion == 1)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        margin: const EdgeInsets.all(5),
                        child: TextFormField(
                          controller: _search,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            hintText: "Write The Ingredients",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Foodi.orangeColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Foodi.orangeColor,
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(10),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: findAlternativeIngredients,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  void findAlternativeIngredients() async {
    if (currentQuestion == 1 && _search.text.isNotEmpty) {
      setState(() {
        loading = true;
      });
      String query = _search.text.trim();
      try {
        final chat = model.startChat();
        final response = await chat.sendMessage(Content.text(
            "Find Alternative Ingredients for: $query only show the Ingredients name"));
        setState(() {
          messages.add(response.text ?? "No response");
          loading = false;
          _search.clear();
        });
      } catch (e) {
        print('Error fetching data: $e');
        setState(() {
          loading = false;
        });
      }
    }
  }

  List<Widget> _questions() {
    return showingOptions(
      options: [
        Option("Find Alternative Ingredients", () => changeQuestion(1)),
        Option("Suggest Lunch Boxes", () => changeQuestion(2)),
      ],
    );
  }

  List<Widget> _choices() {
    return showingOptions(
      options: [
        Option(
            "Suggest Kids Lunch Box", () => findingLunchBox("Kids Lunch Box")),
        Option("Suggest Healthy Lunch Box",
            () => findingLunchBox("Healthy Lunch Box")),
        Option("Suggest Regular Lunch Box",
            () => findingLunchBox("Regular Lunch Box")),
      ],
    );
  }

  void changeQuestion(int newQuestion) {
    setState(() {
      currentQuestion = newQuestion;
      choicesStatus =
          newQuestion == 2; // Set choicesStatus to true when newQuestion is 2
      loading = true;
    });
  }

  void findingLunchBox(String lunchBoxType) async {
    setState(() {
      loading = true;
      messages.clear();
    });
    try {
      final chat = model.startChat();
      final response = await chat.sendMessage(Content.text(
          "Suggest ${lunchBoxType} show me 4 recipes with ingredients, tips, time to make, and name"));
      setState(() {
        List<String> fullList = [lunchBoxType, response.text!];
        messages.addAll(fullList);
        Clipboard.setData(ClipboardData(text: fullList.toString()));
        loading = false; // Ensure loading is reset correctly
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        loading = false; // Ensure loading is reset correctly
      });
    }
  }

  List<Widget> showingOptions({required List<Option> options}) {
    return [
      Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        children: options
            .map((option) => GestureDetector(
                  onTap: option.callback,
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                    height: 60,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Foodi.orangeColor,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        option.label,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    ];
  }
}

class Option {
  final String label;
  final VoidCallback callback;

  Option(this.label, this.callback);
}
