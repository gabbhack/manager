import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:manager/stores/resumes.dart';
import 'package:manager/widgets/resume.dart';

class Workers extends StatefulWidget {
  final String company;
  const Workers({super.key, required this.company});

  @override
  State<Workers> createState() => _WorkersState();
}

class _WorkersState extends State<Workers> {
  final resumes = Resumes();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Менеджмент'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => resumes.addResume(
          Resume(
            company: widget.company,
          ),
        ),
      ),
      body: Observer(
        builder: (_) {
          return GridView.count(
            crossAxisCount: 3,
            children: resumes.values.toList(),
          );
        },
      ),
    );
  }
}
