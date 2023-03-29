import 'package:flutter/material.dart';
import 'package:the_specials_app/env/env.dart';
import 'package:the_specials_app/shared/styles/colors.dart';

class CardPicturesProfile extends StatefulWidget {
  CardPicturesProfile({Key? key,  required this.onPressed, required this.picture}) : super(key: key);
  final VoidCallback onPressed;

  String picture;
  @override
  State<CardPicturesProfile> createState() => _CardPicturesProfileState();
}

class _CardPicturesProfileState extends State<CardPicturesProfile> {
  verifyExistsImage(image) {

  }
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: DefaultColors.greenSoft,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
        minimumSize: Size.zero, // Set this
        padding: EdgeInsets.zero,
      ),
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 100,
          maxWidth: 110,
          minHeight: 100,
          maxHeight: 110,
        ),
        alignment: AlignmentDirectional.bottomEnd,
        decoration: BoxDecoration(
          color: DefaultColors.greyMedium,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage('${Env.baseURLImage}${widget.picture.replaceAll(r"\", r"")}') ,
            fit: BoxFit.cover,
            alignment: const Alignment(-0.3, 0),
          ),
        ),
        child:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: const Icon(Icons.add_circle_rounded ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            color: DefaultColors.purpleBrand,
            iconSize: 25,
            onPressed: () {
              // Navigator.pushNamed(context, RoutesApp.userConfig);
            },
          ),
        ),
      ),
    );
  }
}
