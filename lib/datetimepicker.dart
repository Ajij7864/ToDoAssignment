import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_project/provider/todoprovider.dart';

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({super.key});

  @override
  DateTimePickerState createState() => DateTimePickerState();
}

class DateTimePickerState extends State<DateTimePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Consumer<TodoProvider>(
            builder: (context, value, child) => Text(
              'Chosen Date: ${DateFormat.yMd().format(value.selectedDate)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Consumer<TodoProvider>(
            builder: (context, value, child) => TextButton(
              onPressed: () => value.showDatePickerHandler(context),
              child: const Text(
                'Choose Date',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
