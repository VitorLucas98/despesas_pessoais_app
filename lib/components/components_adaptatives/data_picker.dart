import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;
  const AdaptativeDatePicker(
    this.selectedDate,
    this.onDateSelected,
    {super.key});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? SizedBox(
          height: 180,
          child: CupertinoDatePicker(
            initialDateTime: selectedDate ?? DateTime.now(),
            onDateTimeChanged: (date) => onDateSelected(date),
            mode: CupertinoDatePickerMode.date,
          ),
        )
        : SizedBox(
          height: 70,
          child: Row(
            children: [
              Text( 
                selectedDate == null
                    ? 'Selecione uma data'
                    : 'Data selecionada: ${DateFormat('dd/MM/yyyy').format(selectedDate!)}',
                style: TextStyle(fontSize: 16),
              ),
              TextButton(
                 child: const Text( 'Selecionar data'),
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: selectedDate ?? DateTime.now(),
                    firstDate: DateTime(2025),
                    lastDate: DateTime.now(),
                  ).then((selectedDate) {
                    if (selectedDate != null) {
                      onDateSelected(selectedDate);
                    }
                  });
                },
               
              ),
            ],
          ),
        );
  }
}