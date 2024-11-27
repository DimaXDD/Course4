import 'package:firebase/FirestoreService.dart';
import 'package:firebase/PushNotificationPage.dart';
import 'package:firebase/car.dart';
import 'package:flutter/material.dart';// Подставьте ваш путь к классу Car

class AddCarPage extends StatefulWidget {

  @override
  _AddCarPageState createState() => _AddCarPageState();
}

class _AddCarPageState extends State{
  final TextEditingController brandController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController doorsController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить автомобиль'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: brandController,
              decoration: InputDecoration(labelText: 'Марка'),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: yearController,
              decoration: InputDecoration(labelText: 'Год выпуска'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: doorsController,
              decoration: InputDecoration(labelText: 'Количество дверей'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _addCar();
              },
              child: Text('Добавить'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PushNotificationPage()),
                );
              },
              child: Text('Уведомления'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addCar() async {
    try {
      String brand = brandController.text;
      int year = int.parse(yearController.text);
      int doors = int.parse(doorsController.text);

      Car car = Car(brand, year, doors);
      await _firestoreService.addCar(car);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Автомобиль успешно добавлен')),
      );

      brandController.clear();
      yearController.clear();
      doorsController.clear();
    } catch (e) {
      print('Ошибка при добавлении автомобиля: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка при добавлении автомобиля')),
      );
    }
  }
}
