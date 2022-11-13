import 'dart:convert';
import 'package:flutter/material.dart'; //importing packages in flutter
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    title:
        'WEATHER APP', //app name shown from package name and for main title this is.
    theme: ThemeData(primarySwatch: Colors.yellow),
  )); //for run a code here class MyApp for run
}

//shortcut for stateless is stl
class MyApp extends StatelessWidget {
  //stateless widget class
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyScreen(); //return to statefullwidget of MyScreen class
  }
}

//shortcut for stateless is stf
class MyScreen extends StatefulWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  var city = '';
  var temp = '';
  var pressure = '';

  @override
  void initState() {
    api1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //scaffold
      appBar: AppBar(
        //appbar for show scaffold title
        iconTheme: const IconThemeData(color: Colors.white, size: 32),
        centerTitle: true,
        title: const Text(
          'WEATHER APP',
          style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontFamily: 'arial black',
              fontWeight: FontWeight.bold),
        ), //title of scaffold
        backgroundColor: Color.fromARGB(255, 19, 161, 243),
        toolbarHeight: 50,
        leadingWidth: 50,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/"),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      'City name : $city',
                      style: const TextStyle(
                          fontSize: 35,
                          color: Color.fromARGB(255, 243, 16, 16),
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Temp : $temp °C',
                      style: const TextStyle(
                          fontSize: 30,
                          color: Color.fromARGB(255, 241, 241, 8)),
                    ),
                    Text(
                      'Pressure : $pressure',
                      style: const TextStyle(
                          fontSize: 15, color: Color.fromARGB(255, 6, 250, 6)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void api1() async {
    if (city == '') {
      setState(() {
        city = 'Loading Data....';
        temp = 'Loading Data....';
        pressure = 'Loading Data....';
      });
    }
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=22.3053263&lon=70.8028377&appid=55dfa2348fcd185ac2b4008afdf8acc8');
    var response = await http.get(url);
    setState(() {
      city = json.decode(response.body)['name'];
      temp = ((json.decode(response.body)["main"]["temp"]) - 273.15)
          .toStringAsFixed(2);
      pressure = json.decode(response.body)["main"]['pressure'].toString();
    });
  }
}
