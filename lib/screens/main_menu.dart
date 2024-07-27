import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'paint_screen.dart';
import 'color_screen.dart';
import 'learn_screen.dart';
import 'dart:async';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool shouldPop = await _showMathDialog(context);
        return shouldPop;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _showMathDialog(context);
            },
          ),
          title: Text('Main Menu'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PaintScreen()),
                    );
                  },
                  child: Text("Let's Paint"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ColorScreen()),
                    );
                  },
                  child: Text("Let's Color"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LearnScreen()),
                    );
                  },
                  child: Text("Let's Learn"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _showMathDialog(BuildContext context) async {
    final TextEditingController _controller = TextEditingController();
    final mathProblem = _generateMathProblem();
    final Completer<bool> completer = Completer<bool>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Solve the Math Problem to Exit'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('What is ${mathProblem['question']}?'),
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Enter your answer'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_controller.text == mathProblem['answer'].toString()) {
                  completer.complete(true);
                  Navigator.of(context).pop();
                  SystemNavigator.pop(); // Close the app
                } else {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Wrong answer. Try again.'),
                    ),
                  );
                  completer.complete(false);
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );

    return completer.future;
  }

  Map<String, dynamic> _generateMathProblem() {
    final Random random = Random();
    final int num1 = random.nextInt(10) + 1;
    final int num2 = random.nextInt(10) + 1;
    final int answer = num1 * num2;
    final String question = '$num1 * $num2';

    return {'question': question, 'answer': answer};
  }
}
