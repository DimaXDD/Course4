import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/Work.dart';

class FileStorage {
  Future<String> get _localPath async {
    // Получаем путь к директории документов приложения
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<String> _getTemporaryPath() async {
    final directory = await getTemporaryDirectory();
    return directory.path;
  }

  Future<String> _getApplicationSupportPath() async {
    final directory = await getApplicationSupportDirectory();
    return directory.path;
  }

  Future<String> _getExternalStoragePath() async {
    final directory = await getExternalStorageDirectory();
    return directory?.path ?? '';
  }

  Future<File> _localFile(String filename, String dir) async {
    String dirPath;
    try{
    // Определяем путь в зависимости от выбранной директории
    switch (dir) {
      case 'Temporary':
        dirPath = (await getTemporaryDirectory()).path; // Временная директория
        break;
      case 'Application Support':
        dirPath = (await getApplicationSupportDirectory()).path; // Директория для поддержки приложения
        break;
      case 'Application Library':
        dirPath = (await getLibraryDirectory()).path; // Директория библиотеки приложения (только iOS)
        break;
      case 'Application Documents':
        dirPath = (await getApplicationDocumentsDirectory()).path; // Директория документов приложения
        break;
      case 'Application Cache':
        dirPath = (await getTemporaryDirectory()).path; // Директория кеша приложения, используется временная директория
        break;
      case 'External Storage':
        dirPath = (await getExternalStorageDirectory())!.path; // Внешнее хранилище
        break;
      case 'External Cache Directories':
        dirPath = (await getTemporaryDirectory()).path; // Кеш внешнего хранилища, используется временная директория
        break;
      case 'External Storage Directories':
        dirPath = (await getExternalStorageDirectory())!.path; // Директории внешнего хранилища
        break;
      case 'Downloads':
        dirPath = (await getDownloadsDirectory())!.path; // Директория загрузок
        break;
      default:
        throw Exception('Unknown directory: $dir');
    }

    // Создаем директорию, если она не существует
    final directory = Directory(dirPath);
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    print('$dirPath/$filename.txt');
    return File('$dirPath/$filename.txt'); // Создание файла в нужной директории
    }
    catch(e){
      throw Exception('Unknown directory: $dir');
    }
  }

  Future<File> writeWork(Work Work, String filename, String dir) async {
    try {
      final file = await _localFile(filename, dir);
      return await file.writeAsString(Work.toJson().toString());
    } catch (e) {
      throw Exception('Error writing to file: $e');
    }
  }

  Future<String> readWork(String filename, String dir) async {
    try {
      final file = await _localFile(filename, dir);
      return await file.readAsString();
    } catch (e) {
      return 'Error: $e';
    }
  }

  Future<File> writeWorkList(List<Work> WorkList, String filename, String dir) async {
    try {
      final file = await _localFile(filename, dir);
      // Используем listToJson для получения списка в формате JSON
      return await file.writeAsString(jsonEncode(Work.listToJson(WorkList)));
    } catch (e) {
      throw Exception('Error writing to file: $e');
    }
  }

  Future<List<Work>> readWorkList(String filename, String dir) async {
    try {
      final file = await _localFile(filename, dir);
      // Читаем содержимое файла и преобразуем его в список объектов Work
      final contents = await file.readAsString();
      final jsonList = jsonDecode(contents) as List<dynamic>; // Декодируем JSON
      return Work.listFromJson(jsonList); // Возвращаем список объектов Work
    } catch (e) {
      throw Exception('Error reading from file: $e'); // Обновлено для более точного сообщения об ошибке
    }
  }
}