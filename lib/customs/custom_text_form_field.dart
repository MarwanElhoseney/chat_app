import 'package:flutter/material.dart';

typedef validator = String? Function(String?);

class CustomTextFormField extends StatefulWidget {
  String text;
  bool obscure;
  bool visable;
  validator? validate;
  TextEditingController? controller;

  CustomTextFormField(
      {required this.text,
      this.obscure = false,
      this.visable = false,
      this.validate,
      this.controller});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validate,
        obscureText: widget.obscure,
        decoration: InputDecoration(
            label: Text(widget.text),
            suffixIcon: Visibility(
                visible: widget.visable,
                child: InkWell(
                    onTap: () {
                      if (widget.obscure == true) {
                        widget.obscure = false;
                      } else if (widget.obscure == false) {
                        widget.obscure = true;
                      }

                      setState(() {});
                    },
                    child: Icon(
                      widget.obscure ? Icons.visibility : Icons.visibility_off,
                    )))),
      ),
    );
  }
}
