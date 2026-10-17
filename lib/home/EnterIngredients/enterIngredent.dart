import 'package:foodi/config/api_config.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodi/home/EnterIngredients/ShowingRecipes/showingAllRecipies.dart';
import 'package:foodi/home/Proifle/ProfilePage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:foodi/config/config.dart'; // Assuming this provides style constants

class EnterIngredients extends StatefulWidget {
  const EnterIngredients({super.key});

  @override
  State<EnterIngredients> createState() => _EnterIngredientsState();
}

class _EnterIngredientsState extends State<EnterIngredients> {
  final TextEditingController _search = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _image;
  String _generatedContent = '';
  List<String> IngredientsInput = [];
  List<XFile> ImagesList = [];

  void pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
      generateContent(image);
    }
  }

  Future<void> generateContent(XFile image) async {
    final bytes = await File(image.path).readAsBytes();
    String base64Image = base64Encode(bytes);

    final uri = Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-pro-latest:generateContent?key=${ApiConfig.geminiApiKey}');
    final requestHeaders = {'Content-Type': 'application/json'};
    final requestBody = jsonEncode({
      "contents": [
        {
          "parts": [
            {"text": "what ingredients in the picture:\n"},
            {
              "inlineData": {"mimeType": "image/jpeg", "data": base64Image}
            },
            {
              "text":
                  "system_instruction = \"\\n\\nfollow these:\\n1. everything will be uploaded is food ingredients.\\n2. detect the food ingredients.\\n3. just write the name of the food ingredients. nothing else.\\n4. example: onion.\\n\\n\""
            }
          ]
        }
      ],
      "generationConfig": {
        "temperature": 0.4,
        "topK": 32,
        "topP": 1,
        "maxOutputTokens": 4096,
        "stopSequences": []
      }
    });

    try {
      final response =
          await http.post(uri, headers: requestHeaders, body: requestBody);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(
            jsonEncode(responseData)); // Print the full JSON response to debug

        final candidates = responseData['candidates'] as List;
        if (candidates.isNotEmpty) {
          final content = candidates[0]['content'];
          final parts = content['parts'] as List;
          if (parts.isNotEmpty) {
            final text = parts[0]['text'] as String;
            print("this is the text ${text}");
            setState(() {
              IngredientsInput.add(text);
            });
          } else {
            setState(() {
              _generatedContent = 'No parts available in data';
            });
          }
        } else {
          setState(() {
            _generatedContent = 'No candidates available in data';
          });
        }
      } else {
        setState(() {
          _generatedContent =
              'Error: Status ${response.statusCode} - ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      setState(() {
        _generatedContent =
            'Failed to generate content due to an exception: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              color: Foodi.greenColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.arrow_back,
                                        size: 35, color: Colors.black),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Route route = MaterialPageRoute(
                                          builder: (_) => ProfilePage());
                                      Navigator.push(context, route);
                                    },
                                    icon: const Icon(Icons.person,
                                        size: 35, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  margin: const EdgeInsets.all(5),
                                  child: TextField(
                                    textAlign: TextAlign.start,
                                    controller: _search,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      hintText: "Type Recipe Name",
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide: const BorderSide(
                                            color: Colors.orange, width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide: const BorderSide(
                                            color: Colors.orange, width: 2),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      suffixIcon: IconButton(
                                        icon: const Icon(Icons.send),
                                        onPressed: () {
                                          IngredientsInput.add(_search.text);

                                          setState(() {
                                            _search.clear();
                                          });
                                        },
                                      ),
                                    ),
                                    onChanged: (text) {
                                      print(text);
                                    },
                                  ),
                                ),
                                IconButton(
                                  onPressed: pickImage,
                                  icon: const Icon(Icons.photo),
                                )
                              ],
                            ),
                            // if (_image != null) Image.file(_image!),
                            // if (_generatedContent.isNotEmpty)
                            //   Text('Response: $_generatedContent'),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: IngredientsInput.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                  color: Foodi.greenColor.withAlpha(60),
                                  borderRadius: BorderRadius.circular(10)),
                              margin: const EdgeInsets.all(7),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(IngredientsInput[index]),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // const Text("Change"),
                                        IconButton(
                                          onPressed: () {
                                            IngredientsInput.removeAt(index);
                                            setState(() {});
                                          },
                                          icon: const Icon(Icons.delete),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Route route = MaterialPageRoute(
                              builder: (_) => showingAllRecipies(
                                IngredientsInput: IngredientsInput,
                              ),
                            );
                            Navigator.push(context, route);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Foodi.orangeColor, // تعيين لون خلفية الزر
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(5.0), // تقريب الزوايا
                              ),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 8), // تعيين البادئة للنص داخل الزر
                            child: Text(
                              "Show Recipes", // نص الزر
                              style: TextStyle(
                                color: Colors.white, // لون النص
                                fontSize: 20, // حجم الخط
                                fontWeight: FontWeight.bold, // ثقل الخط
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
