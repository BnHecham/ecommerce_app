// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../config/themes/colors.dart';

// ignore: must_be_immutable
class BuildTextField extends StatefulWidget {
  TextEditingController controller;
  String? label, hint;
  double textFieldWidth;
  IconData? icon;
  bool isObscure;
  String symbol;
  FormFieldValidator<String>? validator;
  FormFieldSetter<String>? onSaved;
  Widget? sufixIcon;
  TextInputType? keyboardType;

  BuildTextField({
    Key? key,
    required this.controller,
    this.validator,
    this.onSaved,
    this.keyboardType,
    this.label,
    this.hint,
    this.textFieldWidth = 320,
    this.icon,
    this.isObscure = false,
    this.symbol = '*',
    this.sufixIcon,
  }) : super(key: key);

  @override
  State<BuildTextField> createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(onListen);
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.removeListener(onListen);
  }

  void onListen() => setState(() {});

  checkSize(double _textFieldWidth) {
    widget.textFieldWidth = _textFieldWidth;
    if (widget.textFieldWidth > 150) {
      return true;
    } else {
      return false;
    }
  }

  prifixIcon(double _textFieldWidth) {
    widget.textFieldWidth = _textFieldWidth;
    if (checkSize(_textFieldWidth) == true) {
      return Icon(widget.icon, color: AppColor.iconColor);
    }
  }

  suffixIcon(TextEditingController _controller, String method) {
    if (method == "clear") {
      if (_controller.text.isNotEmpty) {
        return IconButton(
          icon: const Icon(Icons.clear_rounded),
          color: Colors.black38,
          onPressed: () => _controller.clear(),
        );
      } else {
        return Container(
          width: 0,
        );
      }
    }
  }

  contentPadding(double _textFieldWidth) {
    widget.textFieldWidth = _textFieldWidth;
    if (checkSize(_textFieldWidth) == false) {
      return const EdgeInsets.only(left: 25.0);
    } else {
      return const EdgeInsets.only(bottom: 20.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isObscure,
        validator: widget.validator,
        onSaved: widget.onSaved,
        obscuringCharacter: widget.symbol,
        keyboardType: widget.keyboardType,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          constraints: BoxConstraints(maxWidth: widget.textFieldWidth),
          contentPadding: contentPadding(widget.textFieldWidth),
          labelText: widget.label,
          labelStyle: const TextStyle(color: AppColor.iconColor),
          hintText: widget.hint,
          helperText: null,
          helperMaxLines: 5,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(
                color: AppColor.lightOrange,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(
                color: AppColor.orange,
              )),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(color: Colors.redAccent)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(color: Colors.red)),
          prefixIcon: prifixIcon(widget.textFieldWidth),
          suffixIcon: suffixIcon(widget.controller, "clear"),
        ),
      ),
    );
  }
}
