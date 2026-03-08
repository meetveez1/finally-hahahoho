import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.icon,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final selectedBg = Theme.of(context).brightness == Brightness.dark
        ? Colors.white.withOpacity(0.9)
        : Colors.white;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Material(
        color: selected ? selectedBg : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          onTap: onTap,
          leading: Icon(icon, color: selected ? AppColors.cyan : Colors.white),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: selected ? AppColors.cyan : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
