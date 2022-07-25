import 'package:equatable/equatable.dart';

class WalletState extends Equatable {
  final String walletAddress;
  final bool isConnected;

  const WalletState({
    required this.isConnected,
    required this.walletAddress,
  });

  factory WalletState.initial() => WalletState(
        isConnected: false,
        walletAddress: '',
      );

  @override
  List<Object?> get props => [
        walletAddress,
        isConnected,
      ];
}

class WalletStateConnecting extends WalletState {
  WalletStateConnecting()
      : super(
          isConnected: false,
          walletAddress: '',
        );

  @override
  List<Object?> get props => [];
}

class WalletStateConnected extends WalletState {
  final String walletAddress;

  WalletStateConnected(this.walletAddress)
      : super(
          isConnected: true,
          walletAddress: walletAddress,
        );

  @override
  List<Object?> get props => [walletAddress];
}

class WalletStateFailed extends WalletState {
  WalletStateFailed(bool isConnected)
      : super(
          isConnected: isConnected,
          walletAddress: '',
        );
  @override
  List<Object?> get props => [isConnected];
}
