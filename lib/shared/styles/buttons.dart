import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_specials_app/shared/styles/colors.dart';
class DefaultSizes {
  static const double defaultButton = 50;
}
class ButtonPrimary extends StatelessWidget {
  final VoidCallback onPressed;
  final String texto;

  const ButtonPrimary({Key? key, required this.onPressed, required this.texto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(DefaultSizes.defaultButton),
          backgroundColor: DefaultColors.purpleBrand,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
      ),
      child: Text(
        texto,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}

class ButtonSecondary extends StatelessWidget {
  final VoidCallback onPressed;
  final String texto;
  final BorderSide? borderSide;
  final double? elevation;
  const ButtonSecondary(
      {
        Key? key,
        required this.onPressed,
        required this.texto,
        this.borderSide = const BorderSide(width: 1.0, color: DefaultColors.blueBrand),
        this.elevation
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(DefaultSizes.defaultButton),
        backgroundColor: Colors.white,
        side: borderSide,
        elevation: elevation,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
      ),
      child: Text(
        texto,
        style: const TextStyle(fontSize: 18, color: DefaultColors.blueBrand),
      ),
    );
  }
}

class ButtonLike extends StatelessWidget {
  final VoidCallback onPressed;

  const ButtonLike(
      {Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(60),
        backgroundColor: DefaultColors.greenSoft,
        side: const BorderSide(width: 1.0, color: DefaultColors.greenSoft),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
      ),
      child: SvgPicture.asset(
        'assets/images/favorite.svg',
        width: 35,
        height: 35,
        color: DefaultColors.redDefault,
      ),
    );
  }
}
class ButtonDislike extends StatelessWidget {
  final VoidCallback onPressed;

  const ButtonDislike(
      {Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(60),
        backgroundColor: DefaultColors.redSoft,
        side: const BorderSide(width: 1.0, color: DefaultColors.redSoft),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
      ),
      child: SvgPicture.asset(
        'assets/images/heart_broken.svg',
        width: 35,
        height: 35,
        color: Colors.white,
      ),
    );
  }
}
class ButtonMenu extends StatelessWidget {
  final VoidCallback onPressed;
  final String image;
  final Color colorIcon;
  const ButtonMenu(
      {Key? key, required this.onPressed, required this.image, this.colorIcon = DefaultColors.greyMedium})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(60),
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPrimary: DefaultColors.purpleBrand,
        side: const BorderSide(width: 1.0, color:  Colors.transparent),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
      ),
      child: SvgPicture.asset(
        'assets/images/$image.svg',
        width: 35,
        height: 35,
        color: colorIcon,
      ),
    );
  }
}
class ButtonSettings extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final String icon;

  const ButtonSettings(
      {Key? key, required this.onPressed, required this.text, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(60),
        backgroundColor: Colors.white,
        side: const BorderSide(width: 1.0, color: Colors.white),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            SvgPicture.asset(
              'assets/images/$icon.svg',
              width: 50,
              height: 50,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: const TextStyle(
                  fontSize: 20,
                  color: DefaultColors.greyMedium,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class ButtonSimulateInputSelect extends StatelessWidget {
  final VoidCallback onPressed;
  final String texto;

  const ButtonSimulateInputSelect({Key? key, required this.onPressed, required this.texto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0.0,
        shadowColor: Colors.transparent,
        minimumSize: const Size.fromHeight(DefaultSizes.defaultButton),
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
        padding: EdgeInsets.zero,
      ),
      child:  Container(

        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.deepPurple,
              width: 2,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(texto, style: const TextStyle(
                color: DefaultColors.greyMedium,
              ),),
            ),
            const Icon(Icons.arrow_drop_down, color: DefaultColors.greyMedium),
          ],
        ),
      ),
    );
  }
}
class ButtonCarousel extends StatelessWidget {
  final VoidCallback onPressed;
  final String texto;

  const ButtonCarousel({Key? key, required this.onPressed, required this.texto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
          ),
          padding: EdgeInsets.zero,
        ),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(texto),
          ],
        ),
      ),
    );
  }
}

class ButtonRigthIcon extends StatelessWidget {
  final VoidCallback onPressed;
  final String texto;
  final double? textSize;
  final Color? textColor;

  final IconData icon;
  final Color? iconColor;

  final BorderSide? borderSide;
  final double? elevation;


  const ButtonRigthIcon(
      {
        Key? key,
        required this.onPressed,
        required this.texto,
        required this.icon,
        this.borderSide = const BorderSide(width: 1.0, color: DefaultColors.blueBrand),
        this.elevation,
        this.textSize = 20,
        this.textColor = DefaultColors.greyMedium,
        this.iconColor = DefaultColors.greyMedium,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        side: borderSide,
        elevation: elevation,
      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              texto,
              style: TextStyle(
                fontSize: textSize,
                color: textColor,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Icon(
              icon,
              color: iconColor
          ),
        ],
      ),
    );
  }
}

class ButtonOnlyText extends StatelessWidget {
  final VoidCallback onPressed;
  final String texto;
  final double? textSize;
  final Color? textColor;

  final BorderSide? borderSide;
  final double? elevation;


  const ButtonOnlyText(
      {
        Key? key,
        required this.onPressed,
        required this.texto,
        this.borderSide = const BorderSide(width: 1.0, color: DefaultColors.blueBrand),
        this.elevation,
        this.textSize = 20,
        this.textColor = DefaultColors.greyMedium,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        side: borderSide,
        elevation: elevation,
      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            texto,
            style: TextStyle(
              fontSize: textSize,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
