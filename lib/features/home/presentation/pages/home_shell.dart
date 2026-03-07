import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/gradients.dart';
import '../../../news/presentation/pages/news_page.dart';
import '../../../schedule/presentation/pages/schedule_page.dart';
import '../../../theme/presentation/pages/theme_page.dart';
import '../widgets/drawer_item.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({
    super.key,
    required this.themeMode,
    required this.onThemeChanged,
  });

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeChanged;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  final PageController _pageController = PageController();
  int _page = 0;

  void _goToPage(int index) {
    setState(() {
      _page = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
    Navigator.of(context).maybePop();
  }

  void _onPointerSignal(PointerSignalEvent event) {
    if (event is! PointerScrollEvent) {
      return;
    }

    if (event.scrollDelta.dy > 0 && _page < 2) {
      _goToPage(_page + 1);
    } else if (event.scrollDelta.dy < 0 && _page > 0) {
      _goToPage(_page - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: _onPointerSignal,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Школьное\nприложение',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          toolbarHeight: 84,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                gradient: AppGradients.cyanGreen,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.person_outline),
                onPressed: () {},
              ),
            ),
          ],
        ),
        drawer: Drawer(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: const BoxDecoration(gradient: AppGradients.cyanGreen),
            child: SafeArea(
              child: Column(
                children: [
                  const ListTile(
                    title: Text('Меню', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 32)),
                    trailing: Icon(Icons.close),
                  ),
                  DrawerItem(
                    icon: Icons.home_outlined,
                    title: 'Главное',
                    selected: _page == 0,
                    onTap: () => _goToPage(0),
                  ),
                  DrawerItem(
                    icon: Icons.calendar_today_outlined,
                    title: 'Расписание',
                    selected: _page == 1,
                    onTap: () => _goToPage(1),
                  ),
                  DrawerItem(
                    icon: Icons.settings_outlined,
                    title: 'Настройки',
                    selected: _page == 2,
                    onTap: () => _goToPage(2),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (value) => setState(() => _page = value),
          children: [
            const NewsPage(),
            const SchedulePage(),
            ThemePage(
              themeMode: widget.themeMode,
              onThemeChanged: widget.onThemeChanged,
            ),
          ],
        ),
      ),
    );
  }
}
