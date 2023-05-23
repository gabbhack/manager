import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:manager/repositories/companies.dart';
import 'package:manager/stores/position.dart';
import 'package:manager/stores/skills.dart';
import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

final companies = loadCompanies();

int computeCompatibility(
  String company,
  String? position,
  List<String> skills,
) {
  if (position == null) {
    return 0;
  }
  final foundCompany =
      companies.firstWhere((element) => element.name == company);
  final foundPosition =
      foundCompany.positions.firstWhere((element) => element.name == position);
  final commonElements =
      Set<String>.from(foundPosition.skills).intersection(Set.from(skills));
  return commonElements.length * 100 ~/ foundPosition.skills.length;
}

class Resume extends StatefulWidget {
  final String company;
  const Resume({super.key, required this.company});

  @override
  State<Resume> createState() => _ResumeState();
}

class _ResumeState extends State<Resume> {
  final _formKey = GlobalKey<FormState>();
  final fioController = TextEditingController();
  final skills = Skills();
  final position = Position();

  @override
  Widget build(BuildContext context) {
    final compatibility = Computed(
      () => computeCompatibility(
        widget.company,
        position.value,
        skills.values.toList(),
      ),
    );
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.3,
            child: Form(
              key: _formKey,
              child: TextFormField(
                controller: fioController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите текст';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "ФИО",
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Observer(
            builder: (_) => Wrap(
              spacing: 10,
              children: [
                ...skills.values
                    .mapIndexed<ElevatedButton>(
                      (index, e) => ElevatedButton(
                        onPressed: null,
                        onLongPress: () => skills.deleteSkill(index),
                        child: Text(e),
                      ),
                    )
                    .toList(),
                ElevatedButton(
                  onPressed: () => _dialogBuilder(context),
                  child: const Text('Добавить скилл'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          Observer(
            builder: (_) => DropdownButton<String>(
              hint: const Text("Выбрать"),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              underline: Container(),
              value: position.value,
              items: companies
                  .firstWhere((element) => element.name == widget.company)
                  .positions
                  .map(
                    (e) => DropdownMenuItem(
                      value: e.name,
                      child: Text(e.name),
                    ),
                  )
                  .toList(),
              onChanged: (value) => position.value = value,
              alignment: AlignmentDirectional.topCenter,
              focusColor: Colors.transparent,
            ),
          ),
          const SizedBox(height: 16.0),
          Observer(
            builder: (_) => Text(
              "${compatibility.value}%",
              style: const TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final skillController = TextEditingController();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Добавить новый скилл'),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: skillController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Введите текст';
                }
                return null;
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Добавить'),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  skills.addSkill(skillController.text);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
