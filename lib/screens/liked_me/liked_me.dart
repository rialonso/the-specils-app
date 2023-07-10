import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:the_specials_app/env/env.dart';
import 'package:the_specials_app/screens/liked_me/liked_me_translate.dart';
import 'package:the_specials_app/shared/components/menu_logged/menu_logged.dart';
import 'package:the_specials_app/shared/components/not_load_itens/not_load_itens.dart';
import 'package:the_specials_app/shared/interfaces/responses/response_liked_me.dart';
import 'package:the_specials_app/shared/services/apis/consume_apis.dart';
import 'package:the_specials_app/shared/state_management/liked_me/liked_me.dart';
import 'package:the_specials_app/shared/state_management/logged_user_data/logged_user_data.dart';
import 'package:the_specials_app/shared/state_management/user_data_profile/user_data_profile.dart';
import 'package:the_specials_app/shared/styles/colors.dart';
import 'package:get/get.dart';

class LikedMe extends StatefulWidget {
  const LikedMe({Key? key}) : super(key: key);

  @override
  State<LikedMe> createState() => _LikedMeState();
}
class _LikedMeState extends State<LikedMe> {
  final _service = ConsumeApisService();
  final likedMeController = Get.put<LikedMeController>(LikedMeController());
  final loggedUserDataController = Get.put<LoggedUserDataController>(LoggedUserDataController());


  waitGetLikedMe() async {
    await _service.getLikedMe();
    likedMeController.getLikedMe();
  }
  changeBlurLiked() {
    double? blur;
    if(loggedUserDataController.savedUserData?.data?.planType == 'free') {
      blur = 5;
    } else {
      blur = 0;
    }
    return blur;
  }
  calculateHoursAgo(String updateAt ) {
    DateTime? dateLiked = DateTime.tryParse(updateAt);
    DateTime currentDate = DateTime.now();
    var diffInMs = dateLiked!.month - currentDate.month;
    var diffInDays = dateLiked.day - currentDate.day;
    var diffInHours = dateLiked.hour - currentDate.hour;
    var diffInMinutes = dateLiked.minute - currentDate.minute;

    if (dateLiked.compareTo(currentDate) == 0 ) {
      if (diffInHours < 1) {
        if (diffInMinutes == 1 ) {
          return '$diffInMinutes ${minute.i18n} ${ago.i18n}';

        }
        return '$diffInMinutes ${minutes.i18n} ${ago.i18n}';
      }
      if (diffInHours == 1) {
        return '$diffInHours ${hour.i18n} ${ago.i18n}';
      }
      return '$diffInHours ${hours.i18n} ${ago.i18n}';
    } else {
      if (diffInDays == 1) {
        return '$diffInDays ${day.i18n} ${ago.i18n}';
      }
      return '$diffInDays ${days.i18n} ${ago.i18n}';
    }
  }
  createLikedMeData (dynamic likedData) {
    List<Widget> suggestionCardsWidget = [];
    var allCards = likedData.data;
    print(allCards.length);
    if(allCards == null || allCards.length == 0) {
      suggestionCardsWidget.add(
          NotLoadItens(messageToShow: notLoadCardsLikedMe.i18n)
      );
      return  suggestionCardsWidget;

    }
    allCards.forEach((likedMeCard) {
      return suggestionCardsWidget.add(
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: MediaQuery.of(context).size.width * 0.7,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(

              image: DecorationImage(
                image: NetworkImage('${Env.baseURLImage}${likedMeCard.user?.profilePicture?[0]?.path?.replaceAll(r"\", r"")}') ,
                fit: BoxFit.cover,
                alignment: const Alignment(-0.3, 0),
              ),
            ),
            child: Stack(
              children: [
                Padding(

                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(''),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.2,
                        width: MediaQuery.of(context).size.width,
                        child: BlurryContainer(
                          blur: 5,
                          borderRadius: BorderRadius.circular(10),
                          color: DefaultColors.greyMedium[1]!,
                           child: Padding(
                             padding: const EdgeInsets.all(10.0),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                               children: [
                                 Text(
                                   likedMeCard?.user?.name != null ? likedMeCard?.user?.name : '',
                                   style: const TextStyle(
                                     color: Colors.white,
                                     fontSize: 15,
                                     fontWeight: FontWeight.w600
                                   ),
                                   textAlign: TextAlign.start,
                                 ),
                                 Text(
                                   calculateHoursAgo(likedMeCard?.updatedAt as String),
                                   style: const TextStyle(
                                     color: Colors.white,
                                     fontSize: 15,
                                     fontWeight: FontWeight.w600,
                                   ),
                                 ),
                               ],
                             ),

                           ),
                        ),
                      ),
                    ],
                  ),
                ),
                BlurryContainer(
                    blur: changeBlurLiked(),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width * 0.7,
                      width: MediaQuery.of(context).size.width,
                      child: const Text(''),
                    ),
                ),
              ],
            ),
          ),

        ),
      );
    });
    return  suggestionCardsWidget;
  }
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    waitGetLikedMe();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
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
        body:  Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    likedMeTitle.i18n,
                    textDirection: TextDirection.ltr,
                    style: const TextStyle(
                      fontSize: 30,
                      color: DefaultColors.greyMedium,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GetBuilder<LikedMeController>(
                      builder: (_) => likedMeController.likedMeUpdated.value
                          ? Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: createLikedMeData(likedMeController.savedLikedMe),
                          )
                          : Text('akskasksksaaskask')
                  ),
                ),
              ],
            ),
          ),


        ),
        bottomNavigationBar:  const MenuLogged(routeLikedMe: true),
      ),
    );
  }
}
