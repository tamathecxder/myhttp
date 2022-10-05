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
  late String id;
  late String name;
  late String email;

  @override
  void initState() {
    // TODO: implement initState
    id = "";
    name = "";
    email = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HTTP GET"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "ID: $id",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Name: $name",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Email: $email",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 14,
            ),
            ElevatedButton(
              onPressed: () async {
                var myResponse = await http.get(
                  Uri.parse("https://reqres.in/api/users/1"),
                );

                if (myResponse.statusCode == 200) {
                  Map<String, dynamic> data =
                      json.decode(myResponse.body) as Map<String, dynamic>;
                  print("Successfull");
                  print(data);

                  setState(() {
                    id = data["data"]["id"].toString();
                    email = data["data"]["email"].toString();
                    name =
                        "${data['data']['first_name']} ${data['data']['last_name']}";
                  });
                } else {
                  print("Error: ${myResponse.statusCode}");
                }
              },
              child: Text("Get Data"),
            ),
          ],
        ),
      ),
    );
  }
}
