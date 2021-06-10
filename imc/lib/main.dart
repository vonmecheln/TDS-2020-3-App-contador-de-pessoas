import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora IMC',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController contAltura = TextEditingController();
  TextEditingController contPeso = TextEditingController();

  String _avaliacao = "";
  String _errorAltura = "";
  String _errorPeso = "";

  void calcular() {
    double altura = 0;
    double peso = 0;
    double imc = 0;
    _errorPeso = "";
    _errorAltura = "";

    try {
      altura = double.parse(contAltura.text);
      if (altura == 0) throw Exception();
      altura /= 100; //metros para centimetros
    } catch (e) {
      _errorAltura = "Altura inválida";
    }

    try {
      peso = double.parse(contPeso.text);
    } catch (e) {
      _errorPeso = "Peso inválido";
    }

    imc = peso / (altura * altura);

    _avaliacao = "ICM: " + imc.toStringAsPrecision(4);

    if (imc < 16.0)
      _avaliacao += " Magreza Grave.";
    else if (imc < 17.0)
      _avaliacao += " Magreza Moderada.";
    else
      _avaliacao += " ------- ";

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora IMC'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Informe sua altura (cm)'),
              TextField(
                keyboardType: TextInputType.numberWithOptions(
                  signed: false,
                  decimal: true,
                ),
                controller: contAltura,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              Text(_errorAltura, style: TextStyle(color: Colors.redAccent)),
              Divider(),
              Text(
                'Informe seu peso',
              ),
              TextField(
                keyboardType: TextInputType.numberWithOptions(
                  signed: false,
                  decimal: true,
                ),
                controller: contPeso,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              Text(_errorPeso, style: TextStyle(color: Colors.redAccent)),
              Divider(),
              ElevatedButton(onPressed: calcular, child: Text('Calcular')),
              Text(_avaliacao),
            ],
          ),
        ),
      ),
    );
  }
}
