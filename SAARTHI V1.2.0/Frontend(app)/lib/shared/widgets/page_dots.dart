import 'package:flutter/material.dart';

class PageDots extends StatelessWidget {
  const PageDots({super.key, required this.current, required this.count});

  final int current;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final active = index == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 6,
          width: active ? 20 : 6,
          decoration: BoxDecoration(
            color: active ? const Color(0xFF1E1A16) : const Color(0xFFB9AB9D),
            borderRadius: BorderRadius.circular(6),
          ),
        );
      }),
    );
  }
}
