import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web3/screens/login_screen.dart';
import 'package:flutter_web3/services/wallet_connect.dart';

import 'bloc/wallet_bloc/wallet_bloc.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AppView();
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Web3',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider(
          create: (BuildContext context) => WalletBloc(
            walletConnectUtils: WalletConnectUtils(),
          ),
          child: LoginPage(),
        ));
  }
}
