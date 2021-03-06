import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InputField extends StatefulWidget {
  final String label;
  final Widget icone;
  final TextEditingController controller;
  final bool readOnly;
  final MaskTextInputFormatter mascara;
  final bool numeros;
  final bool senha;
  final Function onChange;
  final Function validacao;

  const InputField({
    Key key,
    this.label,
    this.icone,
    this.controller,
    this.readOnly = false,
    this.mascara,
    this.numeros = false,
    this.senha = false,
    this.onChange,
    this.validacao,
  }) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validacao,
      onChanged: widget.onChange,
      obscureText: widget.senha,
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
