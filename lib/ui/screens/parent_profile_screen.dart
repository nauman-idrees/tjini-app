import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:tjini_app/core/di/locator.dart';
import 'package:tjini_app/core/extensions.dart';
import 'package:tjini_app/core/helper/shared_preferences_helper.dart';
import 'package:tjini_app/models/login_response.dart';
import 'package:tjini_app/models/notification_model.dart';
import 'package:tjini_app/provider/parent_provider.dart';
import 'package:tjini_app/provider/user_provider.dart';
import 'package:tjini_app/ui/common/header_widget.dart';
import 'package:tjini_app/ui/common/image_widget.dart';
import 'package:tjini_app/ui/common/main_button.dart';
import 'package:tjini_app/ui/common/text_widget.dart';
import 'package:tjini_app/ui/resources/app_colors.dart';
import '../../core/enum.dart';
import '../../models/user.dart';
import '../../provider/average_time_provider.dart';
import '../../provider/notification_provider.dart';
import '../common/circle_container.dart';
import '../common/round_action.dart';
import '../common/selection_item.dart';

bool isChangingTime = false;

class ParentProfileScreen extends HookWidget {
  const ParentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserProvider>().getUser();
    final avgProvider = Provider.of<AverageTimeProvider>(context);
    final parentProvider = context.watch<ParentProvider>();
    List<NotificationItem> notifications = parentProvider.notifications;
    List<User> relatedParents = parentProvider.relatedParents;
    final notificationProvider = Provider.of<NotificationProvider>(context);
    final selectedParent = useState<User?>(null);
    final activeAction = useState<ParentUIAction?>(null);
    final delayTime = useState<int>(5);
    useEffect(() {
      parentProvider.fetchInitialData();
      return null;
    }, []);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              HeaderWidget(
                logout: true,
              ),
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
                  TextWidget(title: "${user?.firstName}\n${user?.lastName}"),
                  const Spacer(),
                  if (notifications.showTimer())
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
                                  title: "${delayTime.value}\nmin",
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
                            onTap: () {
                              delayTime.value += 5;
                              activeAction.value = ParentUIAction.addTime;
                            },
                            icon: Icons.add,
                          ),
                        ),
                        Positioned(
                          left: 15,
                          child: RoundAction(
                            onTap: () {
                              activeAction.value = ParentUIAction.addTime;
                              if (delayTime.value > 5) {
                                delayTime.value -= 5;
                              }
                            },
                            icon: Icons.remove,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              const Gap(30),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     SizedBox(
              //       width: MediaQuery.sizeOf(context).width / 1.6,
              //       child: LinearProgressIndicator(
              //         value: 0.5,
              //         color: AppColors.green,
              //         minHeight: 15,
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //     ),
              //     const Gap(5),
              //     ImageWidget(
              //       imageSrc: "assets/ic_scholar.png",
              //       type: ImageType.asset,
              //     ),
              //   ],
              // ),
              Row(
                children: [
                  Column(
                    children: [
                      ImageWidget(
                        imageSrc: "assets/ic_school.png",
                        type: ImageType.asset,
                      ),
                      const Gap(10),
                      TextWidget(title: user?.school?.name ?? ""),
                    ],
                  ),
                  // !notifications.any(
                  //       (element) =>
                  //           element.type! == ParentMessageType.readyToGo.code,
                  //     )
                  //     ? SizedBox(
                  //         width: MediaQuery.sizeOf(context).width / 1.8,
                  //         child: MainButton(
                  //           title: 'En court de préparation'.hardcoded(),
                  //           onPressed: () async {
                  //             activeAction.value = null;
                  //             await parentProvider.performAction(
                  //               ParentUIAction.readyToGo,
                  //             );
                  //           },
                  //           textColor: Colors.black,
                  //           buttonColor: AppColors.grey,
                  //         ),
                  //       )
                  //     : SizedBox(),
                ],
              ),
              const Gap(30),
              notifications.showWhoComing()
                  ? Column(
                      children: [
                        Row(
                          children: [
                            TextWidget(
                              title: "Qui vient chercher l'enfant ?"
                                  .hardcoded(),
                              size: 20,
                              align: TextAlign.start,
                              weight: FontWeight.w600,
                            ),
                          ],
                        ),
                        Gap(5),
                        ...relatedParents.map((user) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              bottom: 10,
                            ),
                            child: SelectionItem(
                              title: user.relation ?? "",
                              isSelected: selectedParent.value?.id == user.id,
                              onTap: () {
                                selectedParent.value = user;
                                activeAction.value = ParentUIAction.whoComing;
                              },
                            ),
                          );
                        }),
                      ],
                    )
                  : notifications.showAdditionalAcitons()
                  ? Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          SelectionItem(
                            title: ParentAction.pickUpOnCar.title(),
                            isSelected:
                                activeAction.value ==
                                ParentUIAction.pickUpOnCar,
                            onTap: () {
                              activeAction.value = ParentUIAction.pickUpOnCar;
                            },
                          ),
                          Gap(10),
                          SelectionItem(
                            title: ParentAction.pickUpInside.title(),
                            isSelected:
                                activeAction.value ==
                                ParentUIAction.pickUpInside,
                            onTap: () {
                              activeAction.value = ParentUIAction.pickUpInside;
                            },
                          ),
                        ],
                      ),
                    )
                  : SizedBox.shrink(),
              const Gap(30),
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 1.4,

                child: MainButton(
                  isDisabled: activeAction.value == null,
                  title: 'Notification Etablissement'.hardcoded(),
                  onPressed: () async {
                    if (activeAction.value == ParentUIAction.addTime) {
                      parentProvider.addTime(minutes: delayTime.value);
                    }
                    if (activeAction.value == ParentUIAction.whoComing) {
                      if (selectedParent.value != null) {
                        parentProvider.selectWhoComing(
                          selectedUser: selectedParent.value!,
                        );
                      }
                    }

                    if (activeAction.value == ParentUIAction.pickUpOnCar) {
                      parentProvider.performAction(activeAction.value!);
                    }

                    if (activeAction.value == ParentUIAction.pickUpInside) {
                      parentProvider.performAction(activeAction.value!);
                    }
                    activeAction.value = null;
                  },
                  textColor: Colors.white,
                  buttonColor: AppColors.primaryColor,
                ),
              ),
              const Spacer(),
              if (notifications.showIAmHere())
                MainButton(
                  title: 'Je suis là'.hardcoded(),
                  onPressed: () async {
                    activeAction.value = null;
                    await parentProvider.performAction(ParentUIAction.iAmHere);
                  },
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
