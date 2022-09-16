import 'package:flutter/material.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({Key? key, required this.handleInputChange}) : super(key: key);

  final Function handleInputChange;

  @override
  State<StatefulWidget> createState() {
    return _SearchInputState();
  }
}

class _SearchInputState extends State<SearchInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search_outlined),
        hintText: '搜索',
      ),
      onChanged: (e) {
        widget.handleInputChange(e);
      },
    );
  }
}
