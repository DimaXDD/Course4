import 'dart:async' show Future;

import 'package:flutter/material.dart';
import 'package:lab7_8/lab.dart';
import 'package:lab7_8/shared_preference.dart';

class CarSharedPage extends StatefulWidget {
  @override
  _CarSharedPageState createState() => _CarSharedPageState();
}

class _CarSharedPageState extends State<CarSharedPage> {

  final CarSharedHandler _carSharedHandler = CarSharedHandler("car_data");
  Car? _car = null;

  @override
  void initState() {
    super.initState();
    _loadCar();
  }

  Future _loadCar() async{
    try{
      Car car = await _carSharedHandler.loadCar();
      setState(() {
        _car = car;
      });
    }
    catch(e){
      print('Car data not found');
    }
  }

  Future _saveCar() async{
    Car car = Car(1, 'Toyota', 2020, 4);
    await _carSharedHandler.saveCar(car);
    setState(() {
      _car = car;
    });
  }

  Future _deleteCar() async{
    await _carSharedHandler.deleteCar();
    setState(() {
      _car = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_car != null) ...[
              Text(
                'Brand: ${_car?.brand}',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'Year: ${_car?.year}',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'Number of doors: ${_car?.numberOfDoors}',
                style: TextStyle(fontSize: 20),
              ),
            ],
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveCar();
              },
              child: Text('Save Car'),
            ),
            ElevatedButton(
              onPressed: () {
                _deleteCar();
              },
              child: Text('Delete Car'),
            ),
          ],
        ),
      ),
    );
  }
}
