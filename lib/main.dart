import 'package:calculator/button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String userQuestion = '';
  late String userAnswer = '';

  final List<String> buttons = [
    'C',
    'Del',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    userQuestion,
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    userAnswer,
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return MyButton(
                      buttontab: () {
                        setState(() {
                          userQuestion = '';
                          userAnswer = '';
                        });
                      },
                      color: Colors.green,
                      textcolor: Colors.white,
                      textbutton: buttons[index],
                    );
                  } else if (index == 1) {
                    return MyButton(
                      buttontab: () {
                        setState(() {
                          userQuestion = userQuestion.substring(
                              0, userQuestion.length - 1);
                        });
                      },
                      color: Colors.red,
                      textcolor: Colors.white,
                      textbutton: buttons[index],
                    );
                  }
                  // equal button
                  else if (index == buttons.length - 1) {
                    return MyButton(
                      buttontab: () {
                        setState(() {
                          equalQressed();
                        });
                      },
                      color: Colors.orange,
                      textcolor: Colors.black,
                      textbutton: buttons[index],
                    );
                  }
                  return MyButton(
                    buttontab: () {
                      setState(() {
                        userQuestion += buttons[index];
                      });
                    },
                    textbutton: buttons[index],
                    color: isOprartor(buttons[index])
                        ? Colors.orange
                        : Colors.black,
                    textcolor: isOprartor(buttons[index])
                        ? Colors.black
                        : Colors.white,
                  );
                }),
          ),
        ],
      ),
    );
  }

  bool isOprartor(String y) {
    if (y == '%' || y == '/' || y == 'x' || y == '-' || y == '+' || y == '=') {
      return true;
    }
    return false;
  }

  void equalQressed() {
    var finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();
  }
}
