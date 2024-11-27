import 'dart:convert';

import 'package:lab7_8/lab.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class CarExternalStorage{
  Future<String> get _documentsPath async{
    final directory = await getExternalStorageDirectory();
    return directory?.path ?? '';
  }

  Future writeCarToFile(Car car) async{
    final path = await _documentsPath;
    final file = File('$path/car_external_data.json');
    await file.writeAsString(jsonEncode(car.toMap()));
  }

  Future<Car?> readCarFromFile() async{
    try{
      final path = await _documentsPath;
      final file = File('$path/car_external_data.json');
      final jsonString = await file.readAsString();
      final Map<String, dynamic> carMap = jsonDecode(jsonString);
      return Car.fromMap(carMap);
    }
    catch(e){
      print('Ошибка чтения файла: $e');
      return null;
    }
  }
}