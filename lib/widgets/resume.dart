import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:manager/stores/position.dart';
import 'package:manager/stores/skills.dart';
import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

const positions = [
  DropdownMenuItem<String>(
    value: "Бекенд разработчик",
    child: Text("Бекенд разработчик"),
  ),
  DropdownMenuItem<String>(
    value: "Фронтенд разработчик",
    child: Text("Фронтед разработчик"),
  ),
  DropdownMenuItem<String>(
    value: "Аналитик",
    child: Text("Аналитик"),
  )
];

const positionSkills = {
  "Бекенд разработчик": [
    "Python",
    "SQL",
    "Git",
    "PostgreSQL",
    "Docker",
    "docker-compose"
  ]
};

int computeCompatibility(String? position, List<String> skills) {
  if (position == null) {
    return 0;
  }
  final commonElements = Set<String>.from(positionSkills[position]!)
      .intersection(Set.from(skills));
  final numCommonElements = commonElements.length;
  final totalElements =
      Set<String>.from(positionSkills[position]!).union(Set.from(skills));
  final numTotalElements = totalElements.length;
  return ((numCommonElements / numTotalElements) * 100).toInt();
}

final skills = Skills();
final position = Position();
final compatibility = Computed(
  () => computeCompatibility(
    position.value,
    skills.values.toList(),
  ),
);

class Resume extends StatefulWidget {
  const Resume({super.key});

  @override
  State<Resume> createState() => _ResumeState();
}

class _ResumeState extends State<Resume> {
  final _formKey = GlobalKey<FormState>();
  final fioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Менеджмент'),
      ),
      body: Center(
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
                items: positions,
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
