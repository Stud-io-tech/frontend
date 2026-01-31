// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TextDefault extends StatelessWidget {
  final String text;
  final bool overflow;
  final TextStyle textStyle;
  final int? maxLines;
  final bool center;
  const TextDefault({
    super.key,
    required this.text,
    this.overflow = false,
    required this.textStyle,
    this.maxLines,
    this.center = false
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: true,
      overflow: overflow ? TextOverflow.ellipsis : null,
      style: textStyle,
      maxLines: maxLines,
      textAlign: center? TextAlign.center: null,
    );
  }
}
