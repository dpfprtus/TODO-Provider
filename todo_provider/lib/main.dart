import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/todos_page.dart';
import 'providers/providers.dart';

void main() {
  runApp(const MyApp());
  print('시작');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TodoFilter>(
          create: (context) => TodoFilter(),
        ),
        ChangeNotifierProvider<TodoSearch>(
          create: (context) => TodoSearch(),
        ),
        ChangeNotifierProvider<TodoList>(
          create: (context) => TodoList(),
        ),
        ProxyProvider<TodoList, ActiveTodoCount>(
          create: (context) => ActiveTodoCount(
              intialActiveTodoCount:
                  context.read<TodoList>().state.todos.length),
          update: (BuildContext context, TodoList todoList,
                  ActiveTodoCount? activeTodoCount) =>
              activeTodoCount!..update(todoList),
        ),
        ChangeNotifierProxyProvider3<TodoFilter, TodoSearch, TodoList,
            FilteredTodos>(
          create: (context) => FilteredTodos(
            initialFilteredTodos: context.read<TodoList>().state.todos,
          ),
          update: (
            BuildContext context,
            TodoFilter todoFilter,
            TodoSearch todoSearch,
            TodoList todoList,
            FilteredTodos? filteredTodos,
          ) =>
              filteredTodos!..update(todoFilter, todoSearch, todoList),
        )
      ],
      child: MaterialApp(
        title: 'TODOS',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TodosPage(),
      ),
    );
  }
}
