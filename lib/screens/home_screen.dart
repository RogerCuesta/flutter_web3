import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web3/bloc/home_bloc/home_bloc.dart';
import 'package:flutter_web3/bloc/home_bloc/home_bloc_state.dart';
import 'package:flutter_web3/services/uni_functions.dart';
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
  EthereumUtils ethUtils = EthereumUtils();
  TextEditingController? userAddressText;

  var _myData;

  @override
  void initState() {
    userAddressText = TextEditingController();
    ethUtils.initialSetup();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: HomeBloc(
          HomeStateLoading(),
        ),
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Get your UNI balance:',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: TextFormField(
                      controller: userAddressText,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(4.0),
                          ),
                        ),
                        labelText: 'Enter your wallet',
                      ),
                    ),
                  ),
                  MaterialButton(
                    color: Colors.blue,
                    onPressed: () {
                      setState(() {
                        if (userAddressText != null) {
                          ethUtils
                              .getBalance(userAddressText!.text)
                              .then((data) {
                            _myData = data;
                            setState(() {});
                          });
                        } else {}
                      });
                    },
                    child: Text(
                      'Check',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  _myData != null
                      ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Text(
                            formatBalance(_myData) + ' UNI',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                      )
                      : Text('')
                ],
              ),
            ),
          );
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

String formatBalance(BigInt number) {
  String numberShow;

  numberShow = (number.toInt() / pow(10, 18)).toString();

  return numberShow;
}
