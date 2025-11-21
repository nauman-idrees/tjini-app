enum ImageType { asset, network }

enum ParentAction { pickUpOnCar, pickUpInside }

enum MainParentAction { mother, father, familyMember }

enum DispatcherAction {
  receptionCallingYou,
  pickUpCarUnavailable,
  additionalDelay,
}

enum ToastType {
  message,
  error,
  success,
}

enum UserRole {
  parent,
  dispatcher,
  viewer,
}

enum ParentMessageType {
  // Parent side
  whoComing,
  delayTime,
  arrivalTime,
  arrived,
  carPickup,
  pickupInside,
  schoolEnd,
  schoolStart,
  readyToGo,
  iAmHere,
}

enum DispatcherMessageType {
  // Dispatcher side
  preparing,
  ready,
  collected,
  dropped,
  dispatcherDelayTime,
  additionalDelayTime,
  receptionCalling,
  carUnavailable,
}
