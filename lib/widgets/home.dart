import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:manager/stores/company.dart';

final company = Company();

const companies = [
  DropdownMenuItem<String>(
    value: "Сбер",
    child: Text("Сбер"),
  ),
  DropdownMenuItem<String>(
    value: "Уртиси",
    child: Text("Уртиси"),
  ),
  DropdownMenuItem<String>(
    value: "РосАтом",
    child: Text("РосАтом"),
  )
];

class Home extends StatelessWidget {
  const Home({super.key});

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
            const Text(
              "Выбор компании",
              style: TextStyle(
                fontSize: 40,
                color: Colors.black,
              ),
            ),
            Observer(
              builder: (_) => DropdownButton<String>(
                hint: const Text("Выбрать"),
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                ),
                underline: Container(),
                value: company.value,
                items: companies,
                onChanged: (value) => company.value = value,
                alignment: AlignmentDirectional.topCenter,
                focusColor: Colors.white
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: FloatingActionButton.extended(
                onPressed: null,
                label: Text("Выбрать"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
