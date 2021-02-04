import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(title: 'Flutter Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String outputValue = "0";
  String memoryScreen = "";
  String secondOutput = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String currentOperand = "";
  String value1 = "";
  String value2 = "";
  String combined = "";
  String operand = "";
  buttonPressed(String buttonOutputTex) {
    if (buttonOutputTex == "Clear") {
      outputValue = "0";
      secondOutput = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
      memoryScreen = "";
    } else if (buttonOutputTex == "-" ||
        buttonOutputTex == "X" ||
        buttonOutputTex == "+" ||
        buttonOutputTex == "/") {
      num1 = double.parse(outputValue);

      operand = buttonOutputTex;
      currentOperand = buttonOutputTex;
      value1 = outputValue;

      secondOutput = "0";
    } else if (buttonOutputTex == ".") {
      if (secondOutput.contains(".")) {
        print("Already contains decimals");
        return;
      } else {
        secondOutput = secondOutput + buttonOutputTex;
      }
    } else if (buttonOutputTex == "=") {
      num2 = double.parse(outputValue);
      value2 = outputValue;

      if (operand == "+") {
        secondOutput = (num1 + num2).toString();
      }
      if (operand == "-") {
        secondOutput = (num1 - num2).toString();
      }
      if (operand == "/") {
        secondOutput = (num1 / num2).toString();
      }
      if (operand == "X") {
        secondOutput = (num1 * num2).toString();
      }
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else {
      secondOutput = secondOutput + buttonOutputTex;
    }
    combined = value1 + currentOperand + value2;
    print(secondOutput);
    setState(() {
      outputValue = double.parse(secondOutput).toStringAsFixed(2);
      memoryScreen = combined;
    });
  }

  Widget buildButton(String buttonText) {
    return new Expanded(
      // ignore: deprecated_member_use
      child: new OutlineButton(
        child: new Text(
          buttonText,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        padding: EdgeInsets.all(24.0),
        onPressed: () => {buttonPressed(buttonText)},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: new Container(
          child: new Column(
            children: <Widget>[
              new Container(
                alignment: Alignment.centerRight,
                padding:
                    new EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
                child: new Text(
                  outputValue,
                  style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
                ),
              ),
              new Container(
                alignment: Alignment.centerRight,
                padding:
                    new EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
                child: new Text(
                  memoryScreen,
                  style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
                ),
              ),
              new Expanded(child: Divider()),
              new Column(
                children: [
                  new Row(
                    children: [
                      buildButton('7'),
                      buildButton('8'),
                      buildButton('9'),
                      buildButton('/')
                    ],
                  ),
                  new Row(
                    children: [
                      buildButton('4'),
                      buildButton('5'),
                      buildButton('6'),
                      buildButton('X')
                    ],
                  ),
                  new Row(
                    children: [
                      buildButton('1'),
                      buildButton('2'),
                      buildButton('3'),
                      buildButton('-')
                    ],
                  ),
                  new Row(
                    children: [
                      buildButton('0'),
                      buildButton('00'),
                      buildButton('.'),
                      buildButton('+')
                    ],
                  ),
                  new Row(
                    children: [
                      buildButton('Clear'),
                      buildButton('='),
                    ],
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
