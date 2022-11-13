import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'json Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List<String>> data = [];
  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
        appBar: AppBar(
          title: Text("listview in json"),
        ),
        body: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, int index) {
              return Card(
                child: ListTile(
                  title: Text(data[index][1]),
                  subtitle: Text(data[index][0]),
                ),
              );
            }));
  }

  void getData() async {
    var url = Uri.parse("https://dummyjson.com/products/category/smartphones");
    var response = await http.get(url);
    var parsed = jsonDecode(response.body);
    var products = parsed["products"];
    setState(() {
      for (int i = 0; i < products.length; i++) {
        data.add([products[i]["title"], products[i]["description"]]);
      }
    });
  }
}
