import 'package:flutter/services.dart';

Map<String, List<FilteringTextInputFormatter>> formatters = {
  "Name": [
    FilteringTextInputFormatter.allow(
      RegExp('[a-z A-Z]'),
    ),
  ],
  "Amount": [
    FilteringTextInputFormatter.allow(RegExp(r'(^\d*[\.\,]?\d{0,2})')),
  ],
};

Map<String, Function> validators = {
  "Name": (value) {
    if (value!.isEmpty) {
      return "Add a Recipient name";
    } else if (value.length < 3) {
      return "Name must be at-least 3 characters";
    }
    return null;
  },
  "Amount": (value) {
    if (value!.isEmpty) {
      return "Enter a amount that have been paid or received";
    } else if (int.parse(value) < 1) {
      return "Amount cannot be in negative";
    }
    return null;
  },
  "AddNewPerson": (selectedOptions) {
    if (selectedOptions!.isEmpty) {
      return "Select any Person to share the Expense/Income";
    }

    return null;
  },
};
