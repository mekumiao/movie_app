import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'my_event.dart';
part 'my_state.dart';

class MyBloc extends Bloc<MyEvent, MyState> {
  MyBloc() : super(MyInitial()) {
    on<MyEvent>(_onMyEvent);
  }

  void _onMyEvent(
    MyEvent event,
    Emitter<MyState> emit,
  ) {
    print('_onMyEvent');
  }
}
