import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController _userName;
  TextEditingController _fullName;
  TextEditingController _phoneNumber;
  TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _userName = TextEditingController();
    _fullName = TextEditingController();
    _password = TextEditingController();
    _phoneNumber = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 30,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(
                  flex: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
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
                    controller: _fullName,
                    decoration: new InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        size: 24,
                        color: Colors.orangeAccent,
                      ),
                      labelText: "Enter Full Name",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide: new BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                    validator: (val) {
                      if (val.length == 0) {
                        return "Full Name cannot be empty";
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
                    controller: _phoneNumber,
                    decoration: new InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone,
                        size: 24,
                        color: Colors.orangeAccent,
                      ),
                      labelText: "Enter Phone Number",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide: new BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                    validator: (val) {
                      if (val.length == 0) {
                        return "Phone number cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.phone,
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
                      bool response = await register(
                        fullName: _fullName.text,
                        password: _password.text,
                        phoneNumber: _phoneNumber.text,
                        userName: _userName.text,
                      );
                      if (response) {
                        Navigator.pop(context);
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
                        'Register',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool> register(
    {String userName,
    String fullName,
    String phoneNumber,
    String password}) async {
  var header = {"Content-Type": "application/json"};
  http.Client client = new http.Client();
  String uri = 'https://buy-and-sell-online.herokuapp.com/user/';
  var response = await client.post(
    uri,
    // headers: header,
    body: {
      "username": userName,
      "first_name": fullName.split(' ').first,
      "last_name": fullName.split(' ').last,
      "phone_no": '+91 ' + phoneNumber,
      "password": password
    },
  );
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200)
    return true;
  else
    return false;
}
