import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeEventGetWallet extends HomeEvent {
  final String walletAddress;

  HomeEventGetWallet(this.walletAddress);

  @override
  List<Object> get props => [
        walletAddress,
      ];
}

class HomeEventGetBalance extends HomeEvent {
  final String walletAddress;

  HomeEventGetBalance(this.walletAddress);

  @override
  List<Object> get props => [
        walletAddress,
      ];
}

class HomeEventWalletConnect extends HomeEvent {}

class HomeEventLoading extends HomeEvent {}

class HomeEventGetBalanceError extends HomeEvent {}
