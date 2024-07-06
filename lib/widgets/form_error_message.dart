import 'package:flutter/material.dart';

class FormErrorMessage extends StatelessWidget {
  const FormErrorMessage({super.key, required this.errorMessage});
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      child: errorMessage != null
          ? Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                errorMessage!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : Container(),
    );
  }
}
