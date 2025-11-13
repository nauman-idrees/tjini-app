enum ImageType { asset, network }

enum ParentAction { someoneElseIsComing, pickUpOnCar, pickUpInside }

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
  insidePickup,
}

enum DispatcherMessageType {
  // Dispatcher side
  preparing,
  ready,
  collected,
  droppedOff,
  dispatcherDelayTime,
  additionalDelayTime,
  receptionCalling,
  carUnavailable,
}
