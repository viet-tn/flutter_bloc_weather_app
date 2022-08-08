import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

import '../bloc/search_bloc.dart';

class SearchControls extends StatefulWidget {
  const SearchControls({Key? key}) : super(key: key);

  @override
  State<SearchControls> createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<SearchControls> {
  final controller = TextEditingController();
  String inputStr = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        // color: Colors.black.withOpacity(.1),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.5),
            blurRadius: 4,
            // offset: const Offset(0, 150),
            blurStyle: BlurStyle.outer,
          )
        ],
      ),
      child: TextField(
        style: const TextStyle(
          fontSize: 20,
        ),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(10),
          isDense: true,
          border: InputBorder.none,
          prefixIcon: Icon(
            LineIcons.search,
            size: 24,
          ),
          hintText: 'New York, Ho Chi Minh,...',
          hintStyle: TextStyle(
            fontSize: 16,
          ),
        ),
        onChanged: (value) => inputStr = value,
        onSubmitted: (_) => dispatchSearch(),
      ),
    );
  }

  void dispatchSearch() {
    // Clearing the TextField to prepare it for the next inputted query
    controller.clear();
    BlocProvider.of<SearchBloc>(context).add(GetLocationsEvent(inputStr));
  }
}
