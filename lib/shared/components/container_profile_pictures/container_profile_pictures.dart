import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_specials_app/shared/components/card_pictures_profile/card_pictures_profile.dart';
import 'package:the_specials_app/shared/components/container_profile_pictures/container_profile_pictures_translate.dart';
import 'package:the_specials_app/shared/interfaces/local_interfaces/edit_pictures_asset.dart';
import 'package:the_specials_app/shared/state_management/user_data_profile/user_data_profile.dart';
import 'package:the_specials_app/shared/styles/colors.dart';
import 'package:the_specials_app/shared/values/routes.dart';

class ContainerProfilePictures extends StatefulWidget {
  const ContainerProfilePictures({Key? key}) : super(key: key);

  @override
  State<ContainerProfilePictures> createState() => _ContainerProfilePicturesState();
}

class _ContainerProfilePicturesState extends State<ContainerProfilePictures> {
  final profileUserDataController = Get.put<UserDataProfileController>(UserDataProfileController());

  validatePicture(pictures, index) {

    if(pictures.asMap().containsKey(index)) {
      return pictures?[index].path?.replaceAll(r"\", r"") as String;
    }
    return '';
  }
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              pictureTitle.i18n,
              style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: DefaultColors.greyMedium
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit_rounded),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              color: DefaultColors.greyMedium,
              iconSize: 25,
              onPressed: () {
                Navigator.pushNamed(context, RoutesApp.editPictures);
              },
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: CardPicturesProfile(
                            onPressed: () {

                            },
                            picture: ImageAsset(
                              imagePath: validatePicture(
                                  profileUserDataController?.savedUserDataProfile?.data?.profilePicture,
                                  0
                              ),
                                imageType: 'network'
                            ),
                          ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                          child: CardPicturesProfile(
                            onPressed: () {},
                            picture: ImageAsset(
                              imagePath: validatePicture(
                                  profileUserDataController?.savedUserDataProfile?.data?.profilePicture,
                                  1
                              ),
                                imageType: 'network'
                            ),
                          ),
                      ),
                      const SizedBox(width: 10),

                      Flexible(
                        child: CardPicturesProfile(
                          onPressed: () {},
                          picture: ImageAsset(
                            imagePath: validatePicture(
                                profileUserDataController?.savedUserDataProfile?.data?.profilePicture,
                                2
                            ),
                              imageType: 'network'
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: CardPicturesProfile(
                          onPressed: () {},
                          picture: ImageAsset(
                            imagePath: validatePicture(
                                profileUserDataController?.savedUserDataProfile?.data?.profilePicture,
                                3
                            ),
                              imageType: 'network'
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      Flexible(
                        child: CardPicturesProfile(
                          onPressed: () {},
                          picture: ImageAsset(
                            imagePath: validatePicture(
                                profileUserDataController?.savedUserDataProfile?.data?.profilePicture,
                                4
                            ),
                              imageType: 'network'
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      Flexible(
                        child: CardPicturesProfile(
                          onPressed: () {},
                          picture: ImageAsset(
                            imagePath: validatePicture(
                                profileUserDataController?.savedUserDataProfile?.data?.profilePicture,
                                5
                            ),
                              imageType: 'network'
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )

        )
      ],
    );
  }
}
