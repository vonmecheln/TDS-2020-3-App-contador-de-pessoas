import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lista_tarefa/data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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

class _MyHomePageState extends State<MyHomePage> {
  PersistenceData data = DataFactory.getProvider();

  final _textController = TextEditingController();
  var _posRemoved = 0;
  var _doToRemoved = new Map<String, dynamic>();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    data.load().then((value) {
      setState(() {
        _toDoList = value.isNotEmpty ? json.decode(value) : [];
      });
    });
  }

  void _saveData() {
    String jsonList = json.encode(_toDoList);
    data.save(jsonList);
  }

  void _addTodo() {
    setState(() {
      var newTodo = Map<String, dynamic>();
      newTodo["name"] = _textController.text;
      newTodo["ok"] = false;
      _toDoList.insert(0, newTodo);
      _textController.clear();
      _saveData();
    });
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _toDoList.sort((a, b) {
        if (a["ok"] && !b["ok"]) return 1;
        if (!a["ok"] && b["ok"]) return -1;
        return 0;
      });
      _saveData();
    });
  }

  List _toDoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Lista de Terefas'),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          actions: [
            PopupMenuButton(itemBuilder: (context) {
              return persistenceProvider.values
                  .map((e) => PopupMenuItem(
                        child: StatefulBuilder(
                          builder: (_, __) => buildProviderButton(e),
                        ),
                      ))
                  .toList();
            })
          ]),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                            labelText: "Nova Tarefa",
                            labelStyle: TextStyle(color: Colors.blueAccent))),
                  ),
                  SizedBox(width: 4.0),
                  ElevatedButton(
                    onPressed: _addTodo,
                    child: Text('ADD'),
                  )
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refresh,
                child: ListView.builder(
                  itemCount: _toDoList.length,
                  itemBuilder: buildItem,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItem(context, index) {
    return Dismissible(
        key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
        background: Container(
          color: Colors.red,
          child: Align(
            alignment: Alignment(-0.9, 0.0),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
        direction: DismissDirection.startToEnd,
        child: CheckboxListTile(
          value: _toDoList[index]['ok'],
          onChanged: (c) {
            setState(() {
              _toDoList[index]['ok'] = c;
            });
          },
          title: Text(_toDoList[index]['name']),
          secondary: CircleAvatar(
            child: Icon(
              _toDoList[index]['ok'] ? Icons.check : Icons.error,
            ),
          ),
        ),
        onDismissed: (_) {
          setState(() {
            _posRemoved = index;
            _doToRemoved = Map.from(_toDoList[index]);
            _toDoList.removeAt(index);
            _saveData();

            final snack = SnackBar(
              content: Text('Tarefa \"${_doToRemoved["name"]}\" removida!'),
              action: SnackBarAction(
                label: 'Desfazer',
                onPressed: () {
                  setState(() {
                    _toDoList.insert(_posRemoved, _doToRemoved);
                    _saveData();
                  });
                },
              ),
              duration: Duration(seconds: 2),
            );

            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(snack);
          });
        });
  }

  Widget buildProviderButton(persistenceProvider type) {
    return IconButton(
      onPressed: () {
        data = DataFactory.getProvider(type: type);
        _loadData();
        Navigator.pop(context);
      },
      icon: Icon(
        _getIcon(type),
      ),
      color: DataFactory.providerType == type ? Colors.blue : Colors.grey,
    );
  }

  IconData _getIcon(persistenceProvider type) {
    {
      switch (type) {
        case persistenceProvider.File:
          return Icons.file_present_outlined;
        case persistenceProvider.KeyValue:
          return Icons.vpn_key;
        case persistenceProvider.SQLite:
          return Icons.storage_outlined;
        default:
          return Icons.file_present_outlined;
      }
    }
  }
}
