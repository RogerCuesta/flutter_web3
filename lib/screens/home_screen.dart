import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_web3/utils/constants.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late Client httpClient;
  Web3Client? web3Client;
  TextEditingController? userAddressText;

  @override
  void initState() {
    userAddressText = TextEditingController();
    httpClient = Client();
    web3Client = Web3Client(infuraKovanUrl, httpClient);

    super.initState();
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
              'Get your UNI balance:',
            ),
            TextFormField(
              controller: userAddressText,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your wallet',
              ),
            ),
            MaterialButton(
              onPressed: () {},
              child: Text('Check'),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
