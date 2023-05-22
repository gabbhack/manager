import 'package:mobx/mobx.dart';
part 'position.g.dart';

class Position = _PositionBase with _$Position;

abstract class _PositionBase with Store {
  @observable
  String? value;
}
