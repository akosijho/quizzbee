import 'package:game_challenger/app/app_view_model.dart';
import 'package:game_challenger/core/models/challenge.dart';
import 'package:game_challenger/utils/choice_checker.dart';

class ChallengeViewModel extends AppViewModel {
  bool isLocked = false;
  final Question challenge;

  int? index;

  bool correct = false;

  Map<String, dynamic>? myOptions;

  ChallengeViewModel({required this.challenge});

  void init() async {
    challenge.choice!.shuffle();
    notifyListeners();
  }

  void locked(Option o, int choiceIndex) {
    index = choiceIndex;
    print(index);
    if(isLocked  == false){
      if (challenge.answer == choiceChecker(challenge.choice!.indexOf(o))) {
        correct = true;
        isLocked = true;
        notifyListeners();
      } else {
        correct = false;
        isLocked = true;
        notifyListeners();
        return;
      }
    }else{
      return;
    }
  }
}
