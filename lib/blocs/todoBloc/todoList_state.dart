import 'package:calendar_with_flutter/blocs/models/todo_model.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

class TodoState {
  final List<Todo> todoList;
  final String date;

  TodoState({
    @required this.todoList,
    @required this.date,
  });

  factory TodoState.empty() {
    return TodoState(
      todoList: [
      ],
      date: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
    );
  }

  TodoState update({
    List<Todo> todoList,
    String date,
  }) {
    return copyWith(
      todoList: todoList,
      date: date,
    );
  }

  TodoState copyWith({
    List<Todo> todoList,
    String date,
  }) {
    return TodoState(
      todoList: todoList ?? this.todoList,
      date: date ?? this.date,
    );
  }
}