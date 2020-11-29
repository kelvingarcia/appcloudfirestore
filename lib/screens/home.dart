import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudfirestoreapp/model/info_usuario.dart';
import 'package:cloudfirestoreapp/screens/dados_usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Home extends StatefulWidget {
  final String email;

  const Home({Key key, this.email}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final firestoreInstance = FirebaseFirestore.instance;
  final String uid = FirebaseAuth.instance.currentUser.uid;
  InfoUsuario infoUsuario = null;
  bool futureBuilder = false;

  void _buscaDados(){
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      firestoreInstance.collection('users').doc(uid).get().then((value) {
        setState(() {
          infoUsuario = InfoUsuario(
            nome: value['nome'],
            sobrenome: value['sobrenome'],
            email: value['email'],
            cep: value['cep'],
            logradouro: value['logradouro'],
            numero: value['numero'],
            complemento: value['complemento'],
            cidade: value['cidade'],
            estado: value['estado'],
            pontoGeografico: value['ponto geografico'],
            telefone: value['telefone'],
            aniversario: value['aniversario'],
          );
          futureBuilder = true;
        });
      }).catchError((err) {
        setState(() {
          futureBuilder = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _buscaDados();
    if (futureBuilder) {
      if (infoUsuario == null) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Home'),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.person,
                        size: 56.0,
                      ),
                      Text(widget.email),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Icon(Icons.warning),
                  title: Text('Dados inexistentes'),
                  subtitle:
                      Text('Clique no botão abaixo para inserir seus dados'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'INSERIR DADOS',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DadosUsuario(
                        email: widget.email,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
      return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0, top: 24.0),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.person,
                      size: 56.0,
                    ),
                    Text(
                      infoUsuario.nome + ' ' + infoUsuario.sobrenome,
                      style: TextStyle(fontSize: 24.0),
                    ),
                    Text(widget.email),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(Icons.place),
                title: Text(infoUsuario.logradouro + ', ' + infoUsuario.numero),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(infoUsuario.complemento +
                        ' - ' +
                        infoUsuario.cidade +
                        ' - ' +
                        infoUsuario.estado),
                    Text(infoUsuario.pontoGeografico),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(Icons.phone),
                title: Text(infoUsuario.telefone),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(Icons.cake),
                title: Text(infoUsuario.aniversario),
              ),
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                'EDITAR DADOS',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                ),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DadosUsuario(
                    infoUsuario: infoUsuario,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[CircularProgressIndicator(), Text('Aguarde...')],
        ),
      ),
    );
  }
}
