import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/models/challenge.dart';
import '../../../utils/choice_checker.dart';
import '../../../utils/my_colors.dart';
import '../next_view_model.dart';

class ChoiceBuilder extends ViewModelWidget<NextViewModel> {
  const ChoiceBuilder({required this.choice, 
  required this.answer,
  required this.q,
  super.key});

  final Option choice;
  final String answer;
  final Question q;

  @override
  Widget build(BuildContext context, NextViewModel viewModel) {
    return Container(
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
            choice.choices!,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.black),
          ),
          const SizedBox(
            width: 16,
          ),
           answer == choiceChecker(q.choice!.indexOf(choice))
              ? Icon(
            Icons.check_circle,
            size: 24,
            color: const Color(0xff31cb00).withOpacity(0.9),
          )
              : Container(
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
        ] 
      ),
    );
  }
}
