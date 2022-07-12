import 'package:equatable/equatable.dart';

abstract class WalletEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class WalletEventGetWallet extends WalletEvent {
  final String walletAddress;

  WalletEventGetWallet(this.walletAddress);

  @override
  List<Object> get props => [
        walletAddress,
      ];
}

/*class WalletEventGetBalance extends WalletEvent {
  final String walletAddress;

  HomeEventGetBalance(this.walletAddress);

  @override
  List<Object> get props => [
        walletAddress,
      ];
}*/

class WalletEventWalletConnect extends WalletEvent {}

class WalletEventConnecting extends WalletEvent {}