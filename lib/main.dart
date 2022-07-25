import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web3/bloc/wallet_bloc/wallet_bloc.dart';
import 'package:flutter_web3/bloc/wallet_bloc/wallet_bloc_state.dart';
import 'package:flutter_web3/screens/home_screen.dart';
import 'package:flutter_web3/screens/login_screen.dart';
import 'package:flutter_web3/services/wallet_connect.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WalletBloc>(
          create: (_) => WalletBloc(
            walletConnectUtils: WalletConnectUtils(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Web3',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocBuilder<WalletBloc, WalletState>(
          builder: (context, state) {
            if(state.isConnected){
              return HomePage();
            } else{
              return LoginPage();
            } 
            
          },
        ),
      ),
    );
  }
}
