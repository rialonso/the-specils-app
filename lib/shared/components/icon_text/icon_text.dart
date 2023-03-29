import 'package:flutter/material.dart';
import 'package:the_specials_app/shared/styles/colors.dart';

class IconText extends StatefulWidget {
  IconText({Key? key, this.iconShow = Icons.add,required this.textShow}) : super(key: key);
  String textShow;
  IconData iconShow;

  @override
  State<IconText> createState() => _IconTextState();
}

class _IconTextState extends State<IconText> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(widget.iconShow ),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          color: DefaultColors.greyMedium,
          iconSize: 25,
          onPressed: () {
            // Navigator.pushNamed(context, RoutesApp.userConfig);
          },
        ),
        const SizedBox(
          width: 5,
        ),
        Text(widget.textShow)
      ],
    );
  }
}
