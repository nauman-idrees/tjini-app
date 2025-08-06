import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tjini_app/core/extensions.dart';
import 'package:tjini_app/ui/common/header_widget.dart';
import 'package:tjini_app/ui/common/image_widget.dart';
import 'package:tjini_app/ui/common/main_button.dart';
import 'package:tjini_app/ui/common/text_widget.dart';
import 'package:tjini_app/ui/resources/app_colors.dart';

import '../../core/enum.dart';
import '../common/circle_container.dart';
import '../common/round_action.dart';
import '../common/selection_item.dart';

class ParentProfileScreen extends StatelessWidget {
  const ParentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              HeaderWidget(),
              const Gap(20),
              Row(
                children: [
                  Material(
                    elevation: 5,
                    shape: const CircleBorder(),
                    child: CircleContainer(
                      width: 80,
                      height: 80,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ImageWidget(
                          imageSrc: "assets/ic_person.png",
                          type: ImageType.asset,
                        ),
                      ),
                    ),
                  ),
                  const Gap(5),
                  TextWidget(title: "Maman de"),
                  Spacer(),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 10,
                        ),
                        child: Material(
                          elevation: 5,
                          shape: const CircleBorder(),
                          child: CircleContainer(
                            width: 115,
                            height: 115,
                            borderWidth: 6,
                            child: Center(
                              child: TextWidget(
                                title: "10\nmin",
                                size: 18,
                                weight: FontWeight.w400,
                                align: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 15,
                        child: RoundAction(
                          icon: Icons.add,
                        ),
                      ),
                      Positioned(
                        left: 15,
                        child: RoundAction(
                          icon: Icons.remove,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Gap(30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 1.6,
                    child: LinearProgressIndicator(
                      value: 0.5,
                      color: AppColors.green,
                      minHeight: 15,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const Gap(5),
                  ImageWidget(
                    imageSrc: "assets/ic_scholar.png",
                    type: ImageType.asset,
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    children: [
                      ImageWidget(
                        imageSrc: "assets/ic_school.png",
                        type: ImageType.asset,
                      ),
                      const Gap(10),
                      TextWidget(title: "Nom de l'école"),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 1.8,
                    child: MainButton(
                      title: 'En court de préparation'.hardcoded(),
                      onPressed: () {},
                      textColor: Colors.black,
                      buttonColor: AppColors.grey,
                    ),
                  ),
                ],
              ),
              const Gap(30),
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 1.4,
                child: MainButton(
                  title: 'Notification Etablissement'.hardcoded(),
                  onPressed: () {},
                  textColor: Colors.white,
                  buttonColor: AppColors.primaryColor,
                ),
              ),
              const Gap(30),
              Column(
                children: [
                  ...ParentStatus.values.map((status) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: SelectionItem(
                        title: status.title(),
                        isSelected: status == ParentStatus.someoneElseIsComing,
                      ),
                    );
                  }),
                ],
              ),
              const Spacer(),
              MainButton(
                title: 'Connection'.hardcoded(),
                onPressed: () {},
                textColor: Colors.white,
                buttonColor: AppColors.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
