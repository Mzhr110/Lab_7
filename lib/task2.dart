import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(ApiApp());
}

class ApiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'API Fetch Demo', home: ApiHomePage());
  }
}

class ApiHomePage extends StatefulWidget {
  @override
  _ApiHomePageState createState() => _ApiHomePageState();
}

class _ApiHomePageState extends State<ApiHomePage> {
  Map<String, dynamic>? _post;
  bool _isLoading = false;

  Future<void> fetchRandomPost() async {
    setState(() {
      _isLoading = true;
      _post = null;
    });

    final randomId = Random().nextInt(100) + 1; // Random ID between 1 and 100
    final url = 'https://jsonplaceholder.typicode.com/posts/$randomId';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        setState(() {
          _post = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load post');
      }
    } catch (e) {
      setState(() {
        _post = {'title': 'Error', 'body': e.toString()};
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRandomPost(); // Fetch one when app loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Random Post Viewer')),
      body: Center(
        child:
            _isLoading
                ? CircularProgressIndicator()
                : _post != null
                ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _post!['title'],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Text(_post!['body']),
                    ],
                  ),
                )
                : Text('No post loaded'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchRandomPost,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
