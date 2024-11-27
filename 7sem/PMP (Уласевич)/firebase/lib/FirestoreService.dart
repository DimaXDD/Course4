import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/car.dart';

class FirestoreService {
  final CollectionReference _carCollection =
  FirebaseFirestore.instance.collection('cars');

  Future<void> addCar(Car car) {
    return _carCollection.add({
      'brand': car.brand,
      'year': car.year,
      'numberOfDoors': car.numberOfDoors,
    });
  }

  Future<List<Car>> getCars() async {
    QuerySnapshot snapshot = await _carCollection.get();
    return snapshot.docs.map((doc) {
      return Car(
        doc.get('brand'),
        doc.get('year'),
        doc.get('numberOfDoors'),
      );
    }).toList();
  }
}
