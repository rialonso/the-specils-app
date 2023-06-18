import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_specials_app/env/env.dart';
import 'package:the_specials_app/shared/interfaces/local_interfaces/edit_pictures_asset.dart';
import 'package:the_specials_app/shared/styles/colors.dart';


// ignore: must_be_immutable
class CardPicturesProfile extends StatefulWidget {
  CardPicturesProfile({Key? key,  required this.onPressed, required this.picture}) : super(key: key);
  final VoidCallback onPressed;

  ImageAsset picture;

  @override
  State<CardPicturesProfile> createState() => _CardPicturesProfileState();
}

class _CardPicturesProfileState extends State<CardPicturesProfile> {
  final myWidgetKey = GlobalKey();
  late double height;

  @override
  void initState() {
    height = 100;
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => updateWidgetSize());
  }
  updateWidgetSize() {
    setState(() {
      height = myWidgetKey.currentContext?.size?.width?.toDouble() as double;
    });
    // print(myWidgetKey.currentContext?.size?.width?.toDouble() as double);

  }
  validateImageAndSetNetworkOrAsset(ImageAsset image) {
    print(image.imageType);
    // print(image.imagePath);

    if(image.imageType == 'asset') {
      return AssetImage(image?.imagePath as String);
    }
    if(image.imageType == 'network') {
      return NetworkImage('${Env.baseURLImage}${image?.imagePath?.replaceAll(r"\", r"")}');
    }
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    // RenderBox renderBox = myWidgetKey?.currentContext?.findRenderObject() as RenderBox;
    
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

      key: myWidgetKey,

        constraints: BoxConstraints(
          minWidth: width,
          minHeight: height,
        ),
        alignment: AlignmentDirectional.bottomEnd,
        decoration: BoxDecoration(
          color: DefaultColors.greyMedium,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            // image: AssetImage(assetName),
            image: validateImageAndSetNetworkOrAsset(widget?.picture as ImageAsset),
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
