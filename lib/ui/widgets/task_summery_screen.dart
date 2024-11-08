import 'package:flutter/material.dart';

class TaskSummeryCard extends StatelessWidget {
  const TaskSummeryCard({
    super.key,
    required this.title,
    required this.count,
  });

  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.purple.shade100,
      elevation: 1, //shadow
      child: SizedBox(
        width: 110, //todo learn if i dont want to use extra widgets i can just increase the size
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '$count',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(title, style: TextStyle(color: Colors.black54)),
              // FittedBox(child: Text(title, style: TextStyle(color: Colors.grey))),//todo fitted box usedd to fit the text with the available size
            ],
          ),
        ),
      ),
    );
  }
}