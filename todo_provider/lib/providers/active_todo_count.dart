// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_provider/models/todo_model.dart';
import 'package:todo_provider/providers/todo_list.dart';

class ActiveTodoCountState extends Equatable {
  final int activeTodoCount;

  ActiveTodoCountState({required this.activeTodoCount});

  factory ActiveTodoCountState.initial() {
    return ActiveTodoCountState(activeTodoCount: 0);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [activeTodoCount];

  ActiveTodoCountState copyWith({
    int? activeTodoCount,
  }) {
    return ActiveTodoCountState(
      activeTodoCount: activeTodoCount ?? this.activeTodoCount,
    );
  }

  @override
  bool get stringify => true;
}

class ActiveTodoCount with ChangeNotifier {
  late ActiveTodoCountState _state;
  final int intialActiveTodoCount;

  ActiveTodoCount({required this.intialActiveTodoCount}) {
    print('initialActiveTodoCount: $intialActiveTodoCount');
    _state = ActiveTodoCountState(activeTodoCount: intialActiveTodoCount);
  }

  ActiveTodoCountState get state => _state;

  //Proxy Provider 사용해야함, completed되지 않은 todo의 갯수를 계산
  void update(TodoList todoList) {
    print(todoList.state);
    final int newActiveTodoCount = todoList.state.todos
        .where((Todo todo) => !todo.completed)
        .toList()
        .length;
    _state = _state.copyWith(activeTodoCount: newActiveTodoCount);
    print(state);
    notifyListeners();
  }
}
