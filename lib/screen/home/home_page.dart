import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(),
              RaisedButton(
                child: Text('start with compute'),
                onPressed: () async {
                  final sum =
                      await compute(computationallyExpensiveTask, 1000000000);
                  print(sum);
                },
              ),
              RaisedButton(
                child: Text('start with nomal'),
                onPressed: () async {
                  final sum = computationallyExpensiveTask(1000000000);
                  print(sum);
                },
              )
            ],
          ),
        ));
  }

  static int computationallyExpensiveTask(int value) {
    var sum = 0;
    for (var i = 0; i <= value; i++) {
      sum += i;
    }
    print('finished');
    return sum;
  }
}
