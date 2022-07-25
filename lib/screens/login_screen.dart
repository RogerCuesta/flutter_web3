import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web3/bloc/wallet_bloc/wallet_bloc.dart';
import 'package:flutter_web3/bloc/wallet_bloc/wallet_bloc_event.dart';
import 'package:flutter_web3/bloc/wallet_bloc/wallet_bloc_state.dart';
import 'package:flutter_web3/screens/home_screen.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final WalletBloc walletBloc = BlocProvider.of<WalletBloc>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MaterialButton(
                color: Colors.blue,
                onPressed: () {
                  walletBloc.add(WalletEventWalletConnecting());
                },
                child: Text(
                  'Wallet Connect',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
