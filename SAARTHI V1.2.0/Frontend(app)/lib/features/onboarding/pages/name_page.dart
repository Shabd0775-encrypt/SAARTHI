import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/widgets/page_shell.dart';
import '../../../shared/widgets/typewriter_block.dart';

class NamePage extends StatelessWidget {
  const NamePage({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final titleStyle = GoogleFonts.googleSansCode(
      textStyle: Theme.of(context).textTheme.displaySmall,
      fontSize: 36,
      fontWeight: FontWeight.w700,
    );
    final subtitleStyle = GoogleFonts.googleSansCode(
      textStyle: Theme.of(context).textTheme.titleLarge,
      fontSize: 24,
      fontWeight: FontWeight.w600,
    );
    final inputStyle = GoogleFonts.googleSansCode(
      textStyle: Theme.of(context).textTheme.bodyLarge,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    );

    return PageShell(
      title: 'Hello,',
      titleStyle: titleStyle,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      titleAlignment: Alignment.center,
      titleTextAlign: TextAlign.center,
      childAlignment: Alignment.center,
      titleWidget: TypewriterBlock(
        lines: const ['HI! There,', 'Tell us your name'],
        lineStyles: [titleStyle, subtitleStyle],
        textAlign: TextAlign.center,
        duration: const Duration(milliseconds: 1400),
        cursor: true,
        cursorAfterComplete: true,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          TextField(
            controller: controller,
            textAlign: TextAlign.center,
            style: inputStyle,
            decoration: InputDecoration(
              fillColor: (Theme.of(context)
                          .inputDecorationTheme
                          .fillColor ??
                      const Color(0xFFE9E1D2))
                  .withValues(alpha: 0.65),
              hintText: 'Your name',
              hintStyle: inputStyle.copyWith(
                color: const Color(0xFF6B5E52),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
