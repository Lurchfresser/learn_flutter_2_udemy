// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String message;
  const ErrorMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.error, size:40, color: Colors.redAccent,),
        const SizedBox(height: 20,),
        Text(
          message,
          style: theme.textTheme.headline1,
          textAlign: TextAlign.center,)
      ],
    );
  }
}