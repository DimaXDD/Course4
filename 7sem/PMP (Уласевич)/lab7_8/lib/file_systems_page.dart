import 'dart:async' show Future;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab7_8/Temporary.dart';
import 'package:lab7_8/car_application_support.dart';
import 'package:lab7_8/car_external_cache.dart';
import 'package:lab7_8/car_external_storage.dart';
import 'package:lab7_8/lab.dart';
import 'package:lab7_8/car_application_directory.dart';

import 'package:lab7_8/shared_preference.dart';

class FileSystemsPage extends StatefulWidget {
  @override
  _FileSystemsPageState createState() => _FileSystemsPageState();
}

class _FileSystemsPageState extends State<FileSystemsPage> {
  final FileSystemManager _fileSystemManager = FileSystemManager();
  Car _loadedCar = Car(0, 'Undefined', 2000, 0);
  final CarApplicationDirectory _carFileManager = CarApplicationDirectory();
  Car? _loadedApplicationCar;
  final CarExternalStorage _carExternalStorage  = CarExternalStorage();
  Car? _loadedExternalStorageCar;
  final CarExternalCache _carExternalCache = CarExternalCache();
  Car? _loadedExternalCacheCar;
  final CarApplicationSupport _carApplicationSupport = CarApplicationSupport();
  Car? _loadedApplicationSupportCar;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: 400,
              height: 225,
              color: Colors.blue,
              child: Column(
                children: [
                  Text(
                    'TemporaryDictionary', style: TextStyle(fontSize: 22),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final Car carToSave = Car(1, 'Toyota', 2022, 4);
                      await _fileSystemManager.writeCarToFile(carToSave);
                      setState(() {
                        _loadedCar = carToSave;
                      });
                    },
                    child: Text('Сохранить машину'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final loadedCar = await _fileSystemManager.readCarFromFile();
                      setState(() {
                        _loadedCar = loadedCar;
                      });
                    },
                    child: Text('Загрузить машину'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Загруженная машина: ${_loadedCar?.brand}, ${_loadedCar?.year}, ${_loadedCar?.numberOfDoors}',
                  ),
                ],
              ),
            ),

            Container(
              width: 400,
              height: 225,
              color: Colors.green,
              child:  Column(
                children: [
                  Text('ApplicationDocumentsDirectory', style: TextStyle(fontSize: 22),),
                  ElevatedButton(
                    onPressed: () async {
                      final carToSave = Car(1, 'Toyota', 2020, 4);
                      await _carFileManager.writeCarToFile(carToSave);
                    },
                    child: Text('Сохранить машину'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final loadedCar = await _carFileManager.readCarFromFile();
                      setState(() {
                        _loadedApplicationCar = loadedCar;
                      });
                    },
                    child: Text('Загрузить машину'),
                  ),
                  SizedBox(height: 20),
                  if (_loadedApplicationCar != null)
                    Text(
                      'Загруженная машина: ${_loadedApplicationCar?.brand}, ${_loadedApplicationCar?.year}, ${_loadedApplicationCar?.numberOfDoors}',
                    ),
                ],

                ),
            ),


            Container(
              width: 400,
              height: 225,
              color: Colors.red,
              child:  Column(
                children: [
                  Text('ExternalStorageDirectory', style: TextStyle(fontSize: 22),),
                  ElevatedButton(
                    onPressed: () async {
                      final carToSave = Car(1, 'Toyota', 2019, 4);
                      await _carExternalStorage.writeCarToFile(carToSave);
                    },
                    child: Text('Сохранить машину'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final loadedCar = await _carExternalStorage.readCarFromFile();
                      setState(() {
                        _loadedExternalStorageCar = loadedCar;
                      });
                    },
                    child: Text('Загрузить машину'),
                  ),
                  SizedBox(height: 20),
                  if (_loadedExternalStorageCar != null)
                    Text(
                      'Загруженная машина: ${_loadedExternalStorageCar?.brand}, ${_loadedExternalStorageCar?.year}, ${_loadedExternalStorageCar?.numberOfDoors}',
                    ),
                ],

              ),
            ),

            Container(
              width: 400,
              height: 225,
              color: Colors.amber,
              child:  Column(
                children: [
                  Text('ExternalCacheDirectories', style: TextStyle(fontSize: 22),),
                  ElevatedButton(
                    onPressed: () async {
                      final carToSave = Car(1, 'Toyota', 2018, 4);
                      await _carExternalCache.writeCarToFile(carToSave);
                    },
                    child: Text('Сохранить машину'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final loadedCar = await _carExternalCache.readCarFromFile();
                      setState(() {
                        _loadedExternalCacheCar = loadedCar;
                      });
                    },
                    child: Text('Загрузить машину'),
                  ),
                  SizedBox(height: 20),
                  if (_loadedExternalCacheCar != null)
                    Text(
                      'Загруженная машина: ${_loadedExternalCacheCar?.brand}, ${_loadedExternalCacheCar?.year}, ${_loadedExternalCacheCar?.numberOfDoors}',
                    ),


                ],

              ),

            ),
            Container(
              width: 400,
              height: 225,
              color: Colors.black,
              child:  Column(
                children: [
                  Text('ApplicationSupportDirectory', style: TextStyle(fontSize: 22, color: Colors.white),),
                  ElevatedButton(
                    onPressed: () async {
                      final carToSave = Car(1, 'Toyota', 2015, 4);
                      await _carApplicationSupport.writeCarToFile(carToSave);
                    },
                    child: Text('Сохранить машину'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final loadedCar = await _carApplicationSupport.readCarFromFile();
                      setState(() {
                        _loadedApplicationSupportCar = loadedCar;
                      });
                    },
                    child: Text('Загрузить машину'),
                  ),
                  SizedBox(height: 20),
                  if (_loadedApplicationSupportCar != null)
                    Text(
                      'Загруженная машина: ${_loadedApplicationSupportCar?.brand}, ${_loadedApplicationSupportCar?.year}, ${_loadedApplicationSupportCar?.numberOfDoors}',
                      style: TextStyle(color: Colors.white),
                    ),
                ],

              ),
            ),
          ],
        ),
      ),
    );
  }
}
