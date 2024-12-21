import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'base.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final supabase = Supabase.instance.client;
  final myBox = Hive.box('mybox');
  FoodList db = FoodList();
  var response = [];
  var filter_responce = [];
  bool favorite = false;

  TextEditingController search = TextEditingController();

  Future get_data() async {
    var data = await supabase.from('Food').select();
    return data;
  }

  @override
  void initState() {
    db.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Food'),
            SizedBox(
              width: 150,
              height: 30,
              child: TextField(
                controller: search,
                onChanged: (value) {
                  setState(() {
                    RegExp food_search = RegExp(r'^' + search.text, caseSensitive: false);
                    filter_responce = response.where((food) {
                      return food_search.hasMatch(food['name'].toString());
                    }).toList();
                  });
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                favorite = !favorite;
              });
            },
            icon: Icon(
              Icons.star,
              color: favorite ? Colors.red : null,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: get_data(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            response = snapshot.data!;
            if (favorite) {
              response = db.foods;
            }
            if (search.text.isNotEmpty) {
              filter_responce = response.where((food) {
                return RegExp(r'^' + search.text, caseSensitive: false)
                    .hasMatch(food['name'].toString());
              }).toList();
            } else {
              filter_responce = response;
            }

            return ListView.builder(
              itemCount: filter_responce.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 20, top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(filter_responce[index]['name']),
                            Text("Вес: " +
                                filter_responce[index]['weight'].toString() +
                                "г"),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Калл: " + filter_responce[index]['kall'].toString()),
                          Text("Б: " + filter_responce[index]['bel'].toString()),
                          Text("Ж: " + filter_responce[index]['jir'].toString()),
                          Text("У: " + filter_responce[index]['ugl'].toString()),
                          Padding(
                            padding: EdgeInsets.only(left: 50),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  if (!db.ids.contains(filter_responce[index]['id'])) {
                                    db.ids.add(filter_responce[index]['id']);
                                    db.foods.add(filter_responce[index]);
                                    db.update();
                                  } else {
                                    db.ids.remove(filter_responce[index]['id']);
                                    db.foods.removeWhere((food) => food['id'] == filter_responce[index]['id']);
                                    db.update();
                                  }
                                });
                              },
                              icon: Icon(
                                Icons.star,
                                color: db.ids.contains(filter_responce[index]['id'])
                                    ? Colors.green
                                    : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
