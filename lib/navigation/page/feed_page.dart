import 'package:flutter/material.dart';
import 'package:instak4u/feed/feed_screen.dart';

class FeedPage extends Page {
  const FeedPage() : super(key: const ValueKey(FeedPage));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return const FeedScreen.preview();
      },
    );
  }
}
