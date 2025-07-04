import 'package:flutter_riverpod/flutter_riverpod.dart';

final welcomeViewModelProvider = NotifierProvider<WelcomeViewModel, void>(() => WelcomeViewModel());

class WelcomeViewModel extends Notifier<void> {
  @override
  void build() {
    // No state, but could be used to init logic
  }

  void createFamily() {
    //TODO: business logic, service call, etc.
  }

  void joinFamily() {
    //TODO: business logic
  }
}
