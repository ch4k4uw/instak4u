import 'package:core/intl.dart' as core_intl;
import 'package:core/ui.dart';
import 'package:instak4u/event/event_details_screen.dart';
import 'package:instak4u/navigation/instak4u_route_information_parser.dart';
import 'package:instak4u/navigation/instak4u_router_delegate.dart';
import 'package:instak4u/sign_in/sign_in_screen.dart';
import 'package:instak4u/sign_up/sign_up_screen.dart';
import 'package:instak4u/splash/splash_screen_screen.dart';
import 'package:instak4u/url_strategy.dart';
import 'package:provider/provider.dart';
import 'package:core/common.dart';
import 'package:core/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:instak4u/main_view_model.dart';

import 'feed/feed_screen.dart';
import 'generated/l10n.dart';
import 'injectable.dart';

void main() {
  print("here1");
  usePathUrlStrategy();
  configureDependencies();
  print("here2");
  runApp(
    AppTheme(
      home: Builder(
        builder: (_) => const App(),
      ),
    ),
  );
}

/*class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          S.delegate,
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
        home: const SplashScreenScreen.preview(),
    );
  }
}
*/

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final Instak4uRouterDelegate _delegate = Instak4uRouterDelegate();
  final Instak4uRouteInformationParser _parser =
      Instak4uRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    print("here");
    return MaterialApp.router(
      title: 'Flutter Demo',
      routerDelegate: _delegate,
      routeInformationParser: _parser,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
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
