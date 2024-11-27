import 'dart:async';
import 'package:hive/hive.dart';
import 'package:lab7_8/lab.dart';
import 'package:path_provider/path_provider.dart';

class CarHive{
  static const String _boxName = 'car_box';

  Future<Box> _getBox() async{
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    return Hive.openBox(_boxName);
  }

  Future saveCar(Car car) async{
    var box = await _getBox();
    await box.put(car.id, car.toMap());
  }

  Future<Car?> getCar(int id) async{
    var box = await _getBox();
    var carMap = box.get(id);
    if(carMap == null) return null;
    return Car.fromMap(carMap);
  }

  Future<List<Car>> getAllCars() async{
    var box = await _getBox();
    var carList = <Car>[];
    for(var key in box.keys){
      var carMap = box.get(key);
      if(carMap != null){
        carList.add(Car.fromMap(carMap));
      }
    }
    return carList;
  }

  Future updateCar(Car car) async{
    var box = await _getBox();
    await box.put(car.id, car.toMap());
  }

  Future deleteCar(int id) async {
    var box = await _getBox();
    await box.delete(id);
  }

}