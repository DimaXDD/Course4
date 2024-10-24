import 'package:flutter/material.dart';
import 'models/Work.dart';
import 'services/FileStorage.dart';

class FileOperationsPage extends StatefulWidget {
  final List<Work> WorkList;

  FileOperationsPage({Key? key, required this.WorkList}) : super(key: key);

  @override
  _FileOperationsPageState createState() => _FileOperationsPageState();
}

class _FileOperationsPageState extends State<FileOperationsPage> {
  final FileStorage fileStorage = FileStorage();
  String? fileContents;
  String selectedPath = 'Application Documents'; // Убедитесь, что значение совпадает с одним из элементов списка
  final List<String> storagePaths = [
    'Temporary',
    'Application Support',
    'Application Library',
    'Application Documents',
    'Application Cache',
    'External Storage',
    'External Cache Directories',
    'External Storage Directories',
    'Downloads',
  ];

  void _writeWorkList() async {
    try {
      await fileStorage.writeWorkList(widget.WorkList, 'Work_list', selectedPath);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data written successfully!')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error writing data: $e')));
    }
  }

  void _readWorkList() async {
    try {
      final contents = await fileStorage.readWorkList('Work_list', selectedPath);
      setState(() {
        fileContents = contents.map((Work) => Work.workName).join(', '); // Преобразуем список в строку для отображения
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error reading data: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('File Operations')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Work Teams:'),
            ...widget.WorkList.map((Work) => Text(Work.workName)).toList(),
            SizedBox(height: 20),
            // Выпадающий список для выбора места сохранения
            DropdownButton<String>(
              value: selectedPath,
              onChanged: (String? newValue) {
                setState(() {
                  selectedPath = newValue!;
                });
              },
              items: storagePaths.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _writeWorkList, // Изменено на новый метод для записи списка
              child: Text('Write Work Data'),
            ),
            ElevatedButton(
              onPressed: _readWorkList, // Изменено на новый метод для чтения списка
              child: Text('Read Work Data'),
            ),
            SizedBox(height: 20),
            if (fileContents != null)
              Text('File Contents: $fileContents'),
          ],
        ),
      ),
    );
  }
}
