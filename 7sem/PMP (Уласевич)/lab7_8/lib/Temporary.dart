import 'dart:convert';
import 'dart:io';

import 'package:lab7_8/lab.dart';
import 'package:path_provider/path_provider.dart';


class FileSystemManager{
  Future<String> get _tempDirectoryPath async {
    final directory = await getTemporaryDirectory();
    return directory.path;
  }

  Future<void> writeCarToFile(Car car) async {
    final path = await _tempDirectoryPath;
    final file = File('$path/car_data.json');
    await file.writeAsString(jsonEncode(car.toMap()));
  }

  Future<Car> readCarFromFile() async {
    try {
      final path = await _tempDirectoryPath;
      final file = File('$path/car_data.json');
      final jsonString = await file.readAsString();
      final Map<String, dynamic> carMap = jsonDecode(jsonString);
      return Car.fromMap(carMap);
    } catch (e) {
      print('Ошибка чтения файла: $e');
      return Car(0, 'Undefined', 2000, 0);
    }
  }
}

