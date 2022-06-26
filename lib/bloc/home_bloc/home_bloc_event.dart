import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeEventGetBalance extends HomeEvent {
  final double balance;

  HomeEventGetBalance(this.balance);

  @override
  List<Object> get props => [balance];
}

class HomeEventLoading extends HomeEvent {}

class HomeEventGetBalanceError extends HomeEvent {}
