import 'package:mobx/mobx.dart';
part 'skills.g.dart';

class Skills = _SkillsBase with _$Skills;

abstract class _SkillsBase with Store {
  final ObservableList<String> values = ObservableList<String>();

  @action
  void addSkill(String skill) {
    values.add(skill);
  }

  @action
  void deleteSkill(int index) {
    values.removeAt(index);
  }
}
