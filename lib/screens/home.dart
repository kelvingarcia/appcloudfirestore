import 'package:cloudfirestoreapp/screens/dados_usuario.dart';
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
                  Text(
                    'Kelvin Rodrigues Garcia',
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
              title: Text('Travessa João Rodrigues, 36'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('AP 91 - Santo André - SP'),
                  Text('Ponto geográfico'),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(Icons.phone),
              title: Text('(11) 96542-8625'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(Icons.cake),
              title: Text('04 de dezembro'),
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
                builder: (context) => DadosUsuario(email: widget.email,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
