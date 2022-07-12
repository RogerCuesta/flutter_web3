import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web3/bloc/wallet_bloc/wallet_bloc_event.dart';
import 'package:flutter_web3/bloc/wallet_bloc/wallet_bloc_state.dart';
import 'package:flutter_web3/services/disperse_functions.dart';
import 'package:flutter_web3/services/wallet_connect.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web3dart/web3dart.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final EthereumUtils _ethereumUtils = EthereumUtils();
  final WalletConnectUtils _walletConnectUtils = WalletConnectUtils();

  WalletBloc() : super(WalletState(false)) {
    /* on<HomeEventGetWallet>(
      _onHomeEventGetWallet,
    );*/
    on<WalletEventWalletConnect>(
      _onHomeEventWalletConnect,
    );
  }

  _onHomeEventWalletConnect(
    WalletEventWalletConnect event,
    Emitter<WalletState> emit,
  ) async =>
      await walletConnect(
        emit,
        event,
      );

  Future<void> walletConnect(
    Emitter<WalletState> emit,
    WalletEventWalletConnect event,
  ) async {
    await _walletConnectUtils.connectWallet();
  }
}
