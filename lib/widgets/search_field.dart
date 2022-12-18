import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final VoidCallback onPressed;
  final Icon searchIcon;
  final Color iconColor;
  final String hintText;
  final double width;

  const SearchField({
    Key? key,
    required this.onPressed,
    required this.searchIcon,
    required this.iconColor,
    required this.hintText,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: width,
          child: TextField(
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
            ),
          ),
        ),
        IconButton(
          onPressed: onPressed,
          icon: searchIcon,
          color: iconColor,
        ),
      ],
    );
  }
}
