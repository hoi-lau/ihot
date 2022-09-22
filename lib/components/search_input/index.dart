import 'package:app/config/AppTheme.dart';
import 'package:flutter/material.dart';

class SearchInput extends StatefulWidget {
  const SearchInput(
      {Key? key, required this.handleInputChange, required this.enabled})
      : super(key: key);

  final Function handleInputChange;

  final bool enabled;

  @override
  State<StatefulWidget> createState() {
    return _SearchInputState();
  }
}

class _SearchInputState extends State<SearchInput> {
  final TextEditingController controller = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 32,
      ),
      child: TextField(
        controller: controller,
        cursorColor: appTheme.homeTheme.getFontColor(),
        cursorWidth: 1.5,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search_outlined,
            color: appTheme.searchTheme.getFontColor(),
          ),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    controller.clear();
                  },
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.cancel,
                    color: appTheme.searchTheme.getFontColor(),
                    size: 20,
                  ),
                )
              : null,
          hintText: '搜索',
          filled: true,
          fillColor: appTheme.searchTheme.getBgColor(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
        ),
        enabled: widget.enabled,
        onChanged: (e) {
          widget.handleInputChange(e);
        },
      ),
    );
  }
}
