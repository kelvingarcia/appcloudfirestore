import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String label;
  final Widget icone;
  final TextEditingController controller;

  const InputField({
    Key key,
    this.label,
    this.icone,
    this.controller,
  }) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.label,
        filled: true,
        fillColor: Colors.grey[300],
        suffixIcon: widget.icone ?? null,
      ),
    );
  }
}
