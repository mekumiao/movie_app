part of 'update_bloc.dart';

abstract class UpdateEvent extends Equatable {
  const UpdateEvent();

  @override
  List<Object> get props => [];
}

class CheckUpdate extends UpdateEvent {
  const CheckUpdate();
}
