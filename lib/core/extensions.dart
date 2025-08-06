import 'package:tjini_app/core/enum.dart';

extension StringExtension on String {
  String hardcoded() {
    return this;
  }
}

extension ParentStatusExtension on ParentStatus {
  String title() {
    switch (this) {
      case ParentStatus.someoneElseIsComing:
        return "Quelqu'un d'autre vient sla(e) récupèrer. ".hardcoded();
      case ParentStatus.pickUpOnCar:
        return "Pick up en voiture.".hardcoded();
      case ParentStatus.pickUpInside:
        return "Pick up à l'intérieur.".hardcoded();
    }
  }
}
