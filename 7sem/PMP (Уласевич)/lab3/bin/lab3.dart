import 'dart:async';

mixin Logger {
  void log(String message) {
    print("LOG: $message");
  }
}

class Employee implements Comparable<Employee> {
  String name;
  int age;

  Employee(this.name, this.age);

  @override
  int compareTo(Employee other) {
    return age.compareTo(other.age);
  }

  Map<String, dynamic> toJson() => {'name': name, 'age': age};

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(json['name'], json['age']);
  }
}

class EmployeeIterator implements Iterator<Employee> {
  int _index = -1;
  final List<Employee> _employees;

  EmployeeIterator(this._employees);

  @override
  Employee get current => _employees[_index];

  @override
  bool moveNext() {
    _index++;
    return _index < _employees.length;
  }
}

class EmployeeIterable extends Iterable<Employee> {
  final List<Employee> _employees;

  EmployeeIterable(this._employees);

  @override
  Iterator<Employee> get iterator => EmployeeIterator(_employees);
}

class Manager extends Employee with Logger {
  Manager(super.name, super.age);

  void manage() {
    log("$name is managing the team.");
  }
}

class Engineer extends Employee with Logger {
  Engineer(super.name, super.age);

  void develop() {
    log("$name is developing software.");
  }
}

Future<String> fetchData() async {
  await Future.delayed(Duration(seconds: 2));
  return "Data loaded";
}

Future<void> callFuture() {
  return Future.delayed(Duration(seconds: 3), () {
    print("Future completed after 3 seconds.");
  });
}

Stream<int> singleStream(int limit) async* {
  for (int i = 1; i <= limit; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}

Future<int> sumStream(Stream<int> stream) async {
  int sum = 0;
  await for (final value in stream) {
    sum += value;
  }
  return sum;
}

Future<void> callSingleSubscriptionStream() async {
  var stream = singleStream(5);
  var sum = await sumStream(stream);
  print(sum);
}

Stream<int> broadcastStream() {
  StreamController<int> controller = StreamController<int>.broadcast();
  Future(() {
    for (int i = 1; i <= 5; i++) {
      Future.delayed(Duration(seconds: i), () => controller.add(i));
    }
  });
  return controller.stream;
}
