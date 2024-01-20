// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:todo_provider/models/todo_model.dart';

class TodoFilterState extends Equatable {
  final Filter filter;

  TodoFilterState({required this.filter});

  //factory 생성자를 사용하여 초기 상태값이 어떤 것임을 확실히 알 수 있다.
  factory TodoFilterState.initial() {
    return TodoFilterState(filter: Filter.all);
  }

  TodoFilterState copyWith({
    Filter? filter,
  }) {
    return TodoFilterState(
      filter: filter ?? this.filter,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [filter];

  @override
  bool get stringify => true;
}

class TodoFilter with ChangeNotifier {
  TodoFilterState _state = TodoFilterState.initial();
  TodoFilterState get state => _state;

  void changeFilter(Filter newFilter) {
    //기존값을 mutate하지 않고 새로운 값을 만든다.
    _state = _state.copyWith(filter: newFilter);
    notifyListeners();
  }
}
