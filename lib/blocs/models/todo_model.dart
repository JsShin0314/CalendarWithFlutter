import 'package:meta/meta.dart';
//해당 클래스를 통하여 모델을 선언하여 주고 사용할수 있도록 한다.
class Todo {
  final int id; //todo마다의 고유한 ID
  final String todo;//내가 해야할것
  final String desc;//내가 할것에 대한 부가적인 설명을 적어두기 위한 작업
  final String date;//해당 todo의 날짜

  Todo({
    @required this.id,
    @required this.todo,
    @required this.desc,
    @required this.date,
  });
}