class ToDo {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  bool isChecked;

  ToDo(
      {required this.id,
      required this.title,
      required this.description,
      required this.isChecked,
      required this.date});
}
