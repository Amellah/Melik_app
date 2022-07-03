import 'package:bloc/bloc.dart';

//Events

abstract class CounterEvent{}

class IncrementCounterEvent extends CounterEvent{}

class DecrementCounterEvent extends CounterEvent{}

// States
abstract class CounterState {
  final int counter;

  const CounterState({
    required this.counter,
  });
}
class CounterSuccessState extends CounterState{
  CounterSuccessState({required int counter}) : super(counter: counter);
}

class CounterErrorState extends CounterState {
  final String errorMessage;

  CounterErrorState({required int counter, required this.errorMessage}) : super(counter: counter);
}

class CounterinitialState extends CounterState {
  CounterinitialState() : super(counter: 0);
}

// Bloc

class CounterBloc extends Bloc<CounterEvent, CounterState>{
  CounterBloc() : super(CounterinitialState()){
    on((IncrementCounterEvent event, emit) {
      if(state.counter<10){
        int counterValue=state.counter+1;
        emit(CounterSuccessState(counter: counterValue));
      } else {
        emit (CounterErrorState(
            counter: state.counter,
            errorMessage: "Counter value can not be more than 10"
        ));
      }
    });
    on((DecrementCounterEvent event, emit) {
      if(state.counter>0){
        int counterValue=state.counter-1;
        emit(CounterSuccessState(counter: counterValue));
      } else {
        emit (CounterErrorState(
            counter: state.counter,
            errorMessage: "Counter value can not be less than 0"
        ));
      }
    });
  }
}


