import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web3/bloc/home_bloc/home_bloc.dart';
import 'package:flutter_web3/bloc/home_bloc/home_bloc_state.dart';
import 'package:flutter_web3/bloc/wallet_bloc/wallet_bloc.dart';
import 'package:flutter_web3/services/eth_utils.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  EthereumUtils ethUtils = EthereumUtils();
  TextEditingController? userAddressText;

  @override
  void initState() {
    userAddressText = TextEditingController();
    ethUtils.initialSetup();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final WalletBloc walletBloc = BlocProvider.of<WalletBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(walletBloc.state.walletAddress),
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
                            onPressed: () {},
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
