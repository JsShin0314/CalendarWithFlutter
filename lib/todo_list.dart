  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:calendar_with_flutter/blocs/todoBloc/bloc.dart';
  import 'package:calendar_with_flutter/todo_add.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';

  class TodoList extends StatefulWidget {
    _TodoList createState() => _TodoList();
  }

  class _TodoList extends State<TodoList> {
    TodoBloc _todoBloc;
    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      _todoBloc = BlocProvider.of<TodoBloc>(context);
      _todoBloc.add(TodoPageLoaded());
    }

    @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return BlocListener(
          bloc: _todoBloc,
          listener: (BuildContext context, TodoState state) {},
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("Todo List"),
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  BlocProvider.value(
                                      value: _todoBloc, child: TodoAdd())));
                    })
              ],
            ),
            body: BlocBuilder(
              bloc: _todoBloc,
              builder: (BuildContext context, TodoState state) {
                return Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height / 2,
                      child: ListView.builder(
                          itemCount: state.todoList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(state.todoList[index].todo),
                              //listTile을 누르게 되면 해당 list에대한 dialog가 뜨게 된다.
                              onTap: () {
                                _showDialog(state.todoList[index].todo,
                                    state.todoList[index].desc);
                              },
                              //앞부분에 체크박수를 두어 체크박스업룰 누르게 되면 해당 index의 것이 체크가 될수 있도록 해주는 작
                            );
                          }),
                    )
                  ],
                );
              },
            ),
          ));
    }

    //눌렀을때 부가적인 설명에 대한 dialog가 나올수 있도록 하기 위한 작업이다.
    //일단은 해야할것의 제목, 부가적인 설명을 받아 다이얼로그 페이지에 보일수 있도록 해두었다.
    void _showDialog(String title, String description) async {
      showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: description.isNotEmpty
                ? Text(description)
                : Text("부가적인 설명을 적지 않았습니다."),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context, "OK");
                },
              ),
            ],
          );
        },
      );
    }
  }