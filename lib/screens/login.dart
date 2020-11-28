import 'package:cloudfirestoreapp/components/input_field.dart';
import 'package:cloudfirestoreapp/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final firestoreInstance = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  void logInToFb() {
    firestoreInstance
        .signInWithEmailAndPassword(
            email: _emailController.text, password: _senhaController.text)
        .then((result) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home(
            email: result.user.email,
          ),
        ),
      );
    }).catchError((err) {
      print(err.message);
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
              'LOGIN',
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
                child: Text('Ainda não possui uma conta? Registre-se'),
              ),
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                'ENTRAR',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                ),
              ),
              onPressed: () => logInToFb(),
            ),
          ],
        ),
      ),
    );
  }
}
