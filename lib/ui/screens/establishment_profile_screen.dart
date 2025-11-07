import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tjini_app/core/enum.dart';
import 'package:tjini_app/core/extensions.dart';
import 'package:tjini_app/ui/common/circle_container.dart';
import 'package:tjini_app/ui/common/header_widget.dart';
import 'package:tjini_app/ui/common/image_widget.dart';
import 'package:tjini_app/ui/common/main_button.dart';
import 'package:tjini_app/ui/common/round_action.dart';
import 'package:tjini_app/ui/common/selection_item.dart';
import 'package:tjini_app/ui/common/text_widget.dart';
import 'package:tjini_app/ui/resources/app_colors.dart';

import 'child_detail_screen.dart';

class EstablishmentProfileScreen extends StatelessWidget {
  const EstablishmentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              HeaderWidget(),
              Gap(20),
              Row(
                children: [
                  Material(
                    elevation: 5,
                    shape: CircleBorder(),
                    child: CircleContainer(
                      width: 80,
                      height: 80,
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: ImageWidget(
                          imageSrc: "assets/ic_school.png",
                          type: ImageType.asset,
                        ),
                      ),
                    ),
                  ),
                  Gap(5),
                  SizedBox(
                    width: 70,
                    child: TextWidget(title: "Nom de l’école"),
                  ),
                  Spacer(),
                  // Column(
                  //   children: [
                  //     Stack(
                  //       alignment: Alignment.center,
                  //       children: [
                  //         Padding(
                  //           padding: EdgeInsets.symmetric(
                  //             horizontal: 25,
                  //             vertical: 10,
                  //           ),
                  //           child: Material(
                  //             elevation: 5,
                  //             shape: CircleBorder(),
                  //             child: CircleContainer(
                  //               width: 115,
                  //               height: 115,
                  //               borderWidth: 6,
                  //               child: Center(
                  //                 child: TextWidget(
                  //                   title: "10\nmin",
                  //                   size: 18,
                  //                   weight: FontWeight.w400,
                  //                   align: TextAlign.center,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         Positioned(
                  //           right: 15,
                  //           child: RoundAction(
                  //             icon: Icons.add,
                  //           ),
                  //         ),
                  //         Positioned(
                  //           left: 15,
                  //           child: RoundAction(
                  //             icon: Icons.remove,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     TextWidget(title: "Temps moyen de collecte.".hardcoded()),
                  //   ],
                  // ),
                ],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.67,
                child: Scrollbar(
                  thumbVisibility: true,
                  trackVisibility: true,
                  radius: Radius.circular(20),
                  child: ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemBuilder: (_, index) {
                      final parent = mockParents[index];
                      return ParentListingTile(
                          parent: parent,
                        onTap: () => Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ChildDetailScreen(),
                        ),
                        ),
                      );
                    },

                    itemCount: mockParents.length,
                  ),
                ),
              ),
              //Gap(30),
              // MainButton(
              //   title: 'Parent de notification'.hardcoded(),
              //   buttonColor: Colors.black,
              //   onPressed: () {},
              // ),
              // Gap(10),
              // Column(
              //   children: [
              //     ...DispatcherAction.values.map((status) {
              //       return Padding(
              //         padding: const EdgeInsets.only(left: 20),
              //         child: SelectionItem(
              //           title: status.title(),
              //           isSelected:
              //               status == DispatcherAction.receptionCallingYou,
              //         ),
              //       );
              //     }),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class ParentListingTile extends StatelessWidget {
  const ParentListingTile({
    super.key,
    required this.parent,
    this.onTap,
  });

  final Parent parent;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? (){},
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Material(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                color: AppColors.grey.withValues(alpha: 0.5),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Material(
                        elevation: 5,
                        shape: const CircleBorder(),
      
                        child: CircleContainer(
                          width: 30,
                          height: 30,
                          borderWidth: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ImageWidget(
                              imageSrc: "assets/ic_person.png",
                              type: ImageType.asset,
                            ),
                          ),
                        ),
                      ),
                      Gap(5),
                      TextWidget(
                        title: parent.name,
                        size: 14,
                        weight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      Spacer(),
                      ...ParentStatus.values.map((status) {
                        return Container(
                          width: 30,
                          height: 30,
                          padding: EdgeInsets.all(2),
                          margin: EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: status == parent.status
                                  ? AppColors.green
                                  : null,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              Material(
                elevation: 5,
                shape: CircleBorder(),
                child: CircleContainer(
                  height: 55,
                  width: 55,
                  borderWidth: 3,
                  borderColor: getColor(parent.time),
                  child: Center(
                    child: TextWidget(
                      title: "${parent.time}\nmin",
                      align: TextAlign.center,
                      size: 14,
                      weight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: List.generate(
                ParentStatus.values.length,
                (index) {
                  return TextWidget(
                    title:
                        "${ParentStatus.values[index].title()}${index != ParentStatus.values.length - 1 ? " | " : ""}",
                    size: 10,
                    weight: FontWeight.w500,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  getColor(String time) {
    if (time == "5") {
      return AppColors.green;
    } else if (time == "10") {
      return Colors.yellow;
    } else if (time == "15") {
      return Colors.red;
    }
  }
}

class Parent {
  final String name;
  final ParentStatus status;
  final String time;

  Parent({
    required this.name,
    required this.status,
    required this.time,
  });
}

final List<Parent> mockParents = List.generate(10, (index) {
  final statusIndex = index % ParentStatus.values.length;
  final status = ParentStatus.values[statusIndex];
  return Parent(
    name: 'Parent ${index + 1}',
    status: status,
    time: '${(index + 1) * 5}', // Example time
  );
});

enum ParentStatus {
  ongoing,
  ready,
  collected,
}

extension ParentStatusExtension on ParentStatus {
  String title() {
    return switch (this) {
      ParentStatus.ongoing => "En court".hardcoded(),
      ParentStatus.ready => "PRÊT".hardcoded(),
      ParentStatus.collected => "Collecté".hardcoded(),
    };
  }
}
