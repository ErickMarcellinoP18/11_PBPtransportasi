import 'package:flutter/material.dart';

class PassForm extends StatefulWidget {
  final TextEditingController passwordController;
  const PassForm({super.key, required this.passwordController});

  @override
  State<PassForm> createState() => _PassFormState();
}

class _PassFormState extends State<PassForm> {
  bool _testing = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: SizedBox(
        width: 350,
        child: TextFormField(
          validator: (value) {
            if (value.toString().isEmpty || value == null) {
              return "Inputkan Password yang telah didaftar";
            }
          },
          controller: widget.passwordController,
          obscureText: _testing,
          decoration: InputDecoration(
            hintText: "Password",
            border: const OutlineInputBorder(),
            helperText: "Password",
            prefixIcon: Icon(Icons.password),
            suffixIcon: VisibilityCheck(),
          ),
        ),
      ),
    );
  }

  Widget VisibilityCheck() {
    return IconButton(
        onPressed: () {
          setState(() {
            _testing = !_testing;
          });
        },
        icon: _testing ? Icon(Icons.visibility_off) : Icon(Icons.visibility));
  }
}
