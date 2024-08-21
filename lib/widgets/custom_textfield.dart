import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class CustomTextField extends StatefulWidget {
  final bool isPassword;
  final IconData prefixIcon;
  final String hintText;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.isPassword,
    required this.controller,
    required this.prefixIcon,
    required this.hintText,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: TextField(
        controller: widget.controller,
        obscureText: widget.isPassword ? _obscureText : false,
        decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange, width: 2.0),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 8.0,
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange, width: 2.0),
            ),
            filled: true,
            fillColor: Colors.grey[300],
            prefixIcon: Icon(widget.prefixIcon),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      size: 18,
                      _obscureText ? IconlyBroken.show : IconlyBroken.hide,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              fontSize: 15,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide.none,
            )),
      ),
    );
  }
}
