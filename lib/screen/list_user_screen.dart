import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListUserScreen extends StatefulWidget {
  const ListUserScreen({super.key});
  @override
  State<ListUserScreen> createState() => _ListUserScreenState();
}

class _ListUserScreenState extends State<ListUserScreen> {
  var userData = [];
  // final TextEditingController _idSearchController = TextEditingController();
  void getUser() async {
    try {
      var response = await http.get(Uri.parse("https://dummyjson.com/users"));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        // User user = User.fromJson(data);
        // setState(() {
        //   userData = user;
        // });
        // print('Name : ${user.firstName}');
        List<dynamic> jsonList = data['users'];
        setState(() {
          userData = jsonList;
        });
        print(jsonList[0]);
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
        child: ListView.separated(
          itemCount: userData.length,
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Text('ID: ${userData[index]['id']}'),
              title: Text(userData[index]['firstName']),
            );
          },
        ),
        // child: Column(
        //   children: [
        //     // TextFormField(
        //     //   controller: _idSearchController,
        //     //   decoration: InputDecoration(labelText: 'ID'),
        //     // ),
        //     // Text("Name : ${userData?.firstName}"),
        //     // Text("Username : ${userData?.username}"),
        //     // Text("Email : ${userData?.email}"),
        //     ElevatedButton(
        //       onPressed: () {
        //         setState(() {
        //           getUser();
        //         });
        //       },
        //       child: Text("Call API"),
        //     ),
        //     // ListView.separated(
        //     //   itemCount: userData.length,
        //     //   itemBuilder: (context, index) {
        //     //     return Text('$index ${userData[index + 1].firstName}');
        //     //   },
        //     //   separatorBuilder: (context, index) {
        //     //     return const Divider();
        //     //   },
        //     // ),
        //   ],
        // ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          getUser();
        },
        child: Text('Call Api'),
      ),
    );
  }
}
