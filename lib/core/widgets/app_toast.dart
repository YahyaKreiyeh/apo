import 'dart:async';

import 'package:apo/core/constants/theme_constants.dart';
import 'package:apo/core/routing/routes.dart' show navigatorKey;
import 'package:apo/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

enum AppToastType { success, error, info }

class AppToast {
  AppToast._();
  static final List<_ToastRequest> _queue = <_ToastRequest>[];
  static OverlayEntry? _entry;
  static Timer? _timer;
  static bool _isShowing = false;
  static GlobalKey<_ToastPillState>? _animKey;

  static void show({
    required String message,
    AppToastType type = AppToastType.error,
  }) {
    final rootCtx = navigatorKey.currentContext;
    final overlay =
        navigatorKey.currentState?.overlay ??
        (rootCtx != null ? Overlay.of(rootCtx, rootOverlay: true) : null);
    if (overlay == null || rootCtx == null) return;

    final req = _ToastRequest(
      message: message,
      type: type,
      duration: const Duration(milliseconds: 1800),
    );

    if (_isShowing || _queue.isNotEmpty) {
      _queue.add(req);
      return;
    }

    _showNow(overlay, rootCtx, req);
  }

  static void clear({bool dismissCurrent = true}) {
    _queue.clear();
    if (dismissCurrent && _isShowing) {
      _timer?.cancel();
      try {
        _animKey?.currentState?.hide();
      } catch (_) {}
      _entry?.remove();
      _entry = null;
      _animKey = null;
      _isShowing = false;
    }
  }

  static void _showNow(
    OverlayState overlay,
    BuildContext rootCtx,
    _ToastRequest req,
  ) {
    _timer?.cancel();
    _entry?.remove();

    final theme = Theme.of(rootCtx);
    late final Color bg, fg;
    switch (req.type) {
      case AppToastType.success:
        bg = AppColors.greenToast;
        fg = AppColors.green;
        break;
      case AppToastType.error:
        bg = AppColors.redToast;
        fg = AppColors.red;
        break;
      default:
        bg = theme.colorScheme.secondaryFixed;
        fg = theme.colorScheme.secondaryFixedDim;
        break;
    }

    _animKey = GlobalKey<_ToastPillState>();
    _entry = OverlayEntry(
      builder: (_) => _ToastPill(
        key: _animKey,
        background: bg,
        foreground: fg,
        message: req.message,
      ),
    );

    overlay.insert(_entry!);
    _isShowing = true;

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _animKey?.currentState?.show();
    });

    _timer = Timer(req.duration, () async {
      await _dismissCurrent();
      if (_queue.isNotEmpty) {
        final next = _queue.removeAt(0);
        final nextOverlay =
            navigatorKey.currentState?.overlay ??
            (navigatorKey.currentContext != null
                ? Overlay.of(navigatorKey.currentContext!, rootOverlay: true)
                : null);
        final ctx = navigatorKey.currentContext;
        if (nextOverlay != null && ctx != null) {
          scheduleMicrotask(() => _showNow(nextOverlay, ctx, next));
        } else {
          _isShowing = false;
        }
      }
    });
  }

  static Future<void> _dismissCurrent() async {
    try {
      await _animKey?.currentState?.hide();
    } catch (_) {}
    _entry?.remove();
    _entry = null;
    _animKey = null;
    _isShowing = false;
  }
}

class _ToastPill extends StatefulWidget {
  const _ToastPill({
    super.key,
    required this.background,
    required this.foreground,
    required this.message,
  });
  final Color background, foreground;
  final String message;

  @override
  State<_ToastPill> createState() => _ToastPillState();
}

class _ToastPillState extends State<_ToastPill>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 220),
  );
  late final Animation<Offset> _slide = Tween(
    begin: const Offset(0, 0.12),
    end: Offset.zero,
  ).chain(CurveTween(curve: Curves.easeOutCubic)).animate(_c);
  late final Animation<double> _fade = CurvedAnimation(
    parent: _c,
    curve: Curves.easeOut,
  );

  Future<void> show() => _c.forward();
  Future<void> hide() => _c.reverse();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    const baseline = 24.0;

    return IgnorePointer(
      ignoring: true,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(bottom: baseline + bottomInset),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SlideTransition(
            position: _slide,
            child: FadeTransition(
              opacity: _fade,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: widget.background,
                  borderRadius: BorderRadius.circular(ThemeConstants.radius),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1F919EAB),
                      offset: Offset(0, 12),
                      blurRadius: 24,
                      spreadRadius: -4,
                    ),
                    BoxShadow(
                      color: Color(0x33919EAB),
                      offset: Offset(0, 0),
                      blurRadius: 2,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: _ToastText(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ToastText extends StatelessWidget {
  const _ToastText();

  @override
  Widget build(BuildContext context) {
    final parent = context.findAncestorWidgetOfExactType<_ToastPill>()!;
    return Text(
      parent.message,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
        color: parent.foreground,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _ToastRequest {
  const _ToastRequest({
    required this.message,
    required this.type,
    required this.duration,
  });
  final String message;
  final AppToastType type;
  final Duration duration;
}
