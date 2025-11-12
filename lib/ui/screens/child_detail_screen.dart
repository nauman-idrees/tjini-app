import 'package:flutter/material.dart';
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

class ChildDetailScreen extends StatelessWidget {
  const ChildDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dispatcherProvider = Provider.of<DispatcherProvider>(context);
    final avgProvider = Provider.of<AverageTimeProvider>(context);
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
                    child: TextWidget(title: "Nom de l’école"),
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
                              onTap: () => avgProvider.increment(),
                              icon: Icons.add,
                            ),
                          ),
                          Positioned(
                            left: 15,
                            child: RoundAction(
                              onTap: () => avgProvider.decrement(),
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
                  children: [
                    Spacer(),
                    ...ParentStatus.values.map((status) {
                      return GestureDetector(
                        onTap: () => dispatcherProvider.toggleStudentSelection(status),
                        child: Container(
                          width: 30,
                          height: 30,
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
                              color: dispatcherProvider.selectedStudentAction == status ? Colors.green : Colors.white,
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
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
              Gap(10),
              MainButton(
                title: 'Parent de notification'.hardcoded(),
                buttonColor: Colors.black,
                onPressed: () {},
              ),
              Gap(10),
              Column(
                children: [
                  ...DispatcherAction.values.map((status) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: SelectionItem(
                        title: status.title(),
                        isSelected: dispatcherProvider.isSelected(status),
                        onTap: () {
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
