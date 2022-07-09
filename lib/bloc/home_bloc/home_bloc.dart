import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web3/bloc/home_bloc/home_bloc_event.dart';
import 'package:flutter_web3/bloc/home_bloc/home_bloc_state.dart';
import 'package:flutter_web3/services/disperse_functions.dart';
import 'package:web3dart/web3dart.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final EthereumUtils _ethereumUtils = EthereumUtils();

  HomeBloc() : super(HomeState(false)) {
    /* on<HomeEventGetWallet>(
      _onHomeEventGetWallet,
    );*/
    on<HomeEventGetBalance>(
      _onHomeEventGetBalance,
    );
    on<HomeEventWalletConnect>(
      _onHomeEventWalletConnect,
    );
  }

  _onHomeEventWalletConnect(
    HomeEventWalletConnect event,
    Emitter<HomeState> emit,
  ) async =>
      await walletConnect(
        emit,
        event,
      );

  _onHomeEventGetBalance(
    HomeEventGetBalance event,
    Emitter<HomeState> emit,
  ) async =>
      await checkBalance(
        emit,
        event,
      );

  Future<void> checkBalance(
    Emitter<HomeState> emit,
    HomeEventGetBalance event,
  ) async {
    _ethereumUtils.initialSetup();
    try {
      emit(HomeStateLoading(true));
      await _ethereumUtils.getBalance(event.walletAddress).then((data) {
        final balanceAmount = (data.toInt() / pow(10, 18));
        //emit(state.copyWith(balance: balanceAmount, walletAddress: ''));
        emit(HomeStateSucceeded(balanceAmount));
      });
    } catch (e) {
      print(e.toString());
      emit(HomeStateFailed(false));
    }
  }

  Future<void> walletConnect(
    Emitter<HomeState> emit,
    HomeEventWalletConnect event,
  ) async {
    _ethereumUtils.walletConnectSetup();
    try {
      await EthereumUtils()
          .connector
          .approveSession(chainId: 4160, accounts: ['0x4292...931B3']);
    } catch (e) {
      print(e.toString());
      emit(HomeStateFailed(false));
    }
  }
}
