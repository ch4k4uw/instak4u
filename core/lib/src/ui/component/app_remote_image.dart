import 'dart:async';

import '../../common/extensions/build_context_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class AppRemoteImage extends StatefulWidget {
  final String url;

  const AppRemoteImage({Key? key, required this.url}) : super(key: key);

  @override
  State<AppRemoteImage> createState() => _AppRemoteImageState();
}

class _AppRemoteImageState extends State<AppRemoteImage> {
  var _isShowPlaceholder = true;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final iconColor = theme.colors.colorScheme.onSurface.withOpacity(
      theme.doubles.defaultOpacity,
    );
    Widget imageError() => Center(
          child: Icon(
            Icons.broken_image,
            color: iconColor,
          ),
        );
    print("...\n\n\n${widget.url}\n\n\n...");
    return Stack(
      children: [
        Center(
          child: AspectRatio(
            aspectRatio: 1,
            child: LayoutBuilder(
              builder: (context, constraint) {
                return Visibility(
                  visible: _isShowPlaceholder,
                  child: Icon(
                    Icons.image,
                    color: iconColor,
                    size: constraint.maxWidth,
                  ),
                );
              },
            ),
          ),
        ),
        FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          fit: BoxFit.cover,
          width: double.maxFinite,
          height: double.maxFinite,
          imageErrorBuilder: (context, obj, stackTrace) {
            if (_isShowPlaceholder) {
              scheduleMicrotask(() {
                setState(() => _isShowPlaceholder = false);
              });
              _log(obj, stackTrace);
            }
            return imageError();
          },
          image: Uri.decodeFull(widget.url),
        )
      ],
    );
  }

  void _log(Object obj, StackTrace? stackTrace) {
    if (kDebugMode) {
      print(obj);
      print(stackTrace);
    }
  }
}
