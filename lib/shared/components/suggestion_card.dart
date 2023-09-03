import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  // SuggestionCardsController s = Get.put(SuggestionCardsController());

  likeOrDislike(String likeOrDislike) async {
    var params = LikeDislikeFactory(user_id: widget.suggestionCardsData!.id, type: likeOrDislike);
     _likeDislikeBloc.postLikeDislike(params);
     suggestionCardsController.removeItemFromList(widget.suggestionCardsData!.id);
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
  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(20),
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
      child: Padding(
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
                            likeOrDislike('dislike');
                            // suggestionCardsController.getSuggestionCardsToShow();
                            // suggestionCardsController.removeLastCard();
                          }),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: ButtonLike(onPressed: () async {
                            likeOrDislike('like');
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
    ),
  );
}
