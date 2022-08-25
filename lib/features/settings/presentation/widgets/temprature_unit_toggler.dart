import 'package:flutter/material.dart';

class TemperatureUnitToggler extends StatefulWidget {
  const TemperatureUnitToggler({
    Key? key,
    required this.index,
    this.onTap,
  }) : super(key: key);

  final int index;
  final void Function(int)? onTap;

  @override
  State<TemperatureUnitToggler> createState() => _TemperatureUnitTogglerState();
}

class _TemperatureUnitTogglerState extends State<TemperatureUnitToggler> {
  final selectedBoxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(30),
    boxShadow: [
      BoxShadow(
        color: Colors.blue.withOpacity(.15),
        blurRadius: 5,
        offset: const Offset(0, 5),
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final selectedStyle = TextStyle(
      color: brightness == Brightness.dark ? Colors.white : Colors.black,
    );

    return Container(
      height: 50,
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.15),
            blurRadius: 0,
            // spreadRadius: 5,
            blurStyle: BlurStyle.outer,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  widget.onTap!(0);
                });
                if (widget.onTap == null) return;
              },
              child: Container(
                // height: 35,
                // width: 80,
                decoration: widget.index == 0
                    ? selectedBoxDecoration
                    : const BoxDecoration(),
                alignment: Alignment.center,
                child: Text(
                  '°C',
                  style: widget.index == 0 ? selectedStyle : null,
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  widget.onTap!(1);
                });
                if (widget.onTap == null) return;
              },
              child: Container(
                alignment: Alignment.center,
                decoration: widget.index == 1
                    ? selectedBoxDecoration
                    : const BoxDecoration(),
                child: Text(
                  '°F',
                  style: widget.index == 1 ? selectedStyle : null,
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  widget.onTap!(2);
                });
                if (widget.onTap == null) return;
              },
              child: Container(
                alignment: Alignment.center,
                decoration: widget.index == 2
                    ? selectedBoxDecoration
                    : const BoxDecoration(),
                child: Text(
                  'K',
                  style: widget.index == 2 ? selectedStyle : null,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
