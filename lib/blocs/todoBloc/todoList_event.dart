import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class TodoListEvent extends Equatable {
  TodoListEvent([List props = const []]) : super(props);
}

class TodoPageLoaded extends TodoListEvent {
  @override
  String toString() {
    // TODO: implement toString
    return "TodoPageLoaded";
  }
}

class TodoListCheck extends TodoListEvent {
  final int index;

  TodoListCheck({@required this.index});

  @override
  String toString() {
    // TODO: implement toString
    return "TodoListCheck";
  }
}

//여기 밑의 두가지가 전의 코드에서 새로이 추가된 두개의 이벤트이다.
// AddDateChagned의 경우 달력에서 날짜를 설정 하게 될 경우 일어나는 상황을 설정한것이다.
class AddDateChanged extends TodoListEvent {
  final String date;

  AddDateChanged({@required this.date});

  @override
  String toString() {
    return "AddDateChanged {date : $date}";
  }
}
// TodoAddPressed의 경우 새로운 일정 추가하기 버튼이 눌렸을때 일어날 상황을 설정한 것이다.
// 여기서는 todo 의 id, todo 의 title, todo의 설명, 날짜를 받아 오게 된다.
class TodoAddPressed extends TodoListEvent {
  final int id;
  final String todo;
  final String date;
  final String desc;

  TodoAddPressed({
    @required this.id,
    @required this.todo,
    @required this.date,
    @required this.desc,
  });

  @override
  String toString() {
    // TODO: implement toString
    return "TodoListCheck {id : $id, todo : $todo, datd : $date, desc : $desc}";
  }
}