import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web3/bloc/home_bloc/home_bloc_event.dart';
import 'package:flutter_web3/bloc/home_bloc/home_bloc_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(HomeState initialState) : super(HomeStateLoading());
}
