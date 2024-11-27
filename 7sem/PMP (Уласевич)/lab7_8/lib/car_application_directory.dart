import 'dart:convert';
import 'dart:io';
import 'package:lab7_8/lab.dart';
import 'package:path_provider/path_provider.dart';

class CarApplicationDirectory{
  Future<String> get _documentsPath async{
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future writeCarToFile(Car car) async{
    final path = await _documentsPath;
    final file = File('$path/car_application_data.json');
    await file.writeAsString(jsonEncode(car.toMap()));
  }

  Future<Car?> readCarFromFile() async{
    try{
      final path = await _documentsPath;
      final file = File('$path/car_application_data.json');
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