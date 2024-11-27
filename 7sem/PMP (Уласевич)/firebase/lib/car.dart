interface class Moveable{
  void move(){

  }
  void stop(){

  }
}


abstract class Transport{
  String brand;
  int year;
  Transport(this.brand, this.year);
  void turnLeft(){
    print('Turn left');
  }
  void turnRight(){
    print("Turn right");
  }
}
final String tableCar = 'car';
final String columnId = '_id';
final String columnBrand = 'brand';
final String columnYear = 'year';
final String columnNumberOfDoors = 'numberOfDoors';


class Car extends Transport implements Moveable{
  int numberOfDoors = 0;
  String result = "";


  int get _numberOfDoors => numberOfDoors;
  set _numberOfDoors(int value){
    numberOfDoors = value;
  }

  static int requireSpeed = 60;

  void checkSpeed(int currentSpeed){
    if(currentSpeed > requireSpeed){
      print('Вы превышаете допустимую скорость');
    }
  }
  void printCar([String brand = 'undefined', int year = 2000]){
    print("Марка: $brand; Год: $year");
  }
  void printBrand({String brand = 'Volvo'}){
    print("Марка: $brand");
  }

  void printMessage(String Function() getMessage){
    String message = getMessage();
    print("Message: $message");
  }


  void printList(){
    List<int> ints = [1,2,3,4,5];
    print("\nList");
    print(ints);
    print(ints.first);
    print(ints.last);
    print(ints.length);
    print(ints.reversed);
    print(ints.isNotEmpty);
    ints.add(6);
    print(ints);
    ints.removeLast();
    print(ints);
    print(ints.take(2));
  }
  @override
  String toString() {
    return 'Car(brand: $brand, year: $year, numberOfDoors: $numberOfDoors)';
  }
  void printSet(){
    Set<String> strings = {"first", "second", "third"};
    print("\nSET");
    print(strings);
    print(strings.first);
    print(strings.last);
    print(strings.length);
    print(strings.isNotEmpty);
    strings.add("value");
    print(strings);
    strings.remove("value");
    print(strings);
    print(strings.take(2));
    strings.clear();
    print(strings);
  }

  void printCollection(){
    print("\nCollection");
    Map<int, String> collection = {
      1: "Mercedes",
      2: "BMW",
      3: "Volvo"
    };
    print(collection);
    print(collection.entries);
    print(collection.keys);
    print(collection.values);
    collection.clear();
    print(collection);
  }

  void continueTest(){
    for(int i = 0; i< 20; i++){
      if(i%2 == 0){
        continue;
      }
      result += i.toString() + ", ";
    }
    print(result);
  }
  void breakTest(){
    String result = "";
    for(int i = 1; i < 20; i++){
      if(i%2 == 0){
        break;
      }
      result += i.toString() + ", ";
    }
    print(result);
  }
  void checkException(){
    try{
      int res;
      res = (1/0) as int;
    }
    catch(e){
      print("Exception");
    }
    finally{
      print("Выполнение блока finally");
    }
  }

  Car(String brand, int year, this.numberOfDoors):super(brand,year);


  Map<String, Object?> toMap(){
    var map = <String, Object?>{
      columnBrand: brand,
      columnYear: year,
      columnNumberOfDoors: numberOfDoors
    };
    return map;
  }

  Car.fromMap(Map<dynamic, dynamic> map): super(map[columnBrand], map[columnYear]) {
    numberOfDoors = map[columnNumberOfDoors];
  }


  Car.withName({
    required String brand,
    required int year,
    required this.numberOfDoors,
  }) : super(brand, year);

  Car.withName2({
    required String brand,
    required int year,
    required this.numberOfDoors,
  }) : super(brand, year);

  @override
  void move(){
    print('Car moved');
  }
  @override
  void stop(){
    print('Car stopped');
  }
  @override
  void turnLeft(){
    print('Car turned left');
  }
  @override
  void turnRight(){
    print('Car turned right');
  }
}