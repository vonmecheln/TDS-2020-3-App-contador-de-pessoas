import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dropdown/awesome_dropdown.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversor de moedas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Câmbio'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;

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

  @override
  void initState() {
    super.initState();
    buscaMoedas();
  }

  List<String> _listCurrencies = [""];
  late Map currencies;

  Future<Map> buscaMoedas() async {
    isLoading = true;

    await Future.delayed(Duration(seconds: 5));
    var retorno = await getData();
    var map = json.decode(retorno);

    currencies = map["results"]["currencies"];
    if (currencies.isNotEmpty) {
      _listCurrencies.clear();
      _selectedItemFrom = "BRL";
      _selectedItemTo = "BRL";

      currencies.forEach(
          (key, value) => _listCurrencies.add(key == "source" ? value : key));
    }

    isLoading = false;
    return map;
  }

  _calcularCambio() {
    var taxaFrom = 0.0;
    var taxaTo = 0.0;

    taxaFrom =
        _selectedItemFrom == "BRL" ? 1.0 : currencies[_selectedItemFrom]["buy"];

    taxaTo =
        _selectedItemTo == "BRL" ? 1.0 : currencies[_selectedItemTo]["buy"];

    setState(() {
      _result = _value * (taxaFrom / taxaTo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [_tela(context)],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            buscaMoedas();
          });
        },
        tooltip: 'Atualizar cotação',
        child: Icon(Icons.refresh),
      ),
    );
  }

  String _selectedItemFrom = "";
  String _selectedItemTo = "";
  double _value = 0;
  double _result = 0;

  Widget _tela(BuildContext context) {
    Widget conteudo = Container();

    conteudo = isLoading
        ? CircularProgressIndicator()
        : Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(
                  signed: false,
                  decimal: true,
                ),
                onChanged: (text) {
                  _value = double.tryParse(text) ?? 0;

                  _calcularCambio();
                },
              ),
              AwesomeDropDown(
                dropDownList: _listCurrencies,
                dropDownIcon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                  size: 23,
                ),
                selectedItem: _selectedItemFrom,
                onDropDownItemClick: (selectedItem) {
                  _selectedItemFrom = selectedItem;
                  _calcularCambio();
                },
              ),
              AwesomeDropDown(
                dropDownList: _listCurrencies,
                dropDownIcon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                  size: 23,
                ),
                selectedItem: _selectedItemFrom,
                onDropDownItemClick: (selectedItem) {
                  _selectedItemTo = selectedItem;
                  _calcularCambio();
                },
              ),
              Text(_result.toStringAsPrecision(3),
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.green,
                  )),
            ],
          );

    return Center(child: conteudo);
  }
}
