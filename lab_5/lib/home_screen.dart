import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String api = "8734b26d2672453894091134241212";
  String city = "Ханты-Мансийск";

  Future<Map<String, dynamic>> get_data() async {
    var url = Uri.parse(
        "http://api.weatherapi.com/v1/forecast.json?key=$api&q=$city&days=14");
    var res = await http.get(url);
    return jsonDecode(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 39, 39, 39),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          title: const Text(
            'Weather',
            style: TextStyle(color: Color.fromARGB(255, 172, 18, 100)),
          ),
          actions: [
            DropdownMenu(
              inputDecorationTheme: const InputDecorationTheme(border: null),
              initialSelection: 0,
              textStyle: TextStyle(color: Color.fromARGB(255, 22, 231, 250)),
              onSelected: (value) {
                setState(() {
                  city = value.toString();
                });
              },
              dropdownMenuEntries: const [
                DropdownMenuEntry(
                  value: 'Ханты-Мансийск',
                  label: 'Ханты-Мансийск',
                ),
                DropdownMenuEntry(
                  value: 'Нижневартовск',
                  label: 'Нижневартовск',
                ),
                DropdownMenuEntry(
                  value: 'Сургут',
                  label: 'Сургут',
                ),
                DropdownMenuEntry(
                  value: 'Тюмень',
                  label: 'Тюмень',
                ),
                DropdownMenuEntry(
                  value: 'Нягань',
                  label: 'Нягань',
                ),
              ],
            ),
          ],
        ),
        body: FutureBuilder(
            future: get_data(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var response = snapshot.data!;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Сегодня",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 172, 18, 100),
                                  fontSize: 25)),
                          Image.network(
                              'https:' +
                                  response['current']['condition']['icon'],
                              height: 100,
                              scale: 0.7),
                          Text(response['current']['temp_c'].toString() + "°C",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 172, 18, 100),
                                  fontSize: 25)),
                        ],
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 7,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: Column(
                              children: [
                                Text(
                                  response['forecast']['forecastday'][index]
                                          ['date']
                                      .toString(),
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 172, 18, 100)),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "День",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 172, 18, 100)),
                                        ),
                                        Image.network(
                                          'https:' +
                                              response['forecast']
                                                          ['forecastday'][index]
                                                      ['hour'][9]['condition']
                                                  ['icon'],
                                        ),
                                        Text(
                                          response['forecast']['forecastday']
                                                          [index]['hour'][9]
                                                      ['temp_c']
                                                  .toString() +
                                              "°C",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 172, 18, 100)),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Ночь",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 172, 18, 100)),
                                        ),
                                        Image.network(
                                          'https:' +
                                              response['forecast']
                                                          ['forecastday'][index]
                                                      ['hour'][23]['condition']
                                                  ['icon'],
                                        ),
                                        Text(
                                          response['forecast']['forecastday']
                                                          [index]['hour'][23]
                                                      ['temp_c']
                                                  .toString() +
                                              "°C",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 172, 18, 100)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
