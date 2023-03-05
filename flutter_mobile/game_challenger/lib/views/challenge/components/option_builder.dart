import 'package:flutter/material.dart';
import 'package:game_challenger/utils/my_colors.dart';
import 'package:game_challenger/views/challenge/challenge_view_model.dart';
import 'package:stacked/stacked.dart';

class OptionBuilder extends ViewModelWidget<ChallengeViewModel> {
  const OptionBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ChallengeViewModel viewModel) {
    return GestureDetector(
        onTap: () async {
          // await viewModel.nav.pushReplacementNamed(Routes.register);
          viewModel.locked();
        },
        child: Container(
          // width: double.infinity,
          height: 56,
          width: 320,
          constraints: const BoxConstraints(
              minHeight: 56,
              minWidth: 320,
              maxHeight: double.infinity,
              maxWidth: double.infinity),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1.5, color: MyColors.black),
              borderRadius: BorderRadius.circular(16)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "This is a choice",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.black),
              ),
              const SizedBox(
                width: 16,
              ),
              // Icon(
              //   Icons.check_circle,
              //   size: 24,
              //   color: const Color(0xff31cb00).withOpacity(0.9),
              // )
              Container(
                width: 24,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.red),
                child: const Icon(
                  Icons.close_rounded,
                  size: 16,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ));
  }
}
