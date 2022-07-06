import 'package:core/common/extensions/build_context_extensions.dart';
import 'package:core/common/extensions/object_extensions.dart';
import 'package:core/ui/app_theme.dart';
import 'package:core/ui/component/app_content_loading_progress_bar.dart';
import 'package:core/ui/component/app_modal_warning_bottom_sheet_type.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instak4u/common/extensions/build_context_extensions.dart';
import 'package:instak4u/event/component/event_details_screen_content.dart';
import 'package:instak4u/event/event_details_screen_state.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:presenter/common.dart';
import 'package:presenter/event.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_html/js.dart' as js;

import 'event_details_preview_screen.dart';

class EventDetailsScreen extends StatelessWidget {
  final bool asPreview;

  const EventDetailsScreen({Key? key})
      : asPreview = false,
        super(key: key);

  const EventDetailsScreen.preview({Key? key})
      : asPreview = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Material(
      color: theme.colors.colorScheme.background,
      child: SafeArea(child: asPreview ? _preview() : _screen()),
    );
  }

  Widget _preview() {
    return EventDetailsPreviewScreen(builder: (user, event) {
      return _EventDetailsScreen(
        state: Stream.value(
          _EventDetailsStateStateChangeState(
            newState: EventDetailsStateDisplayDetails(eventDetails: event),
          ),
        ),
        userView: user,
        onIntent: (intent) {
          if (intent == _EventDetailsIntent.shareEvent) {
            debugPrint("sharing");
          } else if (intent == _EventDetailsIntent.performCheckIn) {
            debugPrint("check-in");
          } else if (intent == _EventDetailsIntent.logout) {
            debugPrint("logout");
          }
        },
      );
    });
  }

  Widget _screen() {
    return _EventDetailsScreen();
  }
}

class _EventDetailsScreen extends StatefulWidget {
  final Stream<_EventDetailsStateState> state;
  final UserView userView;
  final void Function()? onLoggedOut;
  final void Function()? onNavigateBack;
  final void Function(_EventDetailsIntent)? onIntent;

  _EventDetailsScreen({
    Key? key,
    Stream<_EventDetailsStateState>? state,
    this.userView = UserView.empty,
    this.onLoggedOut,
    this.onNavigateBack,
    this.onIntent,
  })  : state = state ?? Stream.value(_EventDetailsStateState.idle),
        super(key: key);

  @override
  State<_EventDetailsScreen> createState() => _EventDetailsScreenState();
}

abstract class _EventDetailsStateState {
  static const _EventDetailsStateState idle = _ConstStateState();
}

class _ConstStateState implements _EventDetailsStateState {
  const _ConstStateState();
}

class _EventDetailsStateStateChangeState implements _EventDetailsStateState {
  final EventDetailsState newState;

  const _EventDetailsStateStateChangeState({required this.newState});
}

abstract class _EventDetailsIntent {
  static final _EventDetailsIntent performCheckIn = _ConstIntent();
  static final _EventDetailsIntent shareEvent = _ConstIntent();
  static final _EventDetailsIntent logout = _ConstIntent();
}

class _ConstIntent implements _EventDetailsIntent {}

class _EventDetailsScreenState extends State<_EventDetailsScreen> {
  late EventDetailsScreenState _screenState;

  @override
  void initState() {
    super.initState();
    AppThemeController.of(context)?.resetSystemUiOverlayStyle(
      updateSystemChrome: true,
    );
    widget.state.listen((event) {
      if (event is _EventDetailsStateStateChangeState) {
        setState(() {
          _screenState.handleState(state: event.newState);
        });
      }
    });
    _screenState = EventDetailsScreenState(
      onLoggedOut: widget.onLoggedOut,
      onShareEvent: _onShareEvent,
      onSuccessfulCheckedIn: _onSuccessfulCheckedIn,
      onError: _onError,
    );
  }

  void _onShareEvent(String text) {
    Share.share(text);
  }

  void _onSuccessfulCheckedIn() {
    final str = context.appString;
    final buttonLabel = str.eventDetailsSuccessfulCheckedInMessagePrimaryButton;
    context.showAppModalWarningBottomSheet(
      type: AppModalWarningBottomSheetType.info,
      title: str.eventDetailsSuccessfulCheckedInMessageTitle,
      message: str.eventDetailsSuccessfulCheckedInMessageDescription,
      positiveButtonLabel: buttonLabel,
    );
  }

  void _onError(EventDetailsState state) {
    context.showModalGenericErrorBottomSheet(onPositiveClick: () {
      final _EventDetailsIntent intent = state.let((it) {
        if (it == EventDetailsState.notCheckedIn) {
          return _EventDetailsIntent.performCheckIn;
        }
        return _EventDetailsIntent.shareEvent;
      });
      widget.onIntent?.call(intent);
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppContentLoadingProgressBar(
      showProgress: _screenState.showProgress,
      child: EventDetailsScreenContent(
        image: _screenState.details.image,
        title: _screenState.details.title,
        description: _screenState.details.description,
        userView: widget.userView,
        onLogout: _performLogout,
        onNavigateBack: widget.onNavigateBack,
        onPerformCheckIn: _performCheckIn,
        onShare: _performSharing,
        onShowMap: _showMap,
      ),
    );
  }

  void _performLogout() {
    widget.onIntent?.call(_EventDetailsIntent.logout);
  }

  void _performCheckIn() {
    widget.onIntent?.call(_EventDetailsIntent.performCheckIn);
  }

  void _performSharing() {
    widget.onIntent?.call(_EventDetailsIntent.shareEvent);
  }

  void _showMap() {
    if (kIsWeb) {
      final lat = _screenState.details.latitude;
      final long = _screenState.details.longitude;
      final link = "https://maps.google.com/?q=$lat,$long";
      js.context.callMethod('open', [link, "_blank"]);
    } else {
      _showMobileMap();
    }
  }

  void _showMobileMap() async {
    final event = _screenState.details;
    setState(() => _screenState.showProgress = true);
    final availableMaps = await MapLauncher.installedMaps;
    if (!mounted) return;
    setState(() => _screenState.showProgress = false);
    event.showMobileMap(context: context, availableMaps: availableMaps);
  }
}

extension _EventDetailsViewBottomSheet on EventDetailsView {
  void showMobileMap({
    required BuildContext context,
    required List<AvailableMap> availableMaps,
  }) {
    final coordinates = Coords(latitude, longitude);
    final iconTheme = IconTheme.of(context);
    if (availableMaps.length > 1) {
      context.showAppModalBottomSheet(content: (context) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Wrap(
              children: <Widget>[
                for (var map in availableMaps)
                  ListTile(
                    onTap: () {
                      map.showMarker(
                        coords: coordinates,
                        title: title,
                      );
                      Navigator.pop(context);
                    },
                    title: Text(map.mapName),
                    leading: SvgPicture.asset(
                      map.icon,
                      width: iconTheme.size,
                      height: iconTheme.size,
                    ),
                  ),
              ],
            ),
          ),
        );
      });
    } else if (availableMaps.length == 1) {
      MapLauncher.showMarker(
        mapType: availableMaps[0].mapType,
        coords: coordinates,
        title: title,
      );
    }
  }
}
