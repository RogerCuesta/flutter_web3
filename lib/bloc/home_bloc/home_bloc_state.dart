import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final String? walletAddress;
  final double? balance;
  final bool isLoading;

  const HomeState(
    this.isLoading, {
    this.walletAddress,
    this.balance,
  });

  HomeState copyWith({
    String? walletAddress,
    double? balance,
    bool? isLoading,
  }) {
    return HomeState(
      false,
      walletAddress: walletAddress ?? this.walletAddress,
      balance: balance ?? this.balance,
    );
  }

  @override
  List<Object?> get props => [
        walletAddress,
        balance,
      ];
}

class HomeStateLoading extends HomeState {
  HomeStateLoading(bool isLoading) : super(isLoading);

  @override
  List<Object?> get props => [isLoading];
}

class HomeStateAddWallet extends HomeState {
  final String walletAddress;

  HomeStateAddWallet(this.walletAddress) : super(false);

  @override
  List<Object?> get props => [walletAddress];
}

class HomeStateSucceeded extends HomeState {
  final double balance;
  HomeStateSucceeded(this.balance) : super(false);

  @override
  List<Object?> get props => [balance];
}

class HomeStateFailed extends HomeState {
  HomeStateFailed(bool isLoading) : super(isLoading);
}
