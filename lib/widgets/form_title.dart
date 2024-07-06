import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormTitle extends StatelessWidget {
  const FormTitle({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        label,
        style: GoogleFonts.lato().copyWith(
            fontSize: 25, color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
