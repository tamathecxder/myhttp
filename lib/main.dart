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

class HomePage extends StatelessWidget {
  List<Map<String, dynamic>> users = [];

  Future getUsers() async {
    try {
      var response =
          await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
      List data = (json.decode(response.body) as Map<String, dynamic>)["data"];
      data.forEach((element) {
        users.add(element);
      });

      print(users);
    } catch (e) {
      print("Terjadi Kesalahan!");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Future Builder"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: FutureBuilder(
          future: getUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("Loading....."),
              );
            } else {
              if (users.length == 0) {
                return Center(child: Text("Tidak ada data."));
              }
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage("${users[index]['avatar']}"),
                  ),
                  title: Text(
                      "Nama Lengkap: ${users[index]['first_name']} ${users[index]['last_name']}"),
                  subtitle: Text("Email: ${users[index]['email']}"),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
