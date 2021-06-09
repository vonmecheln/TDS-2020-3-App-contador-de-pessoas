import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter TDS",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          headline1: TextStyle(color: Colors.white70),
          headline2: TextStyle(color: Colors.white70),
        ),
      ),
      home: Material(
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int pessoas = 15;

  void mudaPessoa(int p) {
    if (pessoas + p < 0) return;
    setState(() {
      pessoas += p;
    });
    print(pessoas);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            "images/restaurante.jpg",
            fit: BoxFit.cover,
            color: Colors.black45,
            colorBlendMode: BlendMode.multiply,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                "$pessoas Pessoas",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Container(height: 200),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    mudaPessoa(1);
                  },
                  child: Text(
                    "+1",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                Container(width: 100),
                TextButton(
                  onPressed: () {
                    mudaPessoa(-1);
                  },
                  child: Text(
                    "-1",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
