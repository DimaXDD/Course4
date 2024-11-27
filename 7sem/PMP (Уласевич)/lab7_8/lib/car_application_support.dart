import 'dart:convert';

import 'package:lab7_8/lab.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class CarApplicationSupport{
  Future<String> get _documentsPath async{
    final directory = await getApplicationSupportDirectory();
    return directory?.path ?? '';
  }

  Future writeCarToFile(Car car) async{
    final path = await _documentsPath;
    final file = File('$path/car_support_data.json');
    await file.writeAsString(jsonEncode(car.toMap()));
  }

  Future<Car?> readCarFromFile() async{
    try{
      final path = await _documentsPath;
      final file = File('$path/car_support_data.json');
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