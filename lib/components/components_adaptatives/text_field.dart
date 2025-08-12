import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveTextField extends StatelessWidget {
  final String label;
  final Function onSubmitted;
  final TextEditingController controller;
  final bool isNumber;

  const AdaptiveTextField(
    this.label,
    this.onSubmitted,
    this.controller,
    this.isNumber, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: CupertinoTextField(
            placeholder: label,
            onSubmitted: (value) => onSubmitted(value),
            controller: controller,
            keyboardType:
                isNumber
                    ? const TextInputType.numberWithOptions(decimal: true)
                    : TextInputType.text,
          ),
        )
        : TextField(
          decoration: InputDecoration(labelText: label),
          onSubmitted: (value) => onSubmitted(value),
          controller: controller,
          keyboardType:
              isNumber
                  ? TextInputType.numberWithOptions(decimal: true)
                  : TextInputType.text,
        );
  }
}
