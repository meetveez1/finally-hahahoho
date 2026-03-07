import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const SchoolApp());
}

class SchoolApp extends StatefulWidget {
  const SchoolApp({super.key});

  @override
  State<SchoolApp> createState() => _SchoolAppState();
}

class _SchoolAppState extends State<SchoolApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void _setThemeMode(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Школьное приложение',
      themeMode: _themeMode,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      scrollBehavior: const AppScrollBehavior(),
      home: HomeShell(
        themeMode: _themeMode,
        onThemeChanged: _setThemeMode,
      ),
    );
  }
}

class AppThemes {
  static const Color midnight = Color(0xFF0B0B0E);
  static const Color darkHeader = Color(0xFF1B1E24);
  static const Color cyan = Color(0xFF12C2E9);
  static const Color green = Color(0xFF00D26A);

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: cyan),
    scaffoldBackgroundColor: const Color(0xFFF4F6FA),
    cardColor: Colors.white,
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: midnight,
    cardColor: const Color(0xFF171A22),
    appBarTheme: const AppBarTheme(backgroundColor: darkHeader),
    colorScheme: const ColorScheme.dark(
      primary: cyan,
      secondary: green,
      surface: Color(0xFF171A22),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Colors.white),
      titleMedium: TextStyle(color: Colors.white),
    ),
    useMaterial3: true,
  );
}

class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}

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
    final gradient = const LinearGradient(
      colors: [AppThemes.cyan, AppThemes.green],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Listener(
      onPointerSignal: _onPointerSignal,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Школьное\nприложение', style: TextStyle(fontWeight: FontWeight.w700)),
          toolbarHeight: 84,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                gradient: gradient,
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
            )
          ],
        ),
        drawer: Drawer(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: const BoxDecoration(gradient: LinearGradient(colors: [AppThemes.cyan, AppThemes.green])),
            child: SafeArea(
              child: Column(
                children: [
                  const ListTile(
                    title: Text('Меню', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 32)),
                    trailing: Icon(Icons.close),
                  ),
                  _DrawerItem(
                    icon: Icons.home_outlined,
                    title: 'Главное',
                    selected: _page == 0,
                    onTap: () => _goToPage(0),
                  ),
                  _DrawerItem(
                    icon: Icons.calendar_today_outlined,
                    title: 'Расписание',
                    selected: _page == 1,
                    onTap: () => _goToPage(1),
                  ),
                  _DrawerItem(
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
            ThemePage(themeMode: widget.themeMode, onThemeChanged: widget.onThemeChanged),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({required this.icon, required this.title, required this.selected, required this.onTap});

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
          leading: Icon(icon, color: selected ? AppThemes.cyan : Colors.white),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: selected ? AppThemes.cyan : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final gradient = const LinearGradient(colors: [AppThemes.cyan, AppThemes.green]);

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      children: [
        Text('Новости школы', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 6),
        Text('Все актуальные события и объявления', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey)),
        const SizedBox(height: 14),
        _newsCard(context, gradient, 'Начало нового учебного года', '1 сентября наша школа открыла двери для всех учеников.'),
        const SizedBox(height: 14),
        _newsCard(context, gradient, 'Спортивный турнир между классами', 'Команды 9-х классов заняли призовые места.'),
      ],
    );
  }

  Widget _newsCard(BuildContext context, Gradient gradient, String title, String text) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(18),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              Text(text, style: TextStyle(color: Colors.grey.shade500, fontSize: 18)),
              const SizedBox(height: 8),
              const Row(
                children: [
                  Icon(Icons.favorite_border),
                  SizedBox(width: 8),
                  Text('124'),
                  SizedBox(width: 20),
                  Icon(Icons.mode_comment_outlined),
                  SizedBox(width: 8),
                  Text('18'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

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
        Text('Расписание уроков', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 6),
        Text('Класс 9Б', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey)),
        const SizedBox(height: 14),
        Row(
          children: [
            _dayTab('Понедельник', true),
            const SizedBox(width: 8),
            _dayTab('Вторник', false),
          ],
        ),
        const SizedBox(height: 14),
        for (final l in lessons)
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
                        Expanded(child: Text(l.$1, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 24))),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppThemes.cyan.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(l.$5, style: const TextStyle(color: AppThemes.cyan, fontWeight: FontWeight.w700)),
                        )
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(l.$2, style: const TextStyle(color: Colors.grey, fontSize: 18)),
                    const Divider(height: 24),
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 16, color: Colors.grey),
                        const SizedBox(width: 8),
                        Text(l.$3, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600)),
                        const Spacer(),
                        const Icon(Icons.location_pin, size: 16, color: Colors.pinkAccent),
                        const SizedBox(width: 8),
                        Text(l.$4, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600)),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
      ],
    );
  }

  Widget _dayTab(String text, bool active) {
    return Expanded(
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          gradient: active ? const LinearGradient(colors: [AppThemes.cyan, AppThemes.green]) : null,
          color: active ? null : const Color(0xFF2A2D36),
          borderRadius: BorderRadius.circular(14),
        ),
        alignment: Alignment.center,
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.w700)),
      ),
    );
  }
}

class ThemePage extends StatelessWidget {
  const ThemePage({super.key, required this.themeMode, required this.onThemeChanged});

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Тема оформления', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Text('Выберите внешний вид приложения', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey)),
        const SizedBox(height: 12),
        _themeOption(
          context,
          icon: Icons.light_mode_outlined,
          title: 'Светлая тема',
          subtitle: 'Классический светлый дизайн',
          selected: themeMode == ThemeMode.light,
          onTap: () => onThemeChanged(ThemeMode.light),
        ),
        const SizedBox(height: 12),
        _themeOption(
          context,
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
            color: AppThemes.cyan.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppThemes.cyan.withOpacity(0.35)),
          ),
          child: const Text(
            'Темная тема с полночным мраком (#0B0B0E) помогает снизить нагрузку на глаза в темное время суток.',
            style: TextStyle(fontSize: 16),
          ),
        )
      ],
    );
  }

  Widget _themeOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: selected ? AppThemes.cyan : Colors.grey.withOpacity(0.3), width: selected ? 2 : 1),
          color: Theme.of(context).cardColor,
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: AppThemes.cyan.withOpacity(0.3),
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
              gradient: selected ? const LinearGradient(colors: [AppThemes.cyan, AppThemes.green]) : null,
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
                  backgroundColor: AppThemes.green,
                  child: Icon(Icons.check, size: 16, color: Colors.white),
                )
              : null,
        ),
      ),
    );
  }
}
