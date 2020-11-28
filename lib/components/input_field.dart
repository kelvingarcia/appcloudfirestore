import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InputField extends StatefulWidget {
  final String label;
  final Widget icone;
  final TextEditingController controller;
  final bool readOnly;
  final MaskTextInputFormatter mascara;
  final bool numeros;

  const InputField({
    Key key,
    this.label,
    this.icone,
    this.controller,
    this.readOnly = false,
    this.mascara,
    this.numeros = false,
  }) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.numeros ? TextInputType.number : null,
      inputFormatters: widget.mascara != null ? [widget.mascara] : null,
      readOnly: widget.readOnly,
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
