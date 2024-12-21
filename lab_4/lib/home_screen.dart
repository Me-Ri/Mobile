import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime current_date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final days_month =
        DateTime(current_date.year, current_date.month + 1, 0).day;
    final first_days_month = DateTime(current_date.year, current_date.month, 1);
    final offset = first_days_month.weekday - 1;
    final total_sell = days_month + offset;
    final month = DateFormat.yMMMM().format(current_date);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 39, 39, 39),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: const Text(
          'Calendar',
          style: TextStyle(color: Color.fromARGB(255, 172, 18, 100)),
        ),
        actions: [
          if (current_date.year != DateTime.now().year ||
              current_date.month != DateTime.now().month)
            IconButton(
              onPressed: () {
                setState(() {
                  current_date = DateTime.now();
                });
              },
              icon: Icon(Icons.redo, color: Color.fromARGB(255, 22, 231, 250)),
            )
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Пн",
                style: TextStyle(color: Color.fromARGB(255, 22, 231, 250)),
              ),
              Text(
                "Вт",
                style: TextStyle(color: Color.fromARGB(255, 22, 231, 250)),
              ),
              Text(
                "Ср",
                style: TextStyle(color: Color.fromARGB(255, 22, 231, 250)),
              ),
              Text(
                "Чт",
                style: TextStyle(color: Color.fromARGB(255, 22, 231, 250)),
              ),
              Text(
                "Пт",
                style: TextStyle(color: Color.fromARGB(255, 22, 231, 250)),
              ),
              Text(
                "Сб",
                style: TextStyle(color: Color.fromARGB(255, 22, 231, 250)),
              ),
              Text(
                "Вс",
                style: TextStyle(color: Color.fromARGB(255, 22, 231, 250)),
              ),
            ],
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
              ),
              itemBuilder: (context, index) {
                if (index < offset) {
                  return Container();
                }
                final day = index - offset + 1;
                return Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: current_date.year == DateTime.now().year &&
                            current_date.month == DateTime.now().month &&
                            day == DateTime.now().day
                        ? const Color.fromARGB(255, 96, 8, 118)
                        : const Color.fromARGB(255, 39, 39, 39),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color.fromARGB(255, 22, 231, 250),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '$day',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 22, 231, 250),
                      ),
                    ),
                  ),
                );
              },
              itemCount: total_sell,
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 0, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Color.fromARGB(255, 22, 231, 250),
                ),
                onPressed: () {
                  setState(() {
                    current_date =
                        DateTime(current_date.year, current_date.month - 1, 1);
                  });
                }),
            Text(
              month,
              style: TextStyle(
                  color: Color.fromARGB(255, 172, 18, 100), fontSize: 20),
            ),
            IconButton(
              icon: const Icon(
                Icons.arrow_forward,
                color: Color.fromARGB(255, 22, 231, 250),
              ),
              onPressed: () {
                setState(() {
                  current_date =
                      DateTime(current_date.year, current_date.month + 1, 1);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
