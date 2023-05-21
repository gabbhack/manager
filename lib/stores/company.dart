import 'package:mobx/mobx.dart';

part 'company.g.dart';

class Company = _Company with _$Company;

abstract class _Company with Store {
  @observable
  String? value;
}
