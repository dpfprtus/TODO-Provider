// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'package:state_notifier_ex/provider/bg_color.dart';

class CounterState extends Equatable {
  final int counter;

  CounterState({required this.counter});

  @override
  // TODO: implement props
  List<Object?> get props => [counter];

  CounterState copyWith({
    int? counter,
  }) {
    return CounterState(
      counter: counter ?? this.counter,
    );
  }

  @override
  bool get stringify => true;
}

class Counter extends StateNotifier<CounterState> with LocatorMixin {
  Counter() : super(CounterState(counter: 0));

  void increment() {
    print(read<BgColor>().state);
    Color currentColor = read<BgColor>().state.color;
    if (currentColor == Colors.black) {
      state = state.copyWith(counter: state.counter + 10);
    } else if (currentColor == Colors.red) {
      state = state.copyWith(counter: state.counter - 10);
    } else {
      state = state.copyWith(counter: state.counter + 1);
    }

    @override
    void update(Locator watch) {
      print('in Counter StateNotifier: ${watch<BgColorsState>().color}');
      print('in Counter StateNotifier: ${watch<BgColor>().state.color}');
      super.update(watch);
    }
  }
}
