import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/gradients.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    final lessons = [
      ('Математика', 'Иванова А.П.', '08:30 - 09:15', 'Кабинет 204', 'Урок 1'),
      ('Русский язык', 'Петрова С.В.', '09:25 - 10:10', 'Кабинет 301', 'Урок 2'),
      ('Физика', 'Сидоров И.И.', '10:25 - 11:10', 'Кабинет 105', 'Урок 3'),
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Расписание уроков',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 6),
        Text('Класс 9Б', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey)),
        const SizedBox(height: 14),
        const Row(
          children: [
            _DayTab(text: 'Понедельник', active: true),
            SizedBox(width: 8),
            _DayTab(text: 'Вторник', active: false),
          ],
        ),
        const SizedBox(height: 14),
        for (final lesson in lessons)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            lesson.$1,
                            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 24),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.cyan.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            lesson.$5,
                            style: const TextStyle(color: AppColors.cyan, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(lesson.$2, style: const TextStyle(color: Colors.grey, fontSize: 18)),
                    const Divider(height: 24),
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 16, color: Colors.grey),
                        const SizedBox(width: 8),
                        Text(
                          lesson.$3,
                          style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        const Icon(Icons.location_pin, size: 16, color: Colors.pinkAccent),
                        const SizedBox(width: 8),
                        Text(
                          lesson.$4,
                          style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _DayTab extends StatelessWidget {
  const _DayTab({required this.text, required this.active});

  final String text;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          gradient: active ? AppGradients.cyanGreen : null,
          color: active ? null : const Color(0xFF2A2D36),
          borderRadius: BorderRadius.circular(14),
        ),
        alignment: Alignment.center,
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.w700)),
      ),
    );
  }
}
