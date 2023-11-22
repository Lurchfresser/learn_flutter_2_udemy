// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AdviceField extends StatelessWidget {
  final String advice;
  const AdviceField({super.key, required this.advice});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      elevation: 20,
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: theme.colorScheme.primary,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Text(
            '''"$advice"''',
            style: theme.textTheme.headline1,
            textAlign: TextAlign.center,
          ),
        )
      ),
    );
  }
}