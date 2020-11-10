import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;

import 'blocs/todoBloc/todoList_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calendar_with_flutter/blocs/todoBloc/bloc.dart';
import 'package:calendar_with_flutter/todo_add.dart';

class Calendar extends StatefulWidget {
  _Calendar createState() => _Calendar();
}

class _Calendar extends State<Calendar> {
  TodoBloc _todoBloc;
  DateTime _currentDate;
  DateTime _currentDate2;
  String _currentMonth;
  DateTime _targetDateTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _todoBloc = BlocProvider.of<TodoBloc>(context);
    _todoBloc.add(TodoPageLoaded());
    _currentDate = DateTime.now();
    _currentDate2 = DateTime.now();
    _currentMonth = DateFormat.yMMM().format(DateTime.now());
    _targetDateTime = DateTime.now();
  }

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );

  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: new Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocListener(
        bloc: _todoBloc,
        listener: (BuildContext context, TodoState state) {},
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("달력",
                style: TextStyle(
                color: Colors.white, fontSize: 20),
            ),
            backgroundColor: Color(0xFF266DAC),
          ),
          body: BlocBuilder(
            bloc: _todoBloc,
            builder: (BuildContext context, TodoState state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[

                  //custom icon without header
                  Container(
                    margin: EdgeInsets.only(
                      top: 16.0,
                      bottom: 16.0,
                      left: 16.0,
                      right: 16.0,
                    ),
                    child: new Row(
                      children: <Widget>[
                        Expanded(
                            child: Text(
                          _currentMonth,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          ),
                        )),
                        FlatButton(
                          child: Text('PREV'),
                          onPressed: () {
                            setState(() {
                              _targetDateTime = DateTime(_targetDateTime.year,
                                  _targetDateTime.month - 1);
                              _currentMonth =
                                  DateFormat.yMMM().format(_targetDateTime);
                            });
                          },
                        ),
                        FlatButton(
                          child: Text('NEXT'),
                          onPressed: () {
                            setState(() {
                              _targetDateTime = DateTime(_targetDateTime.year,
                                  _targetDateTime.month + 1);
                              _currentMonth =
                                  DateFormat.yMMM().format(_targetDateTime);
                            });
                          },
                        )
                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.0),
                    child: new CalendarCarousel<Event>(
                      todayBorderColor: Colors.green,
                      onDayPressed: (DateTime date, List<Event> events) {
                        this.setState(() => _currentDate2 = date);
                        events.forEach((event) => print(event.title));
                      },
                      showOnlyCurrentMonthDate: false,
                      weekendTextStyle: TextStyle(
                        color: Colors.red,
                      ),
                      thisMonthDayBorderColor: Colors.grey,
                      weekFormat: false,
                      //      firstDayOfWeek: 4,
                      markedDatesMap: _markedDateMap,
                      height: 320.0,
                      selectedDateTime: _currentDate2,
                      targetDateTime: _targetDateTime,
                      customGridViewPhysics: NeverScrollableScrollPhysics(),
                      markedDateCustomShapeBorder:
                          CircleBorder(side: BorderSide(color: Colors.yellow)),
                      markedDateCustomTextStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                      showHeader: false,
                      todayTextStyle: TextStyle(
                        color: Colors.black,
                      ),
                      markedDateShowIcon: true,
                      markedDateIconMaxShown: 2,
                      markedDateIconBuilder: (event) {
                        return event.icon;
                      },
                      markedDateMoreShowTotal: true,
                      todayButtonColor: Colors.grey,
                      selectedDayTextStyle: TextStyle(
                        color: Colors.yellow,
                      ),
                      minSelectedDate:
                          _currentDate.subtract(Duration(days: 360)),
                      maxSelectedDate: _currentDate.add(Duration(days: 360)),
                      prevDaysTextStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.pinkAccent,
                      ),
                      inactiveDaysTextStyle: TextStyle(
                        color: Colors.tealAccent,
                        fontSize: 16,
                      ),
                      onCalendarChanged: (DateTime date) {
                        this.setState(() {
                          _targetDateTime = date;
                          _currentMonth =
                              DateFormat.yMMM().format(_targetDateTime);
                        });
                      },
                      onDayLongPressed: (DateTime date) {
                        _todoBloc.setSelectedDate(date);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    BlocProvider.value(
                                        value: _todoBloc, child: TodoAdd())));
                      },
                    ),
                  ),

                  Container(
                    height: MediaQuery.of(context).size.height-500,
                    child: ListView.builder(
                        itemCount: state.todoList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(state.todoList[index].date + " " + state.todoList[index].todo),
                            //listTile을 누르게 되면 해당 list에대한 dialog가 뜨게 된다.
                            onTap: () {
                              _showDialog(state.todoList[index].todo,
                                  state.todoList[index].desc);
                            }
                          );
                        }),
                  ),
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
