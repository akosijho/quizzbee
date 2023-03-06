// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i9;
import 'package:flutter/material.dart';
import 'package:game_challenger/core/models/challenge.dart' as _i7;
import 'package:game_challenger/core/models/player.dart' as _i8;
import 'package:game_challenger/views/challenge/challenge.dart' as _i2;
import 'package:game_challenger/views/new_challenge/challenge.dart' as _i3;
import 'package:game_challenger/views/registration/register.dart' as _i5;
import 'package:game_challenger/views/waiting_room/waiting.dart' as _i4;
import 'package:stacked/src/code_generation/router_annotation/transitions_builders.dart'
    as _i6;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i10;

class Routes {
  static const challenge = '/Challenge';

  static const new_challenge = '/new-challenge';

  static const wait = '/Waitng';

  static const register = '/';

  static const all = <String>{
    challenge,
    new_challenge,
    wait,
    register,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.challenge,
      page: _i2.Challenge,
    ),
    _i1.RouteDef(
      Routes.new_challenge,
      page: _i3.NewChallenge,
    ),
    _i1.RouteDef(
      Routes.wait,
      page: _i4.Waitng,
    ),
    _i1.RouteDef(
      Routes.register,
      page: _i5.Register,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.Challenge: (data) {
      final args = data.getArgs<ChallengeArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => _i2.Challenge(
            challenge: args.challenge, player: args.player, key: args.key),
        settings: data,
        transitionsBuilder: data.transition ?? _i6.TransitionsBuilders.zoomIn,
      );
    },
    _i3.NewChallenge: (data) {
      final args = data.getArgs<NewChallengeArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            _i3.NewChallenge(
                challenge: args.challenge, player: args.player, key: args.key),
        settings: data,
        transitionsBuilder: data.transition ?? _i6.TransitionsBuilders.zoomIn,
      );
    },
    _i4.Waitng: (data) {
      final args = data.getArgs<WaitngArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            _i4.Waitng(player: args.player, q: args.q, key: args.key),
        settings: data,
        transitionsBuilder: data.transition ?? _i6.TransitionsBuilders.zoomIn,
      );
    },
    _i5.Register: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i5.Register(),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i6.TransitionsBuilders.slideLeft,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class ChallengeArguments {
  const ChallengeArguments({
    required this.challenge,
    required this.player,
    this.key,
  });

  final _i7.Question challenge;

  final _i8.Player player;

  final _i9.Key? key;

  @override
  String toString() {
    return '{"challenge": "$challenge", "player": "$player", "key": "$key"}';
  }
}

class NewChallengeArguments {
  const NewChallengeArguments({
    required this.challenge,
    required this.player,
    this.key,
  });

  final _i7.Question challenge;

  final _i8.Player player;

  final _i9.Key? key;

  @override
  String toString() {
    return '{"challenge": "$challenge", "player": "$player", "key": "$key"}';
  }
}

class WaitngArguments {
  const WaitngArguments({
    required this.player,
    required this.q,
    this.key,
  });

  final _i8.Player player;

  final _i7.Question q;

  final _i9.Key? key;

  @override
  String toString() {
    return '{"player": "$player", "q": "$q", "key": "$key"}';
  }
}

extension NavigatorStateExtension on _i10.NavigationService {
  Future<dynamic> navigateToChallenge({
    required _i7.Question challenge,
    required _i8.Player player,
    _i9.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.challenge,
        arguments:
            ChallengeArguments(challenge: challenge, player: player, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNew_challenge({
    required _i7.Question challenge,
    required _i8.Player player,
    _i9.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.new_challenge,
        arguments: NewChallengeArguments(
            challenge: challenge, player: player, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToWait({
    required _i8.Player player,
    required _i7.Question q,
    _i9.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.wait,
        arguments: WaitngArguments(player: player, q: q, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToRegister([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.register,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithChallenge({
    required _i7.Question challenge,
    required _i8.Player player,
    _i9.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.challenge,
        arguments:
            ChallengeArguments(challenge: challenge, player: player, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithNew_challenge({
    required _i7.Question challenge,
    required _i8.Player player,
    _i9.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.new_challenge,
        arguments: NewChallengeArguments(
            challenge: challenge, player: player, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithWait({
    required _i8.Player player,
    required _i7.Question q,
    _i9.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.wait,
        arguments: WaitngArguments(player: player, q: q, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithRegister([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.register,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
