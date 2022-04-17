import 'dart:convert';

import 'package:buy_and_sell/home.dart';
import 'package:buy_and_sell/register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController _userName;
  TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _userName = TextEditingController();
    _password = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(
              flex: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  // color: Colors.deepOrange,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextFormField(
                controller: _userName,
                decoration: new InputDecoration(
                  prefixIcon: Icon(
                    Icons.person,
                    size: 24,
                    color: Colors.orangeAccent,
                  ),
                  labelText: "Enter Username",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if (val.length == 0) {
                    return "Username cannot be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.name,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: TextFormField(
                controller: _password,
                obscureText: true,
                decoration: new InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock_outlined,
                    size: 24,
                    color: Colors.orangeAccent,
                  ),
                  labelText: "Enter Password",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if (val.length == 0) {
                    return "Passsword cannot be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.visiblePassword,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: FlatButton(
                padding: EdgeInsets.zero,
                onPressed: () async {
                  var response = await login(
                      userName: _userName.text, password: _password.text);
                  if (response.runtimeType == String) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeView(
                          response,
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: FlatButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterView(),
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.orange,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future login({String userName, String password}) async {
  var header = {"Content-Type": "application/json"};
  http.Client client = new http.Client();
  String uri = 'https://buy-and-sell-online.herokuapp.com/login/';
  var response = await client.post(
    uri,
    headers: header,
    body: jsonEncode({"username": userName, "password": password}),
  );
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    return jsonDecode(response.body)['token'];
  }
}
