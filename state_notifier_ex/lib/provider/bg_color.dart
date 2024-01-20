// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';

class BgColorsState extends Equatable {
  final Color color;

  BgColorsState({required this.color});

  @override
  // TODO: implement props
  List<Object?> get props => [color];

  BgColorsState copyWith({
    Color? color,
  }) {
    return BgColorsState(
      color: color ?? this.color,
    );
  }

  @override
  bool get stringify => true;
}

class BgColor extends StateNotifier<BgColorsState> {
  BgColor()
      : super(
          BgColorsState(color: Colors.blue),
        );

  //state를 정의하지 않았는데도 사용가능하다.
  //notifierListener 호출x
  void changeColor() {
    if (state.color == Colors.blue) {
      state = state.copyWith(color: Colors.black);
    } else if (state.color == Colors.black) {
      state = state.copyWith(color: Colors.red);
    } else {
      state = state.copyWith(color: Colors.blue);
    }
  }
}
