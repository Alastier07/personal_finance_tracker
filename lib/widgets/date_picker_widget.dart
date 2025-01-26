import 'package:flutter/material.dart';

import '../core/utils/date_time_utils.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  final _firstDate = requestNewDateFromNow(toAdd: false, year: 10);
  final _lastDate = requestNewDateFromNow(toAdd: true, year: 20);
  DateTime _initialDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: _selectDate,
          icon: const Icon(Icons.date_range),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final result = await showDatePicker(
      context: context,
      firstDate: _firstDate,
      lastDate: _lastDate,
      initialDate: _initialDate,
    );

    widget.controller.text =
        result == null ? widget.controller.text : defaultDateFormat(result);

    setState(() => _initialDate = result ?? _initialDate);
  }
}
