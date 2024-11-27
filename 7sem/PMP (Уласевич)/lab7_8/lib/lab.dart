
interface class Moveable{
  void move(){

  }
  void stop(){

  }
}


abstract class Transport{
    int id;
    String brand;
    int year;
    Transport(this.id, this.brand, this.year);
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

  Map<String, Object?> toMap(){
    var map = <String, Object?>{
      columnId: id,
      columnBrand: brand,
      columnYear: year,
      columnNumberOfDoors: numberOfDoors
    };
    if(id != null){
      map[columnId] = id;
    }
    return map;
  }

  Car.fromMap(Map<dynamic, dynamic> map): super(map[columnId], map[columnBrand], map[columnYear]) {
    numberOfDoors = map[columnNumberOfDoors];
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

  Car(int id, String brand, int year, this.numberOfDoors):super(id, brand,year);


  Car.withName({
    required int id,
    required String brand,
    required int year,
    required this.numberOfDoors,
  }) : super(id, brand, year);

  Car.withName2({
    required int id,
    required String brand,
    required int year,
    required this.numberOfDoors,
  }) : super(id, brand, year);

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

class Truck extends Transport{

  int _loadCapacity;
  int get loadCapacity{return _loadCapacity;}
  set loadCapacity(int value){
    _loadCapacity = value;
  }

  Truck(int id, String brand, int year, this._loadCapacity):super(id,brand,year);
  @override
  void move(){
    print('Truck moved');
  }
  @override
  void stop(){
    print('Truck stopped');
  }
  @override
  void turnLeft(){
    print('Truck turned left');
  }
  @override
  void turnRight(){
    print('Truck turned right');
  }
}


void main(){
  Car car = Car(1,'Toyota', 2020, 4);
  car.move();
  car.stop();
  car.turnLeft();
  car.turnRight();
  car.checkSpeed(100);
  car.printBrand(brand: "BMW");
  car.printCar('BMW', 2004);
  car.printMessage(() => "Hello");
  car.printList();
  car.printSet();
  car.printCollection();
  car.continueTest();
  car.breakTest();
  car.checkException();

  Truck truck = Truck(1,'Volvo', 2018, 5000);
  truck.move();
  truck.stop();
  truck.turnLeft();
  truck.turnRight();
}
