const String tableWork = 'Work2';

class WorkFields {
  static final List<String> values = [
    id, workName, companyName
  ];

  static const String id = '_id';
  static const String workName = 'workName';
  static const String companyName = 'companyName';
}

class Work {
  final int? id;
  final String workName;
  final String companyName;

  Work({
    this.id,
    required this.workName,
    required this.companyName,
  });

  Work copy({int? id, String? workName, String? companyName}) =>
      Work(
        id: id ?? this.id,
        workName: workName ?? this.workName,
        companyName: companyName ?? this.companyName,
      );

  Map<String, dynamic> toJson() => {
    WorkFields.id: id,
    WorkFields.workName: workName,
    WorkFields.companyName: companyName,
  };

  static Work fromJson(Map<String, Object?> json) => Work(
    id: json[WorkFields.id] as int?,
    workName: json[WorkFields.workName] as String,
    companyName: json[WorkFields.companyName] as String,
  );

  // Метод для преобразования списка Work в JSON
  static List<Map<String, dynamic>> listToJson(List<Work> WorkList) {
    return WorkList.map((Work) => Work.toJson()).toList();
  }

  // Метод для преобразования JSON обратно в список Work
  static List<Work> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => Work.fromJson(json)).toList();
  }
}
