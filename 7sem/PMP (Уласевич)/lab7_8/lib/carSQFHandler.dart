import 'package:lab7_8/lab.dart';
import 'package:sqflite/sqflite.dart';

final String tableCar = 'car';
final String columnId = '_id';
final String columnBrand = 'brand';
final String columnYear = 'year';
final String columnNumberOfDoors = 'numberOfDoors';

class CarSQFHandler{
  late Database db;
  Future open(String path) async{
    db = await openDatabase(path, version: 1, onCreate: (Database db, int version)async{
      await db.execute('''
        create table $tableCar ($columnId INTEGER PRIMARY KEY autoincrement,
                                $columnBrand TEXT not null,
                                $columnYear INTEGER,
                                $columnNumberOfDoors INTEGER)
      ''');
    });
  }
  Future<Car> insert(Car car) async{
    car.id = await db.insert(tableCar, car.toMap());
    return car;
  }
  Future<Car?> getCar(int id) async{
    List<Map> maps = await db.query(tableCar,
      columns: [columnId, columnBrand, columnYear, columnNumberOfDoors],
      where: '$columnId = ?',
      whereArgs: [id]);
    if(maps.isNotEmpty){
      return Car.fromMap(maps.first);
    }
    return null;
  }
  Future<int> delete(int id) async{
    return await db.delete(tableCar, where: '$columnId = ?', whereArgs: [id]);
  }
  Future<int> update(Car car) async{
    return await db.update(tableCar, car.toMap(), where: '$columnId = ?', whereArgs: [car.id]);
  }
  Future<List<Car>> getAllCars() async{
    List<Map<String, dynamic>> maps = await db.query(tableCar);
    List<Car> cars = [];
    for(var map in maps){
      cars.add(Car.fromMap(map));
    }
    return cars;
  }

  Future close() async => db.close();
}