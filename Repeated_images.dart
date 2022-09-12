//row and columns and input text field with types

import 'package:flutter/material.dart'; //importing packages in flutter

void main() {
  runApp(const MyApp()); //for run a code here class MyApp for run
}

//shortcut for stateless is stl
class MyApp extends StatelessWidget {
  //stateless widget class
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyScreen(); //return to statefullwidget of MyScreen class
  }
}

//shortcut for stateless is stf
class MyScreen extends StatefulWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:
          'Digvijay', //app name shown from package name and for main title this is.
      theme: ThemeData(primarySwatch: Colors.yellow), //theme of app
      home: Scaffold(
        //scaffold
        appBar: AppBar(
          //appbar for show scaffold title
          title: const Text('Digvijay'), //title of scaffold
          centerTitle: true,
          toolbarHeight: 30,
        ),
        body: Column(children: [
          Container(
            width: 170,
            height: 150,
            child: Image.asset(
              "assets/images/testImage.png",
              repeat: ImageRepeat.repeat,
            ),
          ),
          Image.asset(
            'assets/images/testImage.png',
            width: 170,
            height: 150,
          ),
        ]),
      ),
    );
  }
}
