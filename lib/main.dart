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
  TextEditingController nameCtl = TextEditingController();
  TextEditingController jobCtl = TextEditingController();

  String resResult = "Belum ada data...";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HTTP PUT / PATCH"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
            child: TextField(
              controller: nameCtl,
              autocorrect: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Nama Lengkap",
              ),
              keyboardType: TextInputType.text,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
            child: TextField(
              controller: jobCtl,
              autocorrect: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Job Description",
              ),
              keyboardType: TextInputType.text,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
            child: ElevatedButton(
              onPressed: () async {
                var response = await http.put(
                  Uri.parse("https://reqres.in/api/users/2"),
                  body: {"name": nameCtl.text, "job": jobCtl.text},
                );

                Map<String, dynamic> data = json.decode(response.body);

                setState(() {
                  resResult = "${data['name']} | ${data['job']}";
                });
              },
              child: Text("Submit"),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(resResult),
          ),
        ],
      ),
    );
  }
}
