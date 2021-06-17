import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

const api_url = "https:///";

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  Future<String> getData() async {
    var url = Uri.https('api.hgbrasil.com', '/finance');
    // var url = 'https://api.hgbrasil.com/finance';
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var body = response.body;
      return body;
    }

    return "";
  }

  Future<Map> buscaMoedas() async {
    // await Future.delayed(Duration(seconds: 2));

    var retorno = await getData();
    return json.decode(retorno);
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: buscaMoedas(),
        builder: _tela,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _tela(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    Widget conteudo = Container();

    switch (snapshot.connectionState) {
      case ConnectionState.none:
      case ConnectionState.waiting:
        conteudo = CircularProgressIndicator();
        break;
      default:
        if (!snapshot.hasError) {
          double dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];

          conteudo = Text(dolar.toStringAsPrecision(3),
              style: TextStyle(
                fontSize: 28,
                color: Colors.green,
              ));
        }
    }

    return Center(child: conteudo);
  }
}
