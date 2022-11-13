import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kashyap Login App',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: Login(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String name;
  MyHomePage({required this.name});

  @override
  _MyHomePageState createState() => _MyHomePageState(name);
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  String name = "";
  _MyHomePageState(this.name);

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: Center(child: Text("Welcome To Our registration, $name")));
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  var _email = TextEditingController();
  var _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: Padding(
          padding: EdgeInsets.all(6.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Email";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Email", border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 6.0,
                ),
                TextFormField(
                  obscureText: true,
                  controller: _password,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Password";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Password", border: OutlineInputBorder()),
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            login(_email.text, _password.text, context);
                          }
                        },
                        child: Text("Login"))),
                SizedBox(
                  height: 6.0,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: Text(
                      "Register?",
                      style:
                          TextStyle(color: Color.fromARGB(255, 222, 249, 13)),
                    ))
              ],
            ),
          ),
        ));
  }

  void login(String email, String password, BuildContext context) async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(email)) {
      var details = prefs.getStringList(email)!;
      if (details[2] == password) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(name: details[0])));
      } else {
        Fluttertoast.showToast(
            msg: "Incorrect Password",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromARGB(255, 244, 244, 54),
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      Fluttertoast.showToast(
          msg: "User doesn't exist",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromARGB(255, 231, 244, 54),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
  var _email = TextEditingController();
  var _password = TextEditingController();
  var _name = TextEditingController();
  var _cpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sign Up"),
        ),
        body: Padding(
          padding: EdgeInsets.all(6.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Name";
                    }
                    return null;
                  },
                  controller: _name,
                  decoration: InputDecoration(
                      labelText: "Username", border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 6.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Email";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  controller: _email,
                  decoration: InputDecoration(
                      labelText: "Email", border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 6.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Password";
                    }
                    return null;
                  },
                  controller: _password,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Password", border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 6.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter confirm password";
                    } else if (value.length <= 8) {
                      return "Invalid confirm password";
                    }
                    return null;
                  },
                  controller: _password,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      labelText: "confirm password",
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            signUp(_name.text, _email.text, _password.text,
                                _password.text);
                          }
                        },
                        child: Text("Sign Up"))),
              ],
            ),
          ),
        ));
  }

  void signUp(String username, String email, String password,
      String confirmpassword) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setStringList(email, [username, email, password, password]);
  }
}
