import 'package:cloudfirestoreapp/components/input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final firestoreInstance = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  void registerToFb() {
    firestoreInstance
        .createUserWithEmailAndPassword(
            email: _emailController.text, password: _senhaController.text)
        .then((result) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Login()),
        );
        }).catchError((err) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Erro"),
                  content: Text(err.message),
                  actions: [
                    FlatButton(
                      child: Text("Ok"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
        });
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _senhaController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'CADASTRO',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 24.0,
              ),
            ),
            Icon(
              Icons.star,
              size: 52.0,
            ),
            Text('Acesse sua conta'),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InputField(
                controller: _emailController,
                label: 'E-mail',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InputField(
                senha: true,
                controller: _senhaController,
                label: 'Senha',
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 32.0,
                  bottom: 16.0,
                ),
                child: Text('Já possui uma conta? Faça login'),
              ),
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                'CADASTRAR',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                ),
              ),
              onPressed: () => registerToFb(),
            ),
          ],
        ),
      ),
    );
  }
}
