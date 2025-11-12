import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:tjini_app/core/di/locator.dart';
import 'package:tjini_app/core/extensions.dart';
import 'package:tjini_app/core/helper/shared_preferences_helper.dart';
import 'package:tjini_app/models/login_response.dart';
import 'package:tjini_app/provider/parent_provider.dart';
import 'package:tjini_app/provider/user_provider.dart';
import 'package:tjini_app/ui/common/header_widget.dart';
import 'package:tjini_app/ui/common/image_widget.dart';
import 'package:tjini_app/ui/common/main_button.dart';
import 'package:tjini_app/ui/common/text_widget.dart';
import 'package:tjini_app/ui/resources/app_colors.dart';
import '../../core/enum.dart';
import '../../provider/average_time_provider.dart';
import '../../provider/notification_provider.dart';
import '../common/circle_container.dart';
import '../common/round_action.dart';
import '../common/selection_item.dart';

bool isChangingTime = false;
class ParentProfileScreen extends StatelessWidget {
  const ParentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserProvider>().getUser();
    final avgProvider  = Provider.of<AverageTimeProvider>(context);
    final parentProvider = Provider.of<ParentProvider>(context);
    final notificationProvider = Provider.of<NotificationProvider>(context);
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
                  TextWidget(title: "${user?.firstName}\n${user?.lastName}"),
                  const Spacer(),
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
                                title: "${avgProvider.time}\nmin",
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
                            isChangingTime = true;
                            avgProvider.increment();
                            },
                          icon: Icons.add,
                        ),
                      ),
                      Positioned(
                        left: 15,
                        child: RoundAction(
                          onTap: () {
                            isChangingTime = true;
                            avgProvider.decrement();
                            },
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
                  !notificationProvider.latestNotification.any((element) => element.type! == "ready-to-go",)
                  && !notificationProvider.latestNotification.any((element) => element.type! == "arrived",)
                      ? SizedBox(
                    width: MediaQuery.sizeOf(context).width / 1.8,
                    child: MainButton(
                      title: 'En court de préparation'.hardcoded(),
                      onPressed: () async{
                        LoginResponse? currentUser = await locator<SharedPreferencesHelper>().getCurrentUser();
                        if(currentUser != null) {
                          await notificationProvider.sendParentNotification(
                              "ready-to-go",
                              "Ready To Go",
                              currentUser.user!.id,
                              currentUser.token!
                          );
                        }
                      },
                      textColor: Colors.black,
                      buttonColor: AppColors.grey,
                    ),
                  ) : SizedBox(),
                ],
              ),
              const Gap(30),
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 1.4,
                child: MainButton(
                  title: 'Notification Etablissement'.hardcoded(),
                  onPressed: () async{
                    LoginResponse? currentUser = await locator<SharedPreferencesHelper>().getCurrentUser();
                    if(currentUser != null) {
                      if (parentProvider.selectedMainAction != null) {
                        await notificationProvider.sendParentNotification(
                            "who-coming",
                            "${parentProvider.selectedMainAction!.name} is coming",
                            currentUser.user!.id,
                            currentUser.token!
                        );
                        parentProvider.clearSelection();
                      }

                      if (parentProvider.selectedAction != null) {
                        await notificationProvider.sendParentNotification(
                            parentProvider.selectedAction == ParentAction.pickUpInside
                                ? "inside-pickup" : parentProvider.selectedAction == ParentAction.pickUpOnCar
                                ? "car-pickup" : "someone-else-coming",
                            parentProvider.selectedAction == ParentAction.pickUpInside
                                ? "Pickup inside"
                                : parentProvider.selectedAction == ParentAction.pickUpOnCar
                                ?  "Pickup by car"
                            : "Someone else is coming.",
                            currentUser.user!.id,
                            currentUser.token!
                        );
                        parentProvider.clearSelection();
                      }

                      if(isChangingTime){
                        if(!notificationProvider.latestNotification.any((element) => element.type! == "arrival-time",)){
                          await notificationProvider.sendParentNotification(
                              "arrival-time",
                              "I will arrive in ${avgProvider.time} min.",
                              currentUser.user!.id,
                              currentUser.token!
                          );
                        }else{
                          await notificationProvider.sendParentNotification(
                              "delay-time",
                              "I will be late for ${avgProvider.time} min.",
                              currentUser.user!.id,
                              currentUser.token!
                          );
                        }
                        avgProvider.reset();
                        isChangingTime = false;
                      }
                    }
                  },
                  textColor: Colors.white,
                  buttonColor: AppColors.primaryColor,
                ),
              ),
              const Gap(30),
              !notificationProvider.latestNotification.any((element) => element.type! == "who-coming",)
                  ? Column(
                children: [
                  ...MainParentAction.values.map((status) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: SelectionItem(
                        title: status.title(),
                        isSelected: parentProvider.isMainSelected(status),
                        onTap: () {
                          parentProvider.toggleMainSelection(status);
                        },
                      ),
                    );
                  }),
                ],
              ) : Column(
                children: [
                  ...ParentAction.values.map((status) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: SelectionItem(
                        title: status.title(),
                        isSelected: parentProvider.isSelected(status),
                        onTap: () {
                          parentProvider.toggleSelection(status);
                        },
                      ),
                    );
                  }),
                ],
              ),
              const Spacer(),
              MainButton(
                title: 'Je suis là'.hardcoded(),
                onPressed: () async{
                  LoginResponse? currentUser = await locator<SharedPreferencesHelper>().getCurrentUser();
                  if(currentUser != null) {
                    await notificationProvider.sendParentNotification(
                        "arrived",
                        "I'm here",
                        currentUser.user!.id,
                        currentUser.token!
                    );
                  }
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
