import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/gradients.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({
    super.key,
    required this.themeMode,
    required this.onThemeChanged,
  });

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Тема оформления',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Выберите внешний вид приложения',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey),
        ),
        const SizedBox(height: 12),
        _ThemeOption(
          icon: Icons.light_mode_outlined,
          title: 'Светлая тема',
          subtitle: 'Классический светлый дизайн',
          selected: themeMode == ThemeMode.light,
          onTap: () => onThemeChanged(ThemeMode.light),
        ),
        const SizedBox(height: 12),
        _ThemeOption(
          icon: Icons.nightlight_round,
          title: 'Темная тема',
          subtitle: 'Полночный мрак для комфорта',
          selected: themeMode == ThemeMode.dark,
          onTap: () => onThemeChanged(ThemeMode.dark),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.cyan.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.cyan.withOpacity(0.35)),
          ),
          child: const Text(
            'Темная тема с полночным мраком (#0B0B0E) помогает снизить нагрузку на глаза в темное время суток.',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}

class _ThemeOption extends StatelessWidget {
  const _ThemeOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected ? AppColors.cyan : Colors.grey.withOpacity(0.3),
            width: selected ? 2 : 1,
          ),
          color: Theme.of(context).cardColor,
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: AppColors.cyan.withOpacity(0.3),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(12),
          leading: Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              gradient: selected ? AppGradients.cyanGreen : null,
              color: selected ? null : const Color(0xFF1F2A44),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon),
          ),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
          subtitle: Text(subtitle),
          trailing: selected
              ? const CircleAvatar(
                  radius: 12,
                  backgroundColor: AppColors.green,
                  child: Icon(Icons.check, size: 16, color: Colors.white),
                )
              : null,
        ),
      ),
    );
  }
}
