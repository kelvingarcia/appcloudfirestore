import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String email;

  const Home({Key key, this.email}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text(widget.email),
      ),
    );
  }
}
