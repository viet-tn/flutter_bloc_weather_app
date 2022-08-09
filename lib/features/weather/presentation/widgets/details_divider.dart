import 'package:flutter/material.dart';

class DetailsDivider extends StatelessWidget {
  const DetailsDivider({Key? key, this.indent = 0.0}) : super(key: key);

  final double indent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        Divider(
          indent: indent,
          thickness: 1,
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
