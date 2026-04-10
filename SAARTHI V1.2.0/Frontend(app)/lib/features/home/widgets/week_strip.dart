import 'package:flutter/material.dart';

import '../../../core/utils/time_utils.dart';

class WeekStrip extends StatelessWidget {
  const WeekStrip({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  @override
  Widget build(BuildContext context) {
    final start = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    const weekdayShort = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return SizedBox(
      height: 72,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 7,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final date = DateTime(start.year, start.month, start.day + index);
          final selected = isSameDate(selectedDate, date);
          return InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () => onDateSelected(date),
            child: Container(
              width: 64,
              decoration: BoxDecoration(
                color: selected
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE0D6C7)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    weekdayShort[index],
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: selected ? Colors.white : null,
                        ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    date.day.toString(),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: selected ? Colors.white : null,
                        ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
