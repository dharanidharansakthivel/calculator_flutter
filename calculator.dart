import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userInput = "";
  String result = "0";

  void _handleButtonPress(String label) {
    setState(() {
      if (label == "=") {
        // Perform calculation and update result
        result = _calculate();
      } else if (label == "C") {
        // Clear user input and result
        userInput = "";
        result = "0";
      } else {
        // Update user input
        userInput += label;
      }
    });
  }

  String _calculate() {
    try {
      // Evaluate the user input as a math expression
      Parser p = Parser();
      Expression exp = p.parse(userInput);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      return eval.toString();
    } catch (e) {
      return "Error";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Flexible(child: resultWidget(), flex: 1),
            Flexible(child: buttonWidget(), flex: 2),
          ],
        ),
      ),
    );
  }

  Widget resultWidget() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.centerRight,
          child: Text(
            userInput,
            style: const TextStyle(fontSize: 32),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.centerRight,
          child: Text(
            result,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget calculatorButton(String label) {
    return ElevatedButton(
      onPressed: () {
        _handleButtonPress(label);
      },
      child: Text(label),
    );
  }

  Widget buttonWidget() {
    List<List<String>> buttonLabels = [
      ["7", "8", "9", "/"],
      ["4", "5", "6", "*"],
      ["1", "2", "3", "-"],
      ["C", "0", "=", "+"],
    ];

    return GridView.builder(
      itemCount: buttonLabels.length * buttonLabels[0].length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      itemBuilder: (BuildContext context, int index) {
        int row = index ~/ 4;
        int col = index % 4;
        String label = buttonLabels[row][col];
        return calculatorButton(label);
      },
    );
  }
}

void main() {
  runApp(MaterialApp(home: Calculator()));
}
