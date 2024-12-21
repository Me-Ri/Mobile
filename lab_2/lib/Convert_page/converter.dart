import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Converter extends StatefulWidget {
  const Converter({super.key});

  @override
  State<Converter> createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  Map<String, dynamic> info = {};
  List measurements = [];
  List coef = [];
  String selected = '';
  String number = '0';
  bool is_loading = true;

  String conversion(String type, String value, String selected) {
    if (selected == measurements[0]) {
      if (type == measurements[1]) {
        return (int.parse(value) * coef[1]).toStringAsFixed(5);
      }
      return type != measurements[0]
          ? (int.parse(value) * coef[2]).toStringAsFixed(5)
          : value;
    } else if (selected == measurements[1]) {
      if (type == measurements[0]) {
        return (int.parse(value) / coef[1]).toStringAsFixed(5);
      }
      return type != measurements[1]
          ? (int.parse(value) / coef[1] * coef[2]).toStringAsFixed(5)
          : value;
    } else if (selected == measurements[2]) {
      if (type == measurements[1]) {
        return (int.parse(value) / coef[2] * coef[1]).toStringAsFixed(5);
      }
      return type != measurements[2]
          ? (int.parse(value) / coef[2]).toStringAsFixed(5)
          : value;
    }
    return '';
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        final args =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
        info = args['list']!;
        measurements = info['types'];
        coef = info['coef'];
        selected = info['types'][0];
        is_loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (is_loading) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 39, 39, 39),
        body: Center(
            child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 39, 39, 39),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: Text(info['name'].toString(),
            style: TextStyle(color: Color.fromARGB(255, 172, 18, 100))),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                      width: 280,
                      child: TextField(
                        style:
                            TextStyle(color: Color.fromARGB(255, 22, 231, 250)),
                        inputFormatters: [
                          FilteringTextInputFormatter(RegExp(r'\d+.?\d*'),
                              allow: true)
                        ],
                        onChanged: (value) => {
                          setState(() {
                            number = value;
                          })
                        },
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                      )),
                ),
                SizedBox(
                  width: 90,
                  child: DropdownMenu(
                    onSelected: (value) => {
                      setState(() {
                        selected = value;
                      })
                    },
                    dropdownMenuEntries: measurements
                        .map((item) => DropdownMenuEntry(
                              value: item,
                              label: item,
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
            Card(
              color: const Color.fromARGB(255, 96, 8, 118),
              child: SizedBox(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(conversion(measurements[0], number, selected),
                          style: TextStyle(
                              color: Color.fromARGB(255, 22, 231, 250),
                              fontSize: 24)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(measurements[0],
                          style: TextStyle(
                              color: Color.fromARGB(255, 22, 231, 250),
                              fontSize: 24)),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              color: const Color.fromARGB(255, 96, 8, 118),
              child: SizedBox(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(conversion(measurements[1], number, selected),
                          style: TextStyle(
                              color: Color.fromARGB(255, 22, 231, 250),
                              fontSize: 24)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(measurements[1],
                          style: TextStyle(
                              color: Color.fromARGB(255, 22, 231, 250),
                              fontSize: 24)),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              color: const Color.fromARGB(255, 96, 8, 118),
              child: SizedBox(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(conversion(measurements[2], number, selected),
                          style: TextStyle(
                              color: Color.fromARGB(255, 22, 231, 250),
                              fontSize: 24)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(measurements[2],
                          style: TextStyle(
                              color: Color.fromARGB(255, 22, 231, 250),
                              fontSize: 24)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
