import 'package:flutter/material.dart';

class AdjustableTextColorTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextStyle style;
  final TextInputAction textInputAction;
  final bool obscureText;
  final ValueChanged<String>? onSubmitted;

  const AdjustableTextColorTextField({
    super.key,
    required this.controller,
    this.hintText = "",
    this.style = const TextStyle(),
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.onSubmitted,
  });

  @override
  State<AdjustableTextColorTextField> createState() => _AdjustableTextColorTextFieldState();
}

class _AdjustableTextColorTextFieldState extends State<AdjustableTextColorTextField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextField(
      focusNode: _focusNode,
      controller: widget.controller,
      decoration: InputDecoration(hintText: widget.hintText),
      style: widget.style.copyWith(
        color: _focusNode.hasFocus ? colorScheme.primary : colorScheme.onBackground,
      ),
      textInputAction: widget.textInputAction,
      obscureText: widget.obscureText,
      onSubmitted: widget.onSubmitted,
    );
  }

  void _onFocusChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    super.dispose();
  }
}
