import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeStateLoading extends HomeState {}

class HomeStateSucceeded extends HomeState {
  final double balance;
  HomeStateSucceeded(this.balance);

  @override
  List<Object?> get props => [balance];
}

class HomeStateFailed extends HomeState {}
