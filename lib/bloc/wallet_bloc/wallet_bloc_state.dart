import 'package:equatable/equatable.dart';

class WalletState extends Equatable {
  final String? walletAddress;
  final bool isLoading;

  const WalletState(
    this.isLoading, {
    this.walletAddress,
  });

  WalletState copyWith({
    String? walletAddress,
    bool? isLoading,
  }) {
    return WalletState(
      false,
      walletAddress: walletAddress ?? this.walletAddress,
    );
  }

  @override
  List<Object?> get props => [
        walletAddress,
      ];
}

class WalletStateConnecting extends WalletState {
  WalletStateConnecting(bool isLoading) : super(isLoading);

  @override
  List<Object?> get props => [isLoading];
}

class WalletStateAddedWallet extends WalletState {
  final String walletAddress;

  WalletStateAddedWallet(this.walletAddress) : super(false);

  @override
  List<Object?> get props => [walletAddress];
}

class WalletStateFailed extends WalletState {
  WalletStateFailed(bool isLoading) : super(isLoading);
  @override
  List<Object?> get props => [isLoading];
}
