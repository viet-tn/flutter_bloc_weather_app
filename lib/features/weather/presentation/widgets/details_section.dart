import 'package:flutter/material.dart';

import '../../../../core/helpers/string_time_from_epoch.dart';
import '../../domain/entities/entities.dart';

class DetailsSection extends StatelessWidget {
  final Weather current;
  const DetailsSection({Key? key, required this.current}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            left: 20,
            bottom: 5,
          ),
          child: Text(
            'Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          width: size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.grey.withOpacity(.15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 25,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.sunny),
                        SizedBox(width: 10),
                        Text(
                          'Sunrise',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      hourFromEpoch(current.sunrise),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Divider(
                  indent: (size.width - 60) * .05,
                  thickness: 1,
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.dark_mode),
                        SizedBox(width: 10),
                        Text(
                          'Sunset',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      hourFromEpoch(current.sunset),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                // const Divider(indent: 50),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
