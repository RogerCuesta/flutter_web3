import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web3/bloc/wallet_bloc/wallet_bloc_event.dart';
import 'package:flutter_web3/bloc/wallet_bloc/wallet_bloc_state.dart';
import 'package:flutter_web3/services/eth_utils.dart';
import 'package:flutter_web3/services/wallet_connect.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:walletconnect_secure_storage/walletconnect_secure_storage.dart';
import 'package:web3dart/web3dart.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletConnectUtils walletConnectUtils;

  WalletBloc({required this.walletConnectUtils})
      : super(WalletState(
          isConnected: false,
          walletAddress: '',
        )) {
    on<WalletEventWalletConnecting>(
      _onHomeEventWalletConnecting,
    );
    on<WalletEventWalletConnected>(
      _onHomeEventWalletConnected,
    );
  }

  _onHomeEventWalletConnecting(
    WalletEventWalletConnecting event,
    Emitter<WalletState> emit,
  ) async =>
      await walletConnect(
        emit,
        event,
      );

  _onHomeEventWalletConnected(
    WalletEventWalletConnected event,
    Emitter<WalletState> emit,
  ) async =>
      await walletConnected(
        emit,
        event,
      );

  Future<void> walletConnect(
    Emitter<WalletState> emit,
    WalletEventWalletConnecting event,
  ) async {
    try {
      emit(
        WalletStateConnecting(),
      );
      await walletConnectUtils.connectWallet();
      final sessionStorage = WalletConnectSecureStorage();
      WalletConnectSession? session = await sessionStorage.getSession();
      if (session != null) {
        emit(WalletStateConnected(session.accounts[0]));
      } else {
        emit(
          WalletStateFailed(false),
        );
      }
    } catch (e) {
      print(e);
      emit(
        WalletStateFailed(false),
      );
    }
  }

  Future<void> walletConnected(
    Emitter<WalletState> emit,
    WalletEventWalletConnected event,
  ) async {
    emit(WalletStateConnected(state.walletAddress));
  }
}
