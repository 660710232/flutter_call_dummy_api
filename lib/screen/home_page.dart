import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_call_dummy_api/model/user_data.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? userData;
  final TextEditingController _idSearchController = TextEditingController();
  void fetchUser() async {
    try {
      var response = await http.get(Uri.parse("https://dummyjson.com/users/${_idSearchController.text}"));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        User user = User.fromJson(data);

        setState(() {
          userData = user;
        });
        print('Name : ${user.firstName}');
      } else {
        print('Failed to fetch data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Simple API Call")),
      body: Center(
        child: Column(
          children: [
            TextFormField(
              controller: _idSearchController ,
              decoration: InputDecoration(
                labelText: 'ID'
              ),
            ),
            Text("Name : ${userData?.firstName}"),
            Text("LastName : ${userData?.lastName}"),
            Text("Email : ${userData?.email}"),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  fetchUser();
                });
              },
              child: Text("Call API"),
            ),
          ],
        ),
      ),
    );
  }
}
