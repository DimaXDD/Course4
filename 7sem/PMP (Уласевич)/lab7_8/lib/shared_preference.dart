import 'dart:convert';
import 'package:lab7_8/lab.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CarSharedHandler{
  final String _key;
  CarSharedHandler(this._key);


  Future<void> saveCar(Car car) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(car.toMap()));
  }

  Future<Car> loadCar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? carJson = prefs.getString(_key);
    if (carJson != null) {
      return Car.fromMap(jsonDecode(carJson));
    }
    throw Exception('Car data not found');
  }

  Future<void> deleteCar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

}