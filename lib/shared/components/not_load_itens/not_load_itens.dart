import 'package:flutter/material.dart';
class NotLoadItens extends StatefulWidget {
  const NotLoadItens({super.key, this.messageToShow = "Input a message to show user", this.iconToShow = Icons.mood_bad_outlined});
  final String messageToShow;
  final IconData iconToShow;
  @override
  State<NotLoadItens> createState() => _NotLoadItensState();
}

class _NotLoadItensState extends State<NotLoadItens> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.79,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            widget.iconToShow,
            size: MediaQuery.of(context).size.width / 6,),
          Center(
            child: Text(
                widget.messageToShow,
              style: const TextStyle(fontSize: 15),
            ),
          )
        ],
      ),
    );
  }
}
