part of '../../datter.dart';

///
///
/// [OverlayStreamWidget]
///   * [OverlayStreamUpdateExist]
///   * [OverlayStateMixin]
///   |
///   --[LeaderWidget]
///     * [LeaderFollowerInitializer]
///
/// [GlobalKeysWidget]
/// [StreamWidget]
///
///
///

///
///
///
class OverlayStreamWidget extends StatefulWidget {
  const OverlayStreamWidget({
    super.key,
    required this.streamUpdate,
    required this.insert,
    required this.updateIfExist,
    required this.child,
  });

  final Stream<String> streamUpdate;
  final Mapper<String, OverlayEntry> insert;
  final OverlayStreamUpdateExist updateIfExist;
  final Widget child;

  @override
  State<OverlayStreamWidget> createState() => _OverlayStreamWidgetState();

  static void updateExist(
    List<OverlayEntry> insertions,
    Map<String, OverlayEntry> exists,
    String key,
    OverlayEntry insertion,
  ) {
    insertion.markNeedsBuild();
  }

  static void updateExistThenRemove(
    List<OverlayEntry> insertions,
    Map<String, OverlayEntry> exists,
    String key,
    OverlayEntry insertion,
  ) {
    insertion.markNeedsBuild();
    exists.remove(key);
    insertions.remove(insertion);
  }
}

class _OverlayStreamWidgetState extends State<OverlayStreamWidget>
    with OverlayStateMixin<OverlayStreamWidget> {
  late final StreamSubscription<String> subscription;
  final Map<String, OverlayEntry> exists = {};

  @override
  void initState() {
    subscription = widget.streamUpdate.listen(
      (key) {
        final insertion = exists[key];
        if (insertion == null) {
          final o = widget.insert(key);
          overlayInsert(o);
          exists.putIfAbsent(key, () => o);
          return;
        }
        widget.updateIfExist(overlays, exists, key, insertion);
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

typedef OverlayStreamUpdateExist = void Function(
  List<OverlayEntry> insertions,
  Map<String, OverlayEntry> exists,
  String key,
  OverlayEntry insertion,
);

///
/// 
/// With [OverlayStateMixin] for stateful widget state, it's clear to insert an overlay.
/// In tradition, when we want to insert an overlay in an stateful widget state, we have to use
///   1. [OverlayState.insert] by [BuildContextExtension.overlay]
///   2. [OverlayPortalController.toggle]
/// both of them have to name an instance,
///   for 1, naming an [OverlayEntry] to handle [OverlayEntry.markNeedsBuild] and [OverlayEntry.remove].
///   for 2, naming and holding an [OverlayPortalController] for passing it to [OverlayPortal.controller]
/// for now, without instance we can still update and remove overlay by [overlays]
/// 
/// 
mixin OverlayStateMixin<T extends StatefulWidget> implements State<T> {
  final List<OverlayEntry> overlays = [];

  ///
  /// Excluding [overlayInsert], it's unnecessary to create function [overlayUpdate] and [overlayRemove].
  /// for update, it's possible to include removing after updating finished, may be async or sync.
  /// for remove, naming as a function is a bad practice for entry required updating before remove.
  /// therefore, update and remove should be customized by [OverlayStateMixin] implementation.
  ///
  void overlayInsert(
    OverlayEntry entry, {
    OverlayEntry? below,
    OverlayEntry? above,
  }) {
    context.overlay.insert(entry, below: below, above: above);
    overlays.add(entry);
  }

  static VoidCallback callbackEntryRemove(OverlayEntry entry) =>
          () => entry.remove();
}

// class OverlayInsertion {
//   final WidgetBuilder builder;
//   final bool opaque;
//   final bool maintainState;
//   final OverlayEntry? below;
//   final OverlayEntry? above;
//
//   const OverlayInsertion({
//     required this.builder,
//     this.opaque = false,
//     this.maintainState = false,
//     this.below,
//     this.above,
//   });
//
//   ///
//   /// no matter "build: build," or "builder: (context) => builder(context),"
//   /// [OverlayEntry.markNeedsBuild] won't rebuild
//   ///
//   OverlayEntry get entry => OverlayEntry(
//         // builder: builder,
//         builder: (context) => builder(context),
//         opaque: opaque,
//         maintainState: maintainState,
//       );
//
//
// }

///
///
///
class LeaderWidget extends StatelessWidget {
  const LeaderWidget({
    super.key,
    required this.link,
    required this.following,
    required this.builder,
    required this.child,
  });

  final LayerLink link;
  final Stream<String> following;
  final LeaderFollowerInitializer builder;
  final Widget child; // child is leader

  @override
  Widget build(BuildContext context) {
    return OverlayStreamWidget(
      streamUpdate: following,
      insert: builder(link),
      updateIfExist: OverlayStreamWidget.updateExistThenRemove,
      child: CompositedTransformTarget(link: link, child: child),
    );
  }
}

typedef LeaderFollowerInitializer = Mapper<String, OverlayEntry> Function(
  LayerLink link,
);

///
///
///
class GlobalKeysWidget<S extends State<StatefulWidget>> extends StatefulWidget {
  const GlobalKeysWidget({
    super.key,
    required this.keysName,
    required this.builder,
  });

  final Set<String> keysName;
  final WidgetGlobalKeysBuilder<S> builder;

  static GlobalKey<S> toGlobalKey<S extends State<StatefulWidget>>(
    String key,
  ) =>
      GlobalKey<S>(debugLabel: key);

  @override
  State<GlobalKeysWidget<S>> createState() => _GlobalKeysWidgetState<S>();
}

class _GlobalKeysWidgetState<S extends State<StatefulWidget>>
    extends State<GlobalKeysWidget<S>> {
  final Map<String, GlobalKey<S>> keys = {};

  @override
  void initState() {
    final names = widget.keysName;
    keys.addAll(Map.fromIterables(
      names,
      names.map(GlobalKeysWidget.toGlobalKey),
    ));
    super.initState();
  }

  @override
  void didUpdateWidget(covariant GlobalKeysWidget<S> oldWidget) {
    keys.migrateInto(widget.keysName, GlobalKeysWidget.toGlobalKey);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, keys);
}

///
///
///
class StreamWidget<T> extends StatelessWidget {
  const StreamWidget({
    super.key,
    this.initialData,
    this.waitingDataBuilder,
    this.activeBuilder,
    this.doneConnectBuilder,
    this.noneConnectionBuilder,
    required this.stream,
    required this.builder,
    this.child,
  });

  final T? initialData;
  final Stream<T> stream;
  final ValueWidgetBuilder<T?> builder;
  final ValueWidgetBuilder<T?>? activeBuilder;
  final ValueWidgetBuilder<T?>? waitingDataBuilder;
  final ValueWidgetBuilder<T?>? doneConnectBuilder;
  final ValueWidgetBuilder<T?>? noneConnectionBuilder;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      initialData: initialData,
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          throw UnimplementedError(snapshot.error.toString());
        }
        final status = snapshot.connectionState;
        return (switch (status) {
              ConnectionState.none => noneConnectionBuilder,
              ConnectionState.waiting => waitingDataBuilder,
              ConnectionState.active => activeBuilder,
              ConnectionState.done => doneConnectBuilder,
            } ??
            this.builder)(context, snapshot.data, child);
      },
    );
  }
}
