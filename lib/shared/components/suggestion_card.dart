import 'dart:math';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:the_specials_app/env/env.dart';
import 'package:the_specials_app/screens/suggestion_matchs/translate_suggestion_matchs.dart';
import 'package:the_specials_app/shared/blocs/likedislike_bloc.dart';
import 'package:the_specials_app/shared/blocs/suggestion_cards_bloc.dart';
import 'package:the_specials_app/shared/services/apis/consume_apis.dart';
import 'package:the_specials_app/shared/services/factory/like_dislike_factory.dart';
import 'package:the_specials_app/shared/state_management/logged_user_data/logged_user_data.dart';
import 'package:the_specials_app/shared/state_management/other_profile_data/other_profile_data.dart';
import 'package:the_specials_app/shared/state_management/user_data_profile/user_data_profile.dart';
import 'package:the_specials_app/shared/styles/buttons.dart';
import 'package:the_specials_app/shared/styles/colors.dart';
import 'package:the_specials_app/shared/values/routes.dart';
import '../state_management/suggestion_cards/suggestion_cards.dart';
import 'package:get/get.dart';

class SuggestionCards extends StatefulWidget {
  const SuggestionCards({Key? key, required this.suggestionCardsData}) : super(key: key);
  final SuggestionData suggestionCardsData;

  @override
  State<SuggestionCards> createState() => _SuggestionCardsState();
}
class _SuggestionCardsState extends State<SuggestionCards> {
  final LikeDislikeBloc _likeDislikeBloc = LikeDislikeBloc();
  final SuggestionCardsBloc _suggestionCardsBloc = SuggestionCardsBloc();
  final otherProfileUserDataController = Get.put<OtherProfileDataController>(OtherProfileDataController());

  final _service = ConsumeApisService();

  LoggedUserDataController loggedUserDataController = Get.put(LoggedUserDataController());
  final suggestionCardsController = Get.put<SuggestionCardsController>(SuggestionCardsController());
  late final SwipableStackController _controller;
  var currentPos = 0;
  CarouselController buttonCarouselController = CarouselController();

  void _listenController() => setState(() {});

  // SuggestionCardsController s = Get.put(SuggestionCardsController());

  likeOrDislike(String likeOrDislike) async {
    var params = LikeDislikeFactory(user_id: widget.suggestionCardsData!.id, type: likeOrDislike);
    suggestionCardsController.removeItemFromList(widget.suggestionCardsData!.id);
    _likeDislikeBloc.postLikeDislike(params);
  }
  transformAge() {
    DateTime currentDate = DateTime.now();
    String birthDateStr = widget.suggestionCardsData!.birthdate as String;
    DateTime? birthDate = DateTime.tryParse(birthDateStr);
    var year =  birthDate?.year;
    var month = birthDate?.month;
    var day = birthDate?.day;
    var age = currentDate.year - year!;
    if (currentDate.month < month! || (currentDate.month < month! == month && currentDate.day < day!)) {
      age--;
    }
    return age;
  }
  openOtherProfile() async {
    int userId = widget.suggestionCardsData.id as int;
    await _service.getOtherProfile(userId);
    // final addres = await ConsumeApisService().getAddresWithLatLng(queryParameters: { "latlng": '${otherProfileUserDataController.savedUserDataProfile?.data?.lat}, ${otherProfileUserDataController.savedUserDataProfile?.data?.lng}', "key": "AIzaSyBKHT84rPIDzgFPNQQmnDEEun9x61GV6GY"});
    // addres.results[0].address_components[3].long_name
    await otherProfileUserDataController.getProfileUserData();
    Navigator.pushNamed(context, RoutesApp.othersProfiles);
  }
  validateImageAndReturn() {
    var profilePicture = widget?.suggestionCardsData?.profilePicture;
    if(profilePicture!.isNotEmpty) {
      return NetworkImage('${Env.baseURLImage}${profilePicture?[0]?.path?.replaceAll(r"\", r"")}');
    } else {
      return const AssetImage(
        'assets/images/profile-picture.png',
      );
    }
  }
  createImageSlide () {
    return widget?.suggestionCardsData?.profilePicture?.map((item) => Container(
      child: Stack(
        children: [
          Center(
              child:
              Image.network(
                '${Env.baseURLImage}${item?.path}' as String, fit: BoxFit.cover, width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height,)),
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
    var profilePictures = widget?.suggestionCardsData?.profilePicture;
    profilePictures?.forEach((element) {
      int index = profilePictures.indexOf(element);
      a.add(
        Row(

          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 13,
                width: 30,
                decoration: BoxDecoration(
                  color: currentPos == index
                      ? DefaultColors.purpleBrand
                      : DefaultColors.greyMedium,
                ),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(''),
                ),
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
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = SwipableStackController()..addListener(_listenController);

  }
  @override
  void dispose() {
    super.dispose();
    _controller
      ..removeListener(_listenController)
      ..dispose();
  }
  @override
  Widget build(BuildContext context) =>
      Positioned.fill(
        child: Padding(
          padding: const EdgeInsets.all(0),

          child: SwipableStack(
            onSwipeCompleted: (index, direction) {
              final isRight = direction == SwipeDirection.right;
              final isLeft = direction == SwipeDirection.left;
              if(isRight) {
                likeOrDislike('like');
              } else if(isLeft) {
                likeOrDislike('dislike');

              }
            },
            detectableSwipeDirections: const {
              SwipeDirection.right,
              SwipeDirection.left,
            },
            horizontalSwipeThreshold: 0.1,
            verticalSwipeThreshold: 0.1,
            viewFraction: 0.5,
            controller: _controller,

            stackClipBehaviour: Clip.antiAlias,
            overlayBuilder: (context, properties) {
              final opacity = min(properties.swipeProgress, 1.0);
              final isRight = properties.direction == SwipeDirection.right;
              if(isRight){
                return Row(

                  children: [
                    Opacity(
                      opacity: isRight ? opacity : 0,
                      child: SvgPicture.asset('assets/images/like-stamp.svg'),
                    ),
                  ],
                );
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Opacity(
                    opacity: !isRight ? opacity : 0,
                    child: SvgPicture.asset(
                      'assets/images/nope-stamp.svg',

                    ),
                  ),
                ],
              );
            },
            builder: (BuildContext context, swipeProperty) {
              return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SafeArea(
                    child: Container(
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * 0.79,
                          decoration: BoxDecoration(

                            image: DecorationImage(
                              image:  validateImageAndReturn(),
                              fit: BoxFit.cover,
                              alignment: const Alignment(-0.3, 0),
                            ),
                          ),
                          child: Stack(
                            children: [
                              Stack(
                                children: [
                                  CarouselSlider(
                                    disableGesture: true,
                                    items: createImageSlide(),
                                    carouselController: buttonCarouselController,
                                    options: CarouselOptions(
                                        scrollPhysics: const NeverScrollableScrollPhysics(),
                                        height: MediaQuery.of(context).size.height,
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
                                    padding: const EdgeInsets.all(15),
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              ...createBulletSlide(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(height: 1),
                                    BlurryContainer(
                                      blur: 5,
                                      borderRadius: BorderRadius.circular(10),
                                      color: DefaultColors.greyMedium[1]!,

                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(

                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                openOtherProfile();
                                              },
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Flexible(
                                                        child: Text(
                                                          '${widget.suggestionCardsData.name}, ${transformAge()}',
                                                          style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 24,
                                                            fontWeight: FontWeight.w700,
                                                          ),
                                                          textAlign: TextAlign.left,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/images/mode_of_travel.svg',
                                                        width: 30,
                                                        height: 30,
                                                        color: Colors.white,
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Text(
                                                        '${widget.suggestionCardsData.distance?.toStringAsFixed(1)} ${kmFromYou.i18n}',
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),

                                            const SizedBox(height: 20),
                                            Row(

                                              children: [
                                                Flexible(
                                                  child: ButtonDislike(onPressed: () async {

                                                  }),
                                                ),
                                                const SizedBox(width: 10),
                                                Flexible(
                                                  child: ButtonLike(onPressed: () async {
                                                    _controller.next(swipeDirection: SwipeDirection.right,);

                                                    // likeOrDislike('like');
                                                  }),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                  )
              );
            },
          ),
        ),
      );

}
