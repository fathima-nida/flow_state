import 'package:flutter/material.dart';
class DropdownFormField extends FormField<String> {
  DropdownFormField({
    Key? key,
    String? value,
    required List<String> items,
    FormFieldSetter<String>? onSaved, 
    FormFieldValidator<String>? validator, 
    required ValueChanged<String?> onChanged,
    String? hintText,
  }) : super(
          key: key,
          onSaved: onSaved,
          validator: validator,
          initialValue: value, 
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                errorText: state.errorText,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: state.value,
                  hint: Text(hintText ?? 'Select an option'),
                  items: items.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    state.didChange(newValue);
                    onChanged(newValue);
                  },
                ),
              ),
            );
          },
        );
}
