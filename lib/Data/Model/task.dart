class Task {
  int? id;
  String? content;
  String? date;
  String? status;
  Task({this.id, this.content, this.status, this.date});
  Map<String, dynamic> toMap() {
    return {'id': id, 'content': content, 'status': status, 'date': date};
  }
}
