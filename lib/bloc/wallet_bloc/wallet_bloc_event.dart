import 'package:equatable/equatable.dart';

abstract class WalletEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class WalletEventWalletConnecting extends WalletEvent {}

class WalletEventWalletConnected extends WalletEvent {
  final bool isConnected;
  final String walletAddress;

  WalletEventWalletConnected(
    this.isConnected,
    this.walletAddress,
  );

  @override
  List<Object> get props => [
        isConnected,
        walletAddress,
      ];
}

class WalletEventDisconnected extends WalletEvent {
  final bool isConnected;
  final String walletAddress;

  WalletEventDisconnected(this.isConnected, this.walletAddress);

  @override
  List<Object> get props => [
        isConnected,
        walletAddress
      ];
}
