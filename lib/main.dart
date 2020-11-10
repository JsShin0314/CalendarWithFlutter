import 'package:flutter/material.dart';
import 'package:calendar_with_flutter/todo_add.dart';
import 'package:calendar_with_flutter/todo_list.dart';
import 'package:calendar_with_flutter/todo_calendar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'blocs/todoBloc/bloc.dart';

void main() => runApp(CalendarWithFlutterApp());

class CalendarWithFlutterApp extends StatefulWidget {
  @override
  _CalendarWithFlutterAppState createState() => _CalendarWithFlutterAppState();
}

class _CalendarWithFlutterAppState extends State<CalendarWithFlutterApp> {
  // ignore: close_sinks
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //그냥 BlocProvider로 사용을 해주어도 되지만 나중에 기능 추가를 위하여 미리 MultiBlocProvider로 선언을 하였다.
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoBloc>(
          create: (BuildContext context) => TodoBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Todo',
        //해당 앱의 전체적인 테마를 설정해주게 될것이다.
        theme: ThemeData(
            primaryColor: Color(0xFFF8F8F8),
            backgroundColor: Color(0xFFF8F8F8),
            scaffoldBackgroundColor: Color(0xFFF8F8F8),
            accentColor: Color(0xFF3A5EFF)),
        //가장 먼저 실행이 될 부분이 무엇인지를 정해주는 부분으로 대게 splash페이지나 login 페이지로 설정을 한다.
        home: Calendar(),
        //Navigator.of(context).pushNamed(route name);형식으로 써주기 위해 선언을 해주는 부분
        routes: {
          "/todoCalendar": (BuildContext context) => Calendar(),
          "/todoAdd": (BuildContext context) => TodoAdd(),
        },
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale('ko', 'KO'),
        ],
      ),
    );
  }
}