import 'package:game_challenger/app/app_view_model.dart';

class ChallengeViewModel extends AppViewModel {
  bool isLocked = false;

  void locked() {
    isLocked = true;
    notifyListeners();
  }
}
