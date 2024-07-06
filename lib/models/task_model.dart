class TaskModel {
  final String uid;
  final String title;
  final String? description;

  TaskModel({
    required this.uid,
    required this.title,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'title': title,
      'description': description,
    };
  }
}
