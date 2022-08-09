import 'package:flutter/widgets.dart';

class DetailsTile extends StatelessWidget {
  const DetailsTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.content,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 22,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
        Text(
          content,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
