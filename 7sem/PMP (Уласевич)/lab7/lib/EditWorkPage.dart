import 'package:flutter/material.dart';
import 'models/Work.dart';
import 'services/DatabaseHelper.dart';

class EditWorkPage extends StatelessWidget {
  final Work? work;

  const EditWorkPage({Key? key, this.work}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final workNameController = TextEditingController(
        text: work != null ? work!.workName : '');
    final companyNameController = TextEditingController(
        text: work != null ? work!.companyName : '');

    return Scaffold(
      appBar: AppBar(title: Text(work == null ? 'Add Work' : 'Edit Work')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: workNameController,
              decoration: InputDecoration(labelText: 'Work Name'),
            ),
            TextField(
              controller: companyNameController,
              decoration: InputDecoration(labelText: 'Company Name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final newWork = Work(
                  workName: workNameController.text,
                  companyName: companyNameController.text,
                );
                if (work == null) {
                  await DatabaseHelper.instance.create(newWork);
                } else {
                  await DatabaseHelper.instance.update(
                      work!.copy(workName: newWork.workName, companyName: newWork.companyName));
                }
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
