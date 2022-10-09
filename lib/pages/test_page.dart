import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Test Page"),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          color: Colors.red,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text("data",textAlign: TextAlign.right),
                Text("data",textAlign: TextAlign.center),
            ],),
          ),
        ),
      ),
    );
  }
}



