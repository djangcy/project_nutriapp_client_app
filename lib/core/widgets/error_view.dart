import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Oops, something went wrong',
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }
}
