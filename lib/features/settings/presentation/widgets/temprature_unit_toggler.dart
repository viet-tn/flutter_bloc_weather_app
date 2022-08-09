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
  int index = 0;
  @override
  Widget build(BuildContext context) {
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
                  index = 0;
                });
                if (widget.onTap == null) return;
                widget.onTap!(0);
              },
              child: Container(
                // height: 35,
                // width: 80,
                decoration: widget.index == 0
                    ? BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(.15),
                            blurRadius: 5,
                            offset: const Offset(0, 5),
                          )
                        ],
                      )
                    : const BoxDecoration(),
                alignment: Alignment.center,
                child: const Text('°C'),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  index = 1;
                });
                if (widget.onTap == null) return;
                widget.onTap!(1);
              },
              child: Container(
                alignment: Alignment.center,
                decoration: widget.index == 1
                    ? BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(.15),
                            blurRadius: 5,
                            offset: const Offset(0, 5),
                          )
                        ],
                      )
                    : const BoxDecoration(),
                child: const Text('°F'),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  index = 2;
                });
                if (widget.onTap == null) return;
                widget.onTap!(2);
              },
              child: Container(
                alignment: Alignment.center,
                decoration: widget.index == 2
                    ? BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(.15),
                            blurRadius: 5,
                            offset: const Offset(0, 5),
                          )
                        ],
                      )
                    : const BoxDecoration(),
                child: const Text('K'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
