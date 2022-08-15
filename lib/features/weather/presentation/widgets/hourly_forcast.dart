import 'package:flutter/material.dart';

import '../../domain/entities/entities.dart';
import 'widgets.dart';

class HourlyForcast extends StatelessWidget {
  final List<ThreeHrsWeather> forcastList;
  const HourlyForcast({Key? key, required this.forcastList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final tempList = forcastList.map((e) => e.temp.round()).toList()..sort();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            left: 20,
            bottom: 5,
          ),
          child: Text(
            'Hourly',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          height: 270,
          width: size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.grey.withOpacity(.15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: forcastList
                    .map(
                      (e) => ForcastCard(
                        forcast: e,
                        minValue: tempList.first,
                        maxValue: tempList.last,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
