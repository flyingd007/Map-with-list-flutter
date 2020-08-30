import 'dart:convert';

import 'package:Assignment01/models/job.dart';
import 'package:Assignment01/screens/homeScreen.dart';
import 'package:Assignment01/screens/mapScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignment 01',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: JobsListView(),
      routes: {
        MapScreen.mapRoute: (context) => MapScreen(),
      },
    );
  }
}

Future<List<Job>> _fetchJobs() async {
  final jobsListAPIUrl = 'https://mock-json-service.glitch.me/';
  final response = await http.get(jobsListAPIUrl);

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((job) => new Job.fromJson(job)).toList();
  } else {
    throw Exception('Failed to load jobs from API');
  }
}

class JobsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Job>>(
      future: _fetchJobs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Job> data = snapshot.data;
          return HomeScreen(list: data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Scaffold(
          appBar: AppBar(
            title: Text("waiting"),
          ),
          body: CircularProgressIndicator(),
        );
      },
    );
  }
}
