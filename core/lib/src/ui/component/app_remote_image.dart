import '../../common/extensions/build_context_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class AppRemoteImage extends StatelessWidget {
  final String url;

  const AppRemoteImage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final iconColor = theme.colors.colorScheme.onSurface.withOpacity(.12);
    Widget imageError() => Center(
            child: Icon(
          Icons.broken_image,
          color: iconColor,
        ));
    return Stack(
      children: [
        Center(
          child: AspectRatio(
            aspectRatio: 1,
            child: LayoutBuilder(
              builder: (context, constraint) {
                return Icon(
                  Icons.image,
                  color: iconColor,
                  size: constraint.maxWidth,
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
            if (kDebugMode) {
              print(obj);
              print(stackTrace);
            }
            return imageError();
          },
          image: url,
        )
      ],
    );
  }
}
