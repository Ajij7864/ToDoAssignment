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

  // ToDo copyWith({
  //   String? id,
  //   String? title,
  //   String? description,
  //   bool? isChecked,
  // }) {
  //   return ToDo(
  //     id: id ?? this.id,
  //     title: title ?? this.title,
  //     description: description ?? this.description,
  //     isChecked: isChecked ?? this.isChecked,
  //   );
  // }
}
