// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i8;
import 'package:flutter/material.dart';
import 'package:master2/core/models/challenge.dart' as _i7;
import 'package:master2/views/finish/finiish.dart' as _i5;
import 'package:master2/views/next/next.dart' as _i3;
import 'package:master2/views/next_one/next_one.dart' as _i4;
import 'package:master2/views/start/start.dart' as _i2;
import 'package:stacked/src/code_generation/router_annotation/transitions_builders.dart'
    as _i6;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i9;

class Routes {
  static const start = '/';

  static const next = '/Next';

  static const next_one = '/next-one';

  static const finish = '/Finish';

  static const all = <String>{
    start,
    next,
    next_one,
    finish,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.start,
      page: _i2.Start,
    ),
    _i1.RouteDef(
      Routes.next,
      page: _i3.Next,
    ),
    _i1.RouteDef(
      Routes.next_one,
      page: _i4.NextOne,
    ),
    _i1.RouteDef(
      Routes.finish,
      page: _i5.Finish,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.Start: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i2.Start(),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i6.TransitionsBuilders.slideLeft,
      );
    },
    _i3.Next: (data) {
      final args = data.getArgs<NextArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            _i3.Next(q: args.q, key: args.key),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i6.TransitionsBuilders.slideLeft,
      );
    },
    _i4.NextOne: (data) {
      final args = data.getArgs<NextOneArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            _i4.NextOne(q: args.q, key: args.key),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i6.TransitionsBuilders.slideLeft,
      );
    },
    _i5.Finish: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i5.Finish(),
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

class NextArguments {
  const NextArguments({
    required this.q,
    this.key,
  });

  final _i7.Question q;

  final _i8.Key? key;

  @override
  String toString() {
    return '{"q": "$q", "key": "$key"}';
  }
}

class NextOneArguments {
  const NextOneArguments({
    required this.q,
    this.key,
  });

  final _i7.Question q;

  final _i8.Key? key;

  @override
  String toString() {
    return '{"q": "$q", "key": "$key"}';
  }
}

extension NavigatorStateExtension on _i9.NavigationService {
  Future<dynamic> navigateToStart([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.start,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNext({
    required _i7.Question q,
    _i8.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.next,
        arguments: NextArguments(q: q, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNext_one({
    required _i7.Question q,
    _i8.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.next_one,
        arguments: NextOneArguments(q: q, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToFinish([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.finish,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStart([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.start,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithNext({
    required _i7.Question q,
    _i8.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.next,
        arguments: NextArguments(q: q, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithNext_one({
    required _i7.Question q,
    _i8.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.next_one,
        arguments: NextOneArguments(q: q, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithFinish([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.finish,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
