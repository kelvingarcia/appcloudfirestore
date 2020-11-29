import 'package:cloudfirestoreapp/components/input_field.dart';
import 'package:cloudfirestoreapp/screens/home.dart';
import 'package:cloudfirestoreapp/screens/sign_up.dart';
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
  final _formKey = GlobalKey<FormState>();

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

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (regex.hasMatch(value)) ? false : true;
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _senhaController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Form(
            key: _formKey,
            child: Center(
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
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InputField(
                      validacao: (value) {
                        if (value.isEmpty) {
                          return 'O campo e-mail não pode ser vazio';
                        }
                        if (validateEmail(value)) {
                          return 'E-mail inválido';
                        }
                        return null;
                      },
                      controller: _emailController,
                      label: 'E-mail',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InputField(
                      validacao: (value) {
                        if (value.isEmpty) {
                          return 'O campo senha não pode ser vazio';
                        }
                        return null;
                      },
                      senha: true,
                      controller: _senhaController,
                      label: 'Senha',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUp(),
                      ),
                    ),
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
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        logInToFb();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
