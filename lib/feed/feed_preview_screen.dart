import 'package:flutter/material.dart';
import 'package:presenter/common.dart';
import 'package:presenter/feed.dart';

class FeedPreviewScreen extends StatelessWidget {
  final Widget Function(UserView, List<EventHeadView>) builder;
  const FeedPreviewScreen({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final date = DateTime.now();
    final events = <EventHeadView>[
      EventHeadView(
        id: "aaa",
        title: "Some huge text to see how some similar text "
            "will appear in this layout. Ok, for "
            "smartphone it's already big enough.",
        date: date,
        price: 42.5,
        image: "https://deluxe.scene7.com/is/image/deluxecorp"
            "/1200x675-dlxblog_7-ways-events-can-grow-your-business?"
            "\$deluxe_param\$&wid=900",
        lat: 0,
        long: 0,
      ),
      EventHeadView(
        id: "bbb",
        title: "Some huge text to see how some similar text "
            "will appear in this layout. Ok, for "
            "smartphone it's already big enough 2.",
        date: date,
        price: 42.5 * 2,
        image:
        "https://as2.ftcdn.net/v2/jpg/03/00/14/31/1000_F_300143148_YpzY2nMhX8ATztDO0KsqTOOSzVFTW1Hu.jpg",
        lat: 0,
        long: 0,
      ),
    ];
    const userView = UserView(
      id: "xxx",
      name: "Pedro Motta",
      email: "pedro.motta@instak4u.com",
    );
    return builder(userView, events);
  }
}
