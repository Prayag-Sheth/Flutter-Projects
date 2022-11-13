import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter DropDownButton',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
// Initial Selected Value
  String dropdownvalue = 'Default';

// List of items in our dropdown menu
  var items = [
    'Default',
    'Green',
    'Blue',
    'Orange',
    'Red',
    'Violet',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.getColorFor(dropdownvalue),
      appBar: AppBar(
        title: const Text("Color Selection"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
              // Initial Value
              value: dropdownvalue,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AppColor {
  static const RED = "RED";
  static const GREEN = "GREEN";
  static const BLUE = "BLUE";
  static const ORANGE = "ORANGE";
  static const VIOLET = "VIOLET";
  static const DEFAULT = "DEFAULT";

  static const _colorMap = {
    RED: Colors.red,
    GREEN: Colors.green,
    VIOLET: Color.fromARGB(255, 143, 116, 250),
    ORANGE: Colors.orange,
    BLUE: Colors.blue,
    DEFAULT: Color.fromARGB(255, 175, 247, 240),
  };

  const AppColor._();

  static getColorFor(String color) =>
      _colorMap[color.toUpperCase()] ?? _colorMap[DEFAULT];
}
