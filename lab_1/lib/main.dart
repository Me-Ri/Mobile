import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String answer = '';
  List mas_number = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  List mas_sing = ['/', '*', '-', '+', '^'];

  void Calculator_Button(String text) {
    setState(() {
      if (text == "C") {
        answer = '';
      } else if (text == "Del") {
        if (answer == '') {
          return;
        }
        answer = answer.substring(0, answer.length - 1);
      } else if (text == "=") {
        if (answer == '') {
          return;
        }
        Parser p = Parser();
        Expression expression = p.parse(answer);
        ContextModel cm = ContextModel();
        double eval = expression.evaluate(EvaluationType.REAL, cm);
        String temp = eval.toString();
        if (temp[temp.length - 1] == '0' && temp[temp.length - 2] == '.') {
          temp = temp.substring(0, temp.length - 2);
        }
        answer = temp;
      } else {
        if (mas_number.contains(text)) {
          answer += text;
        } else if (mas_sing.contains(text)) {
          if (answer == '') {
            return;
          } else if (mas_number.contains(answer[answer.length - 1])) {
            answer += text;
          } else if (mas_sing.contains(answer[answer.length - 1])) {
            answer = answer.substring(0, answer.length - 1) + text;
          }
        } else if (text == '.') {
          if (mas_sing.contains(answer[answer.length - 1])) {
            return;
          }
          for (int i = answer.length - 1; i >= 0; i--)
            if (mas_sing.contains(answer[i]) || i == 0) {
              answer += text;
              break;
            } else if (answer[i] == '.') {
              break;
            }
        }
      }
    });
  }

  Widget Button(String text, Color color) {
    return Expanded(
      flex: ['0'].contains(text) ? 2 : 1,
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
              onPressed: () {
                Calculator_Button(text);
              },
              child: Text(text,
                  style: TextStyle(color: Colors.blue, fontSize: 20)),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('CALCULATOR',
            style: TextStyle(color: Color.fromARGB(255, 172, 18, 100))),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  answer,
                  style: TextStyle(color: Colors.white, fontSize: 30),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Button('C', Color.fromARGB(255, 110, 11, 64)),
                Button('/', Color.fromARGB(255, 110, 11, 64)),
                Button('*', Color.fromARGB(255, 110, 11, 64)),
                Button('Del', Color.fromARGB(255, 110, 11, 64)),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Button('7', Color.fromARGB(255, 172, 18, 100)),
                Button('8', Color.fromARGB(255, 172, 18, 100)),
                Button('9', Color.fromARGB(255, 172, 18, 100)),
                Button('-', Color.fromARGB(255, 110, 11, 64)),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Button('4', Color.fromARGB(255, 172, 18, 100)),
                Button('5', Color.fromARGB(255, 172, 18, 100)),
                Button('6', Color.fromARGB(255, 172, 18, 100)),
                Button('+', Color.fromARGB(255, 110, 11, 64)),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Button('1', Color.fromARGB(255, 172, 18, 100)),
                Button('2', Color.fromARGB(255, 172, 18, 100)),
                Button('3', Color.fromARGB(255, 172, 18, 100)),
                Button('^', Color.fromARGB(255, 110, 11, 64)),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Button('0', Color.fromARGB(255, 172, 18, 100)),
                Button('.', Color.fromARGB(255, 172, 18, 100)),
                Button('=', Color.fromARGB(255, 110, 11, 64)),
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
