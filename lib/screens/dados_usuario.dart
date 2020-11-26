import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudfirestoreapp/components/input_field.dart';
import 'package:cloudfirestoreapp/http/webclients/cep_client.dart';
import 'package:flutter/material.dart';

class DadosUsuario extends StatefulWidget {
  @override
  _DadosUsuarioState createState() => _DadosUsuarioState();
}

class _DadosUsuarioState extends State<DadosUsuario> {
  final firestoreInstance = FirebaseFirestore.instance;
  TextEditingController _cepController = TextEditingController();
  TextEditingController _logradouroController = TextEditingController();
  TextEditingController _numeroController = TextEditingController();
  TextEditingController _complementoController = TextEditingController();
  TextEditingController _cidadeController = TextEditingController();
  TextEditingController _estadoController = TextEditingController();
  TextEditingController _telefoneController = TextEditingController();
  TextEditingController _dataNascimentoController = TextEditingController();

  void getCep() async {
    var respostaCep = await CepClient.getRespostaCep(_cepController.text);
    debugPrint(respostaCep.toString());
    setState(() {
      _logradouroController.text = respostaCep.logradouro;
      _cidadeController.text = respostaCep.localidade;
      _estadoController.text = respostaCep.uf;
    });
  }

  void _onPressed() {
    firestoreInstance.collection("users").add({
      "cep": _cepController.text,
      "logradouro": _logradouroController.text,
      "numero": _numeroController.text,
      "complemento": _complementoController.text,
      "cidade": _cidadeController.text,
      "estado": _estadoController.text,
      "telefone": _telefoneController.text,
      "nascimento": _dataNascimentoController.text,
    }).then((value) {
      debugPrint(value.id);
      _showOk();
    });
  }

  Future<void> _showOk() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Aviso'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Suas informações foram salvas com sucesso!'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InputField(
                  controller: _cepController,
                  label: 'CEP',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InputField(
                  controller: _logradouroController,
                  label: 'Logradouro',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: InputField(
                          controller: _numeroController,
                          label: 'Número',
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: InputField(
                          controller: _complementoController,
                          label: 'Complemento',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: InputField(
                          controller: _cidadeController,
                          label: 'Cidade',
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: InputField(
                          controller: _estadoController,
                          label: 'SP',
                          icone: Icon(Icons.arrow_downward),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InputField(
                  controller: _telefoneController,
                  label: 'Telefone',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InputField(
                  controller: _dataNascimentoController,
                  label: 'Data de nascimento',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'GET CEP',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onPressed: () => getCep(),
                  ),
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'ENVIAR',
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
            ],
          ),
        ),
      ),
    );
  }
}
