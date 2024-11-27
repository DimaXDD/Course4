import 'dart:async' show Future;

import 'package:flutter/material.dart';
import 'package:lab7_8/lab.dart';
import 'package:lab7_8/carSQFHandler.dart';

class CarPage extends StatefulWidget {
  @override
  _CarPageState createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  final CarSQFHandler _carSQFHandler = CarSQFHandler();

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    await _carSQFHandler.open('database.db');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _addCar();
              },
              child: Text('Add Car'),
            ),
            ElevatedButton(
              onPressed: () async {
                Car? car = await _getCar(1);
                if (car != null) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Car Information'),
                        content: Text('ID: ${car.id}, Brand: ${car.brand}, Year: ${car.year}, Doors: ${car.numberOfDoors}'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Car Not Found'),
                        content: Text('The car with ID 1 was not found in the database.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Get Car'),
            ),
            ElevatedButton(
              onPressed: () async {
                List<Car> cars = await _getAllCars();
                if (cars.isNotEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('All Cars'),
                        content: SizedBox(
                          height: 200,
                          width: 300,
                          child: ListView.builder(
                            itemCount: cars.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                title: Text('ID: ${cars[index].id}, Brand: ${cars[index].brand}, Year: ${cars[index].year}, Doors: ${cars[index].numberOfDoors}'),
                              );
                            },
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('No Cars Found'),
                        content: Text('There are no cars in the database.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Get All Cars'),
            ),

            ElevatedButton(
              onPressed: () {
                _updateCar();
              },
              child: Text('Update Car'),
            ),
            ElevatedButton(
              onPressed: () {
                _deleteCar(1);
                _deleteCar(2);
              },
              child: Text('Delete Car'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addCar() async {
    final newCar = Car.withName(
      id: 1,
      brand: 'Toyota',
      year: 2020,
      numberOfDoors: 4,
    );
    final newCar2 = Car.withName(
      id: 2,
      brand: 'BMW',
      year: 2018,
      numberOfDoors: 2,
    );
    await _carSQFHandler.insert(newCar);
    await _carSQFHandler.insert(newCar2);
    print('Car Added');
  }

  Future<Car?> _getCar(int id) async {
    final car = await _carSQFHandler.getCar(id);
    if (car != null) {
      print('Car found: $car');
    } else {
      print('Car not found');
    }
    return car;
  }

  Future<void> _updateCar() async {
    final updatedCar = Car.withName2(
      id: 1,
      brand: 'Honda',
      year: 2022,
      numberOfDoors: 2,
    );
    await _carSQFHandler.update(updatedCar);
    print('Car updated successfully');
  }

  Future<void> _deleteCar(int id) async {
    await _carSQFHandler.delete(id);
    print('Car deleted successfully');
  }

  Future<List<Car>> _getAllCars() async {
    final cars = await _carSQFHandler.getAllCars();
    print('All Cars:');
    cars.forEach((car) => print(car));
    return cars;
  }

  @override
  void dispose() {
    _carSQFHandler.close();
    super.dispose();
  }
}
