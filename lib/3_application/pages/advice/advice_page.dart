// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:learn_flutter_2_udemy/3_application/core/services/theme_service.dart';
import 'package:learn_flutter_2_udemy/3_application/pages/advice/widgets/advice_field.dart';
import 'package:learn_flutter_2_udemy/3_application/pages/advice/widgets/custom_button.dart';
import 'package:learn_flutter_2_udemy/3_application/pages/advice/widgets/error_message.dart';
import 'package:provider/provider.dart';

class AdvicePage extends StatelessWidget {
  const AdvicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        // ignore: deprecated_member_use
        title: Text('Adviser', style: theme.textTheme.headline1),
        centerTitle: true,
        actions: [
          Switch(
            value: Provider.of<ThemeService>(context).isDarkModeOn,
            onChanged: (value) =>
                Provider.of<ThemeService>(context, listen: false).toggleTheme(),
          )
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: ErrorMessage(message: "Oops! Something went wrong!")
                // AdviceField(
                //   advice: "Example Advice: bhuiqewf qwei qwiudh",
                // ), 
                // CircularProgressIndicator(
                //   color: theme.colorScheme.secondary,
                // ),
                // Text(
                //   "Your Advice will be here",
                //   style: theme.textTheme.headline1,
                // ),
              ),
            ),
            SizedBox(
                height: 200,
                child: Center(
                  child: CustomButton(),
                )),
          ],
        ),
      ),
    );
  }
}
