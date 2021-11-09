import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String text;
  const PasswordFieldWidget({
    Key? key,
    required this.controller,
    this.text = "Password",
  }) : super(key: key);

  @override
  _PasswordFieldWidgetState createState() => _PasswordFieldWidgetState();
}

class _PasswordFieldWidgetState extends State<PasswordFieldWidget> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: widget.controller,
        autofocus: false,
        obscureText: isHidden,
        decoration: InputDecoration(
          hintText: widget.text,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon:
                isHidden ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
            onPressed: togglePasswordVisibility,
          ),
        ),
        keyboardType: TextInputType.visiblePassword,
        autofillHints: [AutofillHints.password],
        onEditingComplete: () => TextInput.finishAutofillContext(),
        validator: (password) => password != null && password.length < 5
            ? 'Enter min. 5 characters'
            : null,
      );

  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);
}
