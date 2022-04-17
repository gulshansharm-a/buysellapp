import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  final String token;
  ProfileView(this.token);
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String fullName;
  String userName;
  String phoneNumber;

  @override
  void initState() {
    super.initState();
    fullName = "";
    userName = "";
    phoneNumber = "";
    getProfile(widget.token).then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(16.0),
          width: 150,
          height: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(75.0),
            child: Image.asset(
              Random().nextBool()
                  ? 'assets/profile1.png'
                  : 'assets/profile2.png',
            ),
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.deepOrange, width: 2),
            color: Colors.orange[50],
            borderRadius: BorderRadius.circular(75),
          ),
        ),
        Text(
          fullName,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w500,
            color: Colors.grey[800],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            userName,
            style: TextStyle(
              fontSize: 18,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.w500,
              color: Colors.grey[500],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            phoneNumber,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Colors.deepOrangeAccent,
            ),
          ),
        )
      ],
    );
  }

  Future getProfile(String token) async {
    var header = {"Authorization": "Token $token"};
    http.Client client = new http.Client();
    String uri = 'https://buy-and-sell-online.herokuapp.com/user/';
    var response = await client.get(uri, headers: header);
    print(response.statusCode);
    // print(response.body);
    var obj = jsonDecode(response.body);
    setState(() {
      fullName = obj['first_name'] + ' ' + obj['last_name'];
      userName = obj['username'];
      phoneNumber = obj['phone_no'];
    });
  }
}
