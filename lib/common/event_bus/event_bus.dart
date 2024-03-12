part 'event/personal_setting.dart';

class RemoveCollaboratorEventBus {
  const RemoveCollaboratorEventBus();
}

class ChangeRSMPushTab {
  final int index;
  const ChangeRSMPushTab(this.index);
}
