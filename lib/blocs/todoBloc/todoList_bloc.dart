import 'package:bloc/bloc.dart';
import 'package:calendar_with_flutter/blocs/todoBloc/bloc.dart';
import 'package:calendar_with_flutter/blocs/models/todo_model.dart';

class TodoBloc extends Bloc<TodoListEvent, TodoState> {
  //달력에서 선택한 날짜
  DateTime selectedDateTime;

  @override
  // TODO: implement initialState
  TodoState get initialState => TodoState.empty();

  @override
  Stream<TodoState> mapEventToState(TodoListEvent event) async* {
    // TODO: implement mapEventToState
    if (event is TodoPageLoaded) {
      yield* _mapTodoPageLoadedToState();
    } else if (event is TodoListCheck) {
      yield* _mapTodoListCheckToState(event.index);
    }
    //새로이 추가가 되는 부분입니다.
    else if (event is AddDateChanged) {
      yield* _mapAddDateChangedToState(event.date);
    } else if (event is TodoAddPressed) {
      yield* _mapTodoAddPressedToState(
          event.id, event.todo, event.date, event.desc);
    }
  }

  Stream<TodoState> _mapTodoPageLoadedToState() async* {
    yield state.update(todoList: state.todoList);
  }

  Stream<TodoState> _mapTodoListCheckToState(int index) async* {
    Todo currentTodo = Todo(
        id: state.todoList[index].id,
        todo: state.todoList[index].todo,
        date: state.todoList[index].date);

    List<Todo> cTodoList = state.todoList;
    cTodoList[index] = currentTodo;
    yield state.update(todoList: cTodoList);
  }

  //date를 넘겨 받아 바로 state를 업데이트를 해주면 끝이난다.
  Stream<TodoState> _mapAddDateChangedToState(String date) async* {
    yield state.update(date: date);
  }

  //추가 버튼을 눌렀을 때의 경우 Todo model로 새로이 만들어 주어야 하고
  //그것을 원래 존재하는 리스트에 넣어준다.
  //그리고 갱신된 리스트로 state를 업데이트 시켜준다.
  Stream<TodoState> _mapTodoAddPressedToState(
      int id, String todo, String date, String desc) async* {
    Todo newTodo =
    Todo(id: id, todo: todo, date: date, desc: desc);

    List<Todo> currentTodo = state.todoList;
    currentTodo.add(newTodo);

    yield state.update(todoList: currentTodo);
  }

  void setSelectedDate(DateTime date) {
    selectedDateTime = date;
  }
  DateTime getSelectedDate() {
    return selectedDateTime;
  }
}