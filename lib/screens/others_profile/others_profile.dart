import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:the_specials_app/env/env.dart';
import 'package:the_specials_app/shared/state_management/other_profile_data/other_profile_data.dart';
import 'package:the_specials_app/shared/state_management/user_data_profile/user_data_profile.dart';
import 'package:the_specials_app/shared/styles/buttons.dart';
import 'package:the_specials_app/shared/styles/colors.dart';
import 'package:the_specials_app/shared/values/routes.dart';

class OthersProfile extends StatefulWidget {
  const OthersProfile({Key? key}) : super(key: key);

  @override
  State<OthersProfile> createState() => _OthersProfileState();
}

class _OthersProfileState extends State<OthersProfile> {
  final otherProfileDataController = Get.put<OtherProfileDataController>(OtherProfileDataController());
  CarouselController buttonCarouselController = CarouselController();
  var currentPos = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    otherProfileDataController.getProfileUserData();
  }
  isLoopActive() {
    var profilePictureLength = otherProfileDataController.savedUserDataProfile?.data?.profilePicture?.length;
    if( profilePictureLength != null) {
      if(profilePictureLength > 1) {
        return true;
      }
    }
    return false;
  }
  createImageSlide () {
    return otherProfileDataController.savedUserDataProfile?.data?.profilePicture?.map((item) => Container(
      child: Stack(
        children: [
          Center(
              child:
              Image.network('${Env.baseURLImage}${item?.path}' as String, fit: BoxFit.cover, width: MediaQuery.of(context).size.width)),
         Row(
           children: [
             Flexible(child: ButtonCarousel(onPressed: (){
               buttonCarouselController.previousPage();
             }, texto: '')),
             Flexible(child: ButtonCarousel(onPressed: (){
               buttonCarouselController.nextPage();

             }, texto: ''))],
         )
        ],
      ),
    ))
        .toList();
  }

  createBulletSlide () {
    List<Widget> a =[];
    var profilePictures = otherProfileDataController.savedUserDataProfile?.data?.profilePicture;
    profilePictures?.forEach((element) {
      int index = profilePictures.indexOf(element);
      a.add(
        Row(

          children: [
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentPos == index
                  ? const Color.fromRGBO(255, 255, 255, 0.9)
                    : const Color.fromRGBO(255, 255, 255, 0.4),
              ),
              child: const Align(
                alignment: Alignment.center,
                child: Text(''),
              ),
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
      );
    });
    return a;

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFD0E0FD), Color(0xFFE8D9FD)])
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(0.0),
            // here the desired height
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              // ...
            )),
        body: GetBuilder<OtherProfileDataController>(
            builder: (_) {
              if(otherProfileDataController.userDataUpdated.value) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          color: DefaultColors.blueBrand,
                          iconSize: 35,
                          onPressed: () {
                           Navigator.pop(context);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          CarouselSlider(
                              items: createImageSlide(),
                              carouselController: buttonCarouselController,
                              options: CarouselOptions(
                                height: MediaQuery.of(context).size.width,
                                disableCenter: false,
                                viewportFraction: 1,
                                  onPageChanged: (val, _) {
                                    setState(() {
                                      currentPos = val;
                                      print("new index $val");
                                    });
                                  }
                              ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ...createBulletSlide(),
                              ],
                            ),
                          )

                        ],
                      ),
                    ],
                  ),
                );
              }
              return Text('false');
            }
        ),
      ),
    );
  }
}
