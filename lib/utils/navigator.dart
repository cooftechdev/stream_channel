import 'package:flutter/material.dart';

void pushTo(BuildContext context, Widget child) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => child),
  );
}
