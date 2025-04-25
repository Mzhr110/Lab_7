import 'package:flutter/material.dart';

void main() {
  runApp(DatabaseSimulationApp());
}

class DatabaseSimulationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Fake DB Fetch', home: DatabaseHomePage());
  }
}

class DatabaseHomePage extends StatefulWidget {
  @override
  _DatabaseHomePageState createState() => _DatabaseHomePageState();
}

class _DatabaseHomePageState extends State<DatabaseHomePage> {
  List<String> _fakeData = [];
  bool _isLoading = true;

  Future<void> fetchDataFromFakeDB() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(seconds: 3)); // Simulate DB delay

    // Simulated data from "local database"
    List<String> dataFromDB = [
      'Apple',
      'Banana',
      'Cherry',
      'Mango',
      'Pineapple',
      'Grapes',
      'Orange',
    ];

    setState(() {
      _fakeData = dataFromDB;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchDataFromFakeDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Async DB Simulation')),
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: _fakeData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.storage),
                    title: Text(_fakeData[index]),
                  );
                },
              ),
    );
  }
}
