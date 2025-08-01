import 'package:flutter/material.dart';

class PermanentTextfield extends StatelessWidget {
  final String hintText;
 final String value;
final Widget? suffixIcon;
  PermanentTextfield({required this.hintText, required this.value, this.suffixIcon, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      readOnly: true, // Makes the text field permanent (non-editable)
      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
           // color: Theme.of(context).colorScheme.primary,
            width: 1,
          ),
        ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.onSecondary,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.onSecondary,
          width: 1,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.onSecondary,
          width: 1,
        ),
      ),
      suffixIcon: suffixIcon,
      ),
      
    );
  }
}