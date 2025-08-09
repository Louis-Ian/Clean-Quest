import 'family.dart';

sealed class WelcomeState {
  const WelcomeState();
}

class WelcomeInitial extends WelcomeState {
  const WelcomeInitial();
}

class WelcomeLoading extends WelcomeState {
  const WelcomeLoading();
}

class WelcomeSuccess extends WelcomeState {
  final Family family;

  const WelcomeSuccess(this.family);
}

class WelcomeError extends WelcomeState {
  final String message;

  const WelcomeError(this.message);
}
