part of 'my_bloc.dart';

abstract class MyState extends Equatable {
  const MyState();
  
  @override
  List<Object> get props => [];
}

class MyInitial extends MyState {}
