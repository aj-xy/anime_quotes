import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  var responseData;

  Future<void> fetchData() async {
    final url = Uri.parse('https://animechan.xyz/api/random');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      setState(() {
        responseData = data;
      });
    } else {
      print('error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          height: 2000,
          width: 2000,
          color: Color.fromRGBO(168, 218, 220, 1),
          child: Center(
            child: ListView(
              children: [
                Lottie.network(
                    'https://lottie.host/9a539595-bd80-4a1d-8063-188941ccc3f0/d7jxh7KiHX.json'),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Color.fromRGBO(69, 123, 157, 1)),
                  child: Column(
                    children: [
                      Text(
                        "Quote:",
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1), fontSize: 20),
                      ),
                      responseData == null
                          ? CircularProgressIndicator()
                          : Text(
                              responseData['quote'],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Color.fromRGBO(69, 123, 157, 1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Character:",
                        style: TextStyle(
                            color: const Color.fromRGBO(241, 250, 238, 1),
                            fontSize: 15),
                      ),
                      Text(
                        responseData['character'],
                        style: TextStyle(
                            color: const Color.fromRGBO(241, 250, 238, 1),
                            fontSize: 15),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: const Color.fromRGBO(69, 123, 157, 1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Anime:",
                        style: TextStyle(
                            color: const Color.fromRGBO(241, 250, 238, 1),
                            fontSize: 15),
                      ),
                      Text(
                        responseData['anime'],
                        style: TextStyle(
                            color: const Color.fromRGBO(241, 250, 238, 1),
                            fontSize: 15),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () {
                      fetchData();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(29, 53, 87, 1)),
                    child: Text(
                      "press",
                      style: TextStyle(
                          color: const Color.fromRGBO(241, 250, 238, 1)),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
