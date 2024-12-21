import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Calculator();
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  Map<String, Map<String, dynamic>> values = {
  '/weight': {
    'name': 'WEIGHT',
    'types': ['g', 'kg', 't'],
    'coef': [1, 0.001, 0.000001]
  },
  '/volume': {
    'name': 'VOLUME',
    'types': ['l', 'ml', 'm³'],
    'coef': [1, 1000, 0.001]
  },
  '/distance': {
    'name': 'DISTANCE',
    'types': ['m', 'km', 'cm'],
    'coef': [1, 0.001, 100]
  },
  '/currency': {
    'name': 'CURRENCY',
    'types': ['USD', 'EUR', 'RUB'],
    'coef': [1, 1.1, 90]
  },
  '/square': {
    'name': 'SQUARE',
    'types': ['m²', 'km²', 'cm²'],
    'coef': [1, 0.000001, 10000]
  },
};

  Widget Button(String text, String redirect, Color color) {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            height: 80,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              onPressed: () => {
                Navigator.pushNamed(context, redirect,
                    arguments: <String, dynamic>{'list': values[redirect]})
              },
              child: Text(text,
                  style: TextStyle(
                      color: const Color.fromARGB(255, 22, 231, 250),
                      fontSize: 20)),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 39, 39, 39),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('CONVERTER',
            style: TextStyle(color: Color.fromARGB(255, 172, 18, 100))),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Button('Обьем', '/volume',
                    Color.fromARGB(255, 96, 8, 118)),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Button('Расстояние', '/distance',
                    Color.fromARGB(255, 96, 8, 118)),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Button('Вес', '/weight', Color.fromARGB(255, 96, 8, 118)),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Button(
                    'Валюта', '/currency', Color.fromARGB(255, 96, 8, 118)),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Button('Площадь', '/square',
                    Color.fromARGB(255, 96, 8, 118)),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
