// ignore_for_file: public_member_api_docs

import 'package:broadcast_bloc/broadcast_bloc.dart';
import 'package:dart_frog/dart_frog.dart';

class CounterCubit extends BroadcastCubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);

  void decrement() => emit(state - 1);
}

final _counter = CounterCubit();
final counterProvider = provider<CounterCubit>((_) => _counter);
