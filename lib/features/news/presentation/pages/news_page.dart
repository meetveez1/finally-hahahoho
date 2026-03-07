import 'package:flutter/material.dart';

import '../../../../core/theme/gradients.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      children: [
        Text(
          'Новости школы',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          'Все актуальные события и объявления',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey),
        ),
        const SizedBox(height: 14),
        _NewsCard(
          title: 'Начало нового учебного года',
          text: '1 сентября наша школа открыла двери для всех учеников.',
        ),
        const SizedBox(height: 14),
        _NewsCard(
          title: 'Спортивный турнир между классами',
          text: 'Команды 9-х классов заняли призовые места.',
        ),
      ],
    );
  }
}

class _NewsCard extends StatelessWidget {
  const _NewsCard({required this.title, required this.text});

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: AppGradients.cyanGreen,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
