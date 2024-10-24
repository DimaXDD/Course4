import 'package:flutter/material.dart';
import 'services/DatabaseHelper.dart';
import 'models/Work.dart';
import 'EditWorkPage.dart';

class WorkDetailPage extends StatelessWidget {
  final Work work;
  final Function() onUpdate; // Колбэк для обновления списка

  WorkDetailPage({required this.work, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(work.workName),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditWorkPage(work: work),
                ),
              ).then((_) {
                onUpdate(); // Обновление списка после редактирования
                Navigator.pop(context);
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Company Name: ${work.workName}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Work Name: ${work.companyName}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Удаление команды
                DatabaseHelper.instance.delete(work.id!);
                onUpdate(); // Вызов колбэка для обновления списка
                Navigator.pop(context); // Вернуться к списку
              },
              child: Text('Delete Team'),
            ),
          ],
        ),
      ),
    );
  }
}
