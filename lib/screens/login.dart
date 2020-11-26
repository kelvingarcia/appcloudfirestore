import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudfirestoreapp/components/input_field.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final firestoreInstance = FirebaseFirestore.instance;

  void _onPressed() {
    firestoreInstance.collection("users").add({
      "name": "john",
      "age": 50,
      "email": "example@example.com",
      "address": {"street": "street 24", "city": "new york"}
    }).then((value) {
      debugPrint(value.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'LOGIN',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 24.0,
              ),
            ),
            Icon(Icons.star),
            Text('Acesse sua conta'),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InputField(
                label: 'E-mail',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InputField(
                label: 'Senha',
              ),
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).accentColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'ENTRAR',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                ],
              ),
              onPressed: () => _onPressed(),
            ),
          ],
        ),
      ),
    );
  }
}
