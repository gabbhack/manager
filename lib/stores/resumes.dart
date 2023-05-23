import 'package:manager/widgets/resume.dart';
import 'package:mobx/mobx.dart';
part 'resumes.g.dart';

class Resumes = _ResumesBase with _$Resumes;

abstract class _ResumesBase with Store {
  final ObservableList<Resume> values = ObservableList<Resume>();

  @action
  void addResume(Resume resume) {
    values.add(resume);
  }
}
