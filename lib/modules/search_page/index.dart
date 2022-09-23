import 'package:app/components/search_input/index.dart';
import 'package:app/config/AppTheme.dart';
import 'package:app/routes/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  void handleInputChange(String text) {}

  @override
  void initState() {
    super.initState();
    // print(ModalRoute.of(context)?.settings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    // decoration: const BoxDecoration(),
                    width: 20,
                    margin: const EdgeInsets.only(right: 8),
                    child: CupertinoButton(
                      onPressed: () {
                        MyRouter.pop(context);
                      },
                      padding: EdgeInsets.zero,
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 20,
                        color: appTheme.gray,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SearchInput(
                      handleInputChange: (e) {
                        handleInputChange(e);
                      },
                      enabled: true,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
