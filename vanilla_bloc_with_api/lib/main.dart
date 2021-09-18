import 'package:flutter/material.dart';

import 'screen/home_page.dart';

void main() => runApp(VanillaBlocApp());

class VanillaBlocApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
