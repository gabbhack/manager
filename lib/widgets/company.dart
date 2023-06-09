import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:manager/repositories/companies.dart';
import 'package:manager/stores/company.dart';
import 'package:manager/widgets/workers.dart';

final companies = loadCompanies();
final company = Company();

final companyWidgets = companies
    .map(
      (e) => DropdownMenuItem<String>(value: e.name, child: Text(e.name)),
    )
    .toList();

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
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            Observer(
              builder: (_) => DropdownButton<String>(
                hint: const Text("Выбрать"),
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                underline: Container(),
                value: company.value,
                items: companyWidgets,
                onChanged: (value) => company.value = value,
                alignment: AlignmentDirectional.topCenter,
                focusColor: Colors.transparent,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Observer(
                builder: (_) => FloatingActionButton.extended(
                  onPressed: company.value != null
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (context) =>
                                  Workers(company: company.value!),
                            ),
                          );
                        }
                      : null,
                  label: const Text("Выбрать"),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            const Text("Агапитов, Габбасов, Громут, Колташев, Овчинников, Резников")
          ],
        ),
      ),
    );
  }
}
