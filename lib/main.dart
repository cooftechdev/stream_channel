import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const stream = const EventChannel('eventchannelsample');
  String data = 'Turn off or turn on Internet';
  StreamSubscription _streamSubscription;

  void _enableStream() {
    if (_streamSubscription == null) {
      _streamSubscription = stream.receiveBroadcastStream().listen(_updateData);
    }
  }

  void _disableStream() {
    if (_streamSubscription != null) {
      _streamSubscription.cancel();
      _streamSubscription = null;
    }
  }

  void _updateData(dataReceived) {
    setState(() {
      data = dataReceived.toString();
    });
    print(data);
  }

  @override
  void initState() {
    _enableStream();
    super.initState();
  }

  @override
  void dispose() {
    _disableStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'), // Demo
      ),
      body: SafeArea(child: Builder(
        builder: (context) {
          return Center(child: Text(data));
        },
      )),
    );
  }
}
