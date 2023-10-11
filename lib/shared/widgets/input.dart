import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  final String label;
  final double? width;
  final int? maxLength;
  final TextEditingController controller;
  final String? placeholder;
  final TextInputType? inputType;

  const Input(
      {super.key,
      required this.label,
      required this.controller,
      this.placeholder,
      this.inputType,
      this.maxLength,
      this.width});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(widget.label),
        const SizedBox(
          height: 4,
        ),
        TextField(
          controller: widget.controller,
          maxLength: widget.maxLength,
          keyboardType: widget.inputType,
          decoration: InputDecoration(hintText: widget.placeholder),
        )
      ]),
    );
  }
}
