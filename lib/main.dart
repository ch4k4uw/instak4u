import 'package:core/intl.dart' as core_intl;
import 'package:get_it/get_it.dart';
import 'package:presenter/intl.dart' as presenter_intl;
import 'package:core/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:instak4u/navigation/instak4u_route_information_parser.dart';
import 'package:instak4u/navigation/instak4u_router_delegate.dart';
import 'package:instak4u/url_strategy.dart';

import 'generated/l10n.dart';
import 'injectable.dart';

void main() {
  usePathUrlStrategy();
  runApp(
    AppTheme(
      home: Builder(
        builder: (context) {
          configureDependencies(context: context);
          configureDependencies(context: context);
          return const App();
        },
      ),
    ),
  );
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final Instak4uRouterDelegate _delegate = Instak4uRouterDelegate();
  final Instak4uRouteInformationParser _parser =
      Instak4uRouteInformationParser();
  BuildContext? _lastContext;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      routerDelegate: _delegate,
      routeInformationParser: _parser,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        presenter_intl.S.delegate,
        core_intl.S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        ...S.delegate.supportedLocales,
        ...core_intl.S.delegate.supportedLocales
      ],
      theme: AppTheme.of(context).data,
    );
  }
}
