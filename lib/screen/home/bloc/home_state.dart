part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {
  @override
  List<Object> get props => null;
}

class HomeInitial extends HomeState {}

class DataSuccess extends HomeState {}
