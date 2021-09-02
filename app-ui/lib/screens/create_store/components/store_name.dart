import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';

class StoreName extends StatefulWidget {
  final textEditingController;
  const StoreName({Key? key, required this.textEditingController})
      : super(key: key);

  @override
  _StoreNameState createState() => _StoreNameState();
}

class _StoreNameState extends State<StoreName> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.store_rounded, color: kLiteFontColor),
        SizedBox(width: kDefaultPadding),
        Expanded(
          child: TextField(
            style: TextStyle(fontSize: 14, color: kDefaultFontColor),
            cursorColor: kThemeColor,
            keyboardType: TextInputType.text,
            controller: widget.textEditingController,
            decoration: InputDecoration(
                counterText: "",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kDefaultFontColor, width: 1.2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kLiteFontColor, width: 1),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                hintText: '가게명',
                hintStyle: TextStyle(color: kLiteFontColor)),
            maxLength: 20,
          ),
        )
      ],
    );
  }
}
