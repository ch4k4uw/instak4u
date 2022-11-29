import 'dart:async';

import 'package:core/common.dart';
import 'package:core/ui.dart';
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

class EventDetailsScreen extends StatefulWidget {
  final EventDetailsViewModel? viewModel;
  final UserView? userView;
  final void Function()? onLoggedOut;
  final void Function()? onNavigateBack;

  const EventDetailsScreen({
    Key? key,
    this.viewModel,
    this.userView,
    this.onLoggedOut,
    this.onNavigateBack,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EventDetailsScreenState();
}

final _idle = Stream.value(_EventDetailsStateState.idle);

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

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  late EventDetailsScreenState _screenState;
  late StreamController<_EventDetailsStateState>? _streamController;

  Stream<_EventDetailsStateState> get state =>
      _streamController?.stream ?? _idle;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Material(
      color: theme.colors.colorScheme.background,
      child: SafeArea(child: _showScreen()),
    );
  }

  Widget _showScreen() {
    return AppContentLoadingProgressBar(
      showProgress: _screenState.showProgress,
      child: EventDetailsScreenContent(
        image: _screenState.details.image,
        title: _screenState.details.title,
        description: _screenState.details.description,
        userView: widget.userView.orEmpty(),
        onLogout: _performLogout,
        onNavigateBack: widget.onNavigateBack,
        onPerformCheckIn: _performCheckIn,
        onShare: _performSharing,
        onShowMap: _showMap,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    AppThemeController.of(context)?.resetSystemUiOverlayStyle(
      updateSystemChrome: true,
    );
    _setupState();
    _setupListeners();
  }

  void _setupState() {
    _screenState = EventDetailsScreenState(
      onLoggedOut: widget.onLoggedOut,
      onShareEvent: _onShareEvent,
      onSuccessfulCheckedIn: _onSuccessfulCheckedIn,
      onError: _onError,
    );
    _streamController = widget.viewModel?.let((it) {
      final result = StreamController<_EventDetailsStateState>();
      it.uiState.listen((event) {
        result.add(_EventDetailsStateStateChangeState(newState: event));
      });
      return result;
    });
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
      if (state == EventDetailsState.notCheckedIn) {
        _performCheckIn();
      } else {
        _performSharing();
      }
      return true;
    });
  }

  void _setupListeners() {
    state.listen((event) {
      if (event is _EventDetailsStateStateChangeState) {
        setState(() {
          _screenState.handleState(state: event.newState);
        });
      }
    });
  }

  void _performLogout() {
    widget.viewModel?.logout();
  }

  void _performCheckIn() {
    widget.viewModel?.performCheckIn();
  }

  void _performSharing() {
    widget.viewModel?.shareEvent();
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
