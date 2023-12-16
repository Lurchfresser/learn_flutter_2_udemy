// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkResponse(
      onTap: onTap,
      child: Material(
        elevation: 20,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: onTap == null ? theme.colorScheme.tertiary : theme.colorScheme.secondary,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Text(
              "Get Advice",
              style: theme.textTheme.headline1
            ),
          ),
        ),
      ),
    );
  }
}
