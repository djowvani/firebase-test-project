import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final dbRef = FirebaseDatabase.instance.reference().child("section");
  List<Map<dynamic, dynamic>> lists = [];

  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       appBar: AppBar(
  //         title: Text('Menoo Mobile App'),
  //       ),
  //       body: FutureBuilder(
  //           future: dbRef.once(),
  //           builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
  //             if (snapshot.hasData) {
  //               Map<dynamic, dynamic> values = snapshot.data!.value;
  //               values.forEach((key, values) {
  //                 lists.add(values);
  //               });
  //               return new ListView.builder(
  //                   shrinkWrap: true,
  //                   itemCount: lists.length,
  //                   itemBuilder: (BuildContext context, int index) {
  //                     return Card(
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: <Widget>[
  //                           Text("Name: " + lists[index]["name"]),
  //                           // Text("Age: " + lists[index]["age"]),
  //                           // Text("Type: " + lists[index]["type"]),
  //                         ],
  //                       ),
  //                     );
  //                   });
  //             }
  //             return CircularProgressIndicator();
  //           }));
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: dbRef.once(),
        builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
          // Seção problemática, descomentar esse código responsável por buscar dados do Realtime Database resulta em "type 'Null' is not a subtype of type 'Map<dynamic, dynamic>'"

          // if (snapshot.hasData) {
          //   Map<dynamic, dynamic> values = snapshot.data!.value;
          //   values.forEach((key, values) {
          //     lists.add(values);
          //   });
          //   return new ListView.builder(
          //       shrinkWrap: true,
          //       itemCount: lists.length,
          //       itemBuilder: (BuildContext context, int index) {
          //         return Card(
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: <Widget>[
          //               Text("Name: " + lists[index]["name"]),
          //               // Text("Age: " + lists[index]["age"]),
          //               // Text("Type: " + lists[index]["type"]),
          //             ],
          //           ),
          //         );
          //       });
          // }

          if (snapshot.hasError) {
            print ('You have an error! ${snapshot.error.toString()}');
            return Text('Something went wrong!');
          } else if (snapshot.hasData) {
            return MyHomePage(title: 'Menoo Mobile App');
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      )
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
  int _counter = 0;

  // Na integração com o Realtime Database, enquanto a busca pelos dados resultou em um erro de tipagem que não foi possível identificarmos com precisão o motivo,
  // nesta seção conseguimos inserir um dado no banco sem problemas
  void _incrementCounter() {
    DatabaseReference _testRef = FirebaseDatabase.instance.reference().child("test");
    _testRef.set("Hello world ${Random().nextInt(100)}");

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
