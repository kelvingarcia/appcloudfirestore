import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudfirestoreapp/components/input_field.dart';
import 'package:cloudfirestoreapp/http/webclients/cep_client.dart';
import 'package:cloudfirestoreapp/model/info_usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DadosUsuario extends StatefulWidget {
  final String email;
  final InfoUsuario infoUsuario;

  const DadosUsuario({Key key, this.email, this.infoUsuario}) : super(key: key);

  @override
  _DadosUsuarioState createState() => _DadosUsuarioState();
}

class _DadosUsuarioState extends State<DadosUsuario> {
  final firestoreInstance = FirebaseFirestore.instance;
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _sobrenomeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _cepController = TextEditingController();
  TextEditingController _logradouroController = TextEditingController();
  TextEditingController _numeroController = TextEditingController();
  TextEditingController _complementoController = TextEditingController();
  TextEditingController _cidadeController = TextEditingController();
  TextEditingController _telefoneController = TextEditingController();
  TextEditingController _dataNascimentoController = TextEditingController();
  TextEditingController _pontoGeograficoController = TextEditingController();
  String _currentSelectedValue = 'SP';
  List<String> _estados = [
    'AC',
    'AL',
    'AP',
    'AM',
    'BA',
    'CE',
    'ES',
    'GO',
    'MA',
    'MT',
    'MS',
    'MG',
    'PA',
    'PB',
    'PR',
    'PE',
    'PI',
    'RJ',
    'RN',
    'RS',
    'RO',
    'RR',
    'SC',
    'SP',
    'SE',
    'TO',
    'DF',
  ];

  void getCep() async {
    var respostaCep = await CepClient.getRespostaCep(_cepController.text);
    debugPrint(respostaCep.toString());
    setState(() {
      _logradouroController.text = respostaCep.logradouro;
      _cidadeController.text = respostaCep.localidade;
      _currentSelectedValue = respostaCep.uf;
    });
  }

  void _onPressed() {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    firestoreInstance.collection("users").doc(firebaseUser.uid).set({
      "nome": _nomeController.text,
      "sobrenome": _sobrenomeController.text,
      "email": _emailController.text,
      "cep": _cepController.text,
      "logradouro": _logradouroController.text,
      "numero": _numeroController.text,
      "complemento": _complementoController.text,
      "cidade": _cidadeController.text,
      "estado": _currentSelectedValue,
      "ponto geografico": _pontoGeograficoController.text,
      "telefone": _telefoneController.text,
      "aniversario": _dataNascimentoController.text,
    },SetOptions(merge: true)).then((value) {
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
                Text('Suas informações foram salvas com sucesso!'),
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
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        if(widget.infoUsuario != null){
          _nomeController.text = widget.infoUsuario.nome;
          _sobrenomeController.text = widget.infoUsuario.sobrenome;
          _emailController.text = widget.infoUsuario.email;
          _cepController.text = widget.infoUsuario.cep;
          _logradouroController.text = widget.infoUsuario.logradouro;
          _numeroController.text = widget.infoUsuario.numero;
          _complementoController.text = widget.infoUsuario.complemento;
          _cidadeController.text = widget.infoUsuario.cidade;
          _currentSelectedValue = widget.infoUsuario.estado;
          _pontoGeograficoController.text = widget.infoUsuario.pontoGeografico;
          _telefoneController.text = widget.infoUsuario.telefone;
          _dataNascimentoController.text = widget.infoUsuario.aniversario;
        } else {
          _emailController.text = widget.email;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _nomeController.dispose();
    _sobrenomeController.dispose();
    _emailController.dispose();
    _cepController.dispose();
    _logradouroController.dispose();
    _numeroController.dispose();
    _complementoController.dispose();
    _cidadeController.dispose();
    _telefoneController.dispose();
    _dataNascimentoController.dispose();
    _pontoGeograficoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dados do usuário'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InputField(
                  controller: _nomeController,
                  label: 'Nome',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InputField(
                  controller: _sobrenomeController,
                  label: 'Sobrenome',
                ),
              ),
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
                  controller: _cepController,
                  label: 'CEP',
                  mascara: MaskTextInputFormatter(
                      mask: "#####-###", filter: {"#": RegExp(r'[0-9]')}),
                  numeros: true,
                  onChange: (value) {
                    if(value.length >= 9){
                      getCep();
                    }
                  },
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
                          numeros: true,
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
                        padding: const EdgeInsets.only(
                          left: 8.0,
                        ),
                        child: FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                labelText: 'Estado',
                                filled: true,
                                fillColor: Colors.grey[300],
                              ),
                              isEmpty: _currentSelectedValue == '',
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _currentSelectedValue,
                                  isDense: true,
                                  onChanged: (String newValue) {
                                    setState(() {
                                      _currentSelectedValue = newValue;
                                      state.didChange(newValue);
                                    });
                                  },
                                  items: _estados.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InputField(
                  controller: _pontoGeograficoController,
                  label: 'Ponto geográfico',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InputField(
                  controller: _telefoneController,
                  label: 'Telefone',
                  mascara: MaskTextInputFormatter(
                      mask: "(##) #####-####", filter: {"#": RegExp(r'[0-9]')}),
                  numeros: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InputField(
                  controller: _dataNascimentoController,
                  label: 'Aniversário',
                  mascara: MaskTextInputFormatter(
                      mask: "##/##", filter: {"#": RegExp(r'[0-9]')}),
                  numeros: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0, top: 16.0),
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'ENVIAR',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  onPressed: () => _onPressed(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
