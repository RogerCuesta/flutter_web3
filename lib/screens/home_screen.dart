import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web3/bloc/home_bloc/home_bloc.dart';
import 'package:flutter_web3/bloc/home_bloc/home_bloc_event.dart';
import 'package:flutter_web3/bloc/home_bloc/home_bloc_state.dart';
import 'package:flutter_web3/services/disperse_functions.dart';

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
      body: BlocProvider(
        create: (_) => HomeBloc(),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MaterialButton(
                      color: Colors.blue,
                      onPressed: () {
                        context.read<HomeBloc>().add(HomeEventWalletConnect());
                      },
                      child: Text(
                        'Wallet Connect',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
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
                    state.isLoading
                        ? CircularProgressIndicator(
                            color: Colors.blue,
                          )
                        : MaterialButton(
                            color: Colors.blue,
                            onPressed: () {
                              context.read<HomeBloc>().add(
                                  HomeEventGetBalance(userAddressText!.text));
                            },
                            child: Text(
                              'Check',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                    state.balance != null
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Text(
                              state.balance.toString() + ' UNI',
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
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

String formatBalance(BigInt number) {
  String numberShow;

  numberShow = (number.toInt() / pow(10, 18)).toString();

  return numberShow;
}
