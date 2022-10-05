import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String userEmail;

  @override
  void initState() {
    // TODO: implement initState
    userEmail = "Belum ada data...";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HTTP DELETE"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              var response = await http.get(
                Uri.parse("https://reqres.in/api/users/1"),
              );

              Map<String, dynamic> data =
                  json.decode(response.body) as Map<String, dynamic>;

              setState(() {
                userEmail = data["data"]["email"];
              });
            },
            icon: Icon(Icons.download),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text(userEmail),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              var response = await http.delete(
                Uri.parse("https://reqres.in/api/users/1"),
              );

              if (response.statusCode == 204) {
                setState(() {
                  userEmail = "...";
                });
              } else {
                print("Data gagal terhapus!");
              }
            },
            child: Text("Delete User"),
          ),
        ],
      ),
    );
  }
}
