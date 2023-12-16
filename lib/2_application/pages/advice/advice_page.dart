// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learn_flutter_2_udemy/2_application/core/services/theme_service.dart';
import 'package:learn_flutter_2_udemy/2_application/pages/advice/cubit/advicer_cubit.dart';
import 'package:learn_flutter_2_udemy/2_application/pages/advice/widgets/advice_field.dart';
import 'package:learn_flutter_2_udemy/2_application/pages/advice/widgets/custom_button.dart';
import 'package:learn_flutter_2_udemy/2_application/pages/advice/widgets/error_message.dart';
import 'package:learn_flutter_2_udemy/injection.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdvicerPageWrapperProvider extends StatelessWidget {
  const AdvicerPageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AdvicerCubit>(),
      child: const AdvicePage(),
    );
  }
}

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: BlocBuilder<AdvicerCubit, AdvicerCubitState>(
                  builder: (context, state) {
                    if (state is AdvicerInitial) {
                      return Text(
                        "Your Advice will be here",
                        style: theme.textTheme.headline1,
                      );
                    } else if (state is AdvicerStateLoading) {
                      return CircularProgressIndicator(
                        color: theme.colorScheme.secondary,
                      );
                    } else if (state is AdvicerStateLoaded) {
                      return AdviceField(
                        advice: state.advice,
                      );
                    } else if (state is AdvicerStateError) {
                      return ErrorMessage(
                        message: state.message,
                      );
                    }
                    return const ErrorMessage(
                        message: "Oops! Something went wrong!");
                  },
                ),
              ),
            ),
            SizedBox(
                height: 200,
                child: Center(
                  child: CustomButton(
                      onTap: () => BlocProvider.of<AdvicerCubit>(context)
                          .adviceRequested()),
                )),
          ],
        ),
      ),
    );
  }
}
