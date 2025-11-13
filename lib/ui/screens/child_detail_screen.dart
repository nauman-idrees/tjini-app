import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:tjini_app/core/extensions.dart';
import 'package:tjini_app/provider/average_time_provider.dart';
import '../../core/enum.dart';
import '../../provider/dispatcher_provider.dart';
import '../common/circle_container.dart';
import '../common/header_widget.dart';
import '../common/image_widget.dart';
import '../common/main_button.dart';
import '../common/round_action.dart';
import '../common/selection_item.dart';
import '../common/text_widget.dart';
import 'establishment_profile_screen.dart';

class ChildDetailScreen extends HookWidget {
  const ChildDetailScreen({super.key, required this.dispatcheeId});

  final int dispatcheeId;

  @override
  Widget build(BuildContext context) {
    final dispatcherProvider = context.watch<DispatcherProvider>();
    final selectedStatus = useState<ParentStatus?>(null);
    final dispatcheeDetails = dispatcherProvider.dispatchees.firstWhere(
      (item) => item.id == dispatcheeId,
    );

    final activeAction = useState<DispatcherUIAction?>(null);
    final delayTime = useState<int>(5);

    useEffect(() {
      selectedStatus.value = ParentStatus.values.firstWhere(
        (status) => status.name == dispatcheeDetails.status,
        orElse: () => ParentStatus.preparing,
      );
      return () {};
    }, [dispatcheeDetails.status]);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              HeaderWidget(
                isChildView: true,
                onTap: () => Navigator.pop(context),
              ),
              Gap(20),
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
                  Gap(5),
                  SizedBox(
                    width: 70,
                    child: TextWidget(
                      title:
                          dispatcheeDetails.user.firstName +
                          " " +
                          dispatcheeDetails.user.lastName,
                    ),
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 10,
                            ),
                            child: Material(
                              elevation: 5,
                              shape: CircleBorder(),
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
                                activeAction.value =
                                    DispatcherUIAction.delayTimer;
                                delayTime.value += 5;
                              },
                              icon: Icons.add,
                            ),
                          ),
                          Positioned(
                            left: 15,
                            child: RoundAction(
                              onTap: () {
                                activeAction.value =
                                    DispatcherUIAction.delayTimer;
                                if (delayTime.value > 5) {
                                  delayTime.value -= 5;
                                }
                              },
                              icon: Icons.remove,
                            ),
                          ),
                        ],
                      ),
                      TextWidget(title: "Temps moyen de collecte.".hardcoded()),
                    ],
                  ),
                ],
              ),
              Gap(30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ...ParentStatus.values.map((status) {
                      return GestureDetector(
                        onTap: () {
                          if (status == ParentStatus.collected) {
                            activeAction.value =
                                DispatcherUIAction.childCollected;
                            selectedStatus.value = status;
                          }
                          if (status == ParentStatus.ready) {
                            activeAction.value = DispatcherUIAction.childReady;
                            selectedStatus.value = status;
                          }
                          if (status == ParentStatus.preparing) {
                            activeAction.value =
                                DispatcherUIAction.childOngoing;
                            selectedStatus.value = status;
                          }
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              padding: EdgeInsets.all(2),
                              margin: EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0.2, 1),
                                    color: Colors.grey,
                                    blurRadius: 2,
                                    spreadRadius: 0.3,
                                  ),
                                ],
                              ),
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: selectedStatus.value == status
                                      ? Colors.green
                                      : Colors.white,
                                ),
                              ),
                            ),
                            Gap(5),
                            TextWidget(
                              title: "${status.title()}",
                              size: 15,
                              weight: FontWeight.w500,
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
              Gap(10),
              MainButton(
                isDisabled: activeAction.value == null,
                title: 'Parent de notification'.hardcoded(),
                buttonColor: Colors.black,
                onPressed: () {
                  if (activeAction.value == DispatcherUIAction.delayTimer) {
                    dispatcherProvider.performAction(
                      activeAction.value!,
                      dispatcheeDetails.user.id,
                      delayMinutes: delayTime.value,
                    );
                  } else {
                    dispatcherProvider.performAction(
                      activeAction.value!,
                      dispatcheeDetails.user.id,
                    );
                  }
                  activeAction.value = null;
                },
              ),
              Gap(10),
              Column(
                children: [
                  ...DispatcherAction.values.map((status) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20, bottom: 10),
                      child: SelectionItem(
                        title: status.title(),
                        isSelected: dispatcherProvider.isSelected(status),
                        onTap: () {
                          if (status == DispatcherAction.receptionCallingYou) {
                            activeAction.value =
                                DispatcherUIAction.receptionCallingYou;
                          }
                          if (status == DispatcherAction.pickUpCarUnavailable) {
                            activeAction.value =
                                DispatcherUIAction.pickUpNotAvailable;
                          }
                          if (status == DispatcherAction.additionalDelay) {
                            activeAction.value =
                                DispatcherUIAction.additionalDelay;
                          }
                          dispatcherProvider.toggleSelection(status);
                        },
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DispatcherUIAction {
  receptionCallingYou,
  pickUpNotAvailable,
  childOngoing,
  childReady,
  childCollected,
  delayTimer,
  additionalDelay,
  pickUpOnCar,
}
