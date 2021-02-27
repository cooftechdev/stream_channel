import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial());

  Dio _dio = Dio();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    yield HomeInitial();
    if (event is GetData) {
      yield* getData();
    }
  }

  Stream<HomeState> getData() async* {
    // await Future.delayed(Duration(seconds: 1));
    // final data = await _dio.get('https://google.com.vn');
    // print(data.data.toString().length);
    yield DataSuccess();
  }
}
