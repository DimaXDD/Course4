abstract class Worker {
  String name;
  int age;

  Worker(this.name, this.age);

  void work();
}

class Manager extends Worker {
  String department;
  Manager(super.name, super.age, this.department);

  @override
  void work() {
    print("$name управляет отделом $department.");
  }
}

class Engineer extends Worker {
  String specialization;

  Engineer(super.name, super.age, this.specialization);

  @override
  void work() {
    print("$name работает над задачами по специальности $specialization.");
  }
}

abstract class Workable {
  void startWork();
  void stopWork();
}

class Technician implements Workable {
  String task;

  Technician(this.task);

  @override
  void startWork() {
    print("Техник начал задачу: $task.");
  }

  @override
  void stopWork() {
    print("Техник завершил задачу: $task.");
  }
}

class Employee {
  String name;
  int age;

  static int employeeCount = 0;

  Employee(this.name, this.age) {
    employeeCount++;
  }

  Employee.fromIntern(String name) : this(name, 18);

  String get employeeName => name;

  set employeeAge(int age) {
    if (age > 0) {
      this.age = age;
    }
  }

  static void showEmployeeCount() {
    print("Всего сотрудников: $employeeCount");
  }

  void takeLeave({required int days}) {
    print("$name берет $days дней отпуска.");
  }

  void workOvertime([int hours = 2]) {
    print("$name работает сверхурочно $hours часов.");
  }

  void taskAssignment(Function task) {
    print("Назначение задачи для $name.");
    task();
  }
}

void main() {
  print("=== Демонстрация классов Manager и Engineer ===");
  Manager manager = Manager("Ilya", 25, "IT");
  Engineer engineer = Engineer("Dmitry", 20, "Software");

  manager.work();
  engineer.work();

  print("\n=== Демонстрация интерфейса Workable с Technician ===");
  Technician technician = Technician("Установка оборудования");
  technician.startWork();
  technician.stopWork();

  print("\n=== Демонстрация работы с Employee ===");
  Employee emp1 = Employee("Nikita", 25);
  Employee emp2 = Employee.fromIntern("Alexander");

  Employee.showEmployeeCount();

  print("Имя сотрудника: ${emp1.employeeName}");
  emp1.employeeAge = 26;
  print("Возраст сотрудника после обновления: ${emp1.age}");

  print("\n=== Методы с параметрами ===");
  emp1.takeLeave(days: 5);

  emp2.workOvertime();
  emp2.workOvertime(4);

  emp1.taskAssignment(() => print("Задача выполнена."));
}