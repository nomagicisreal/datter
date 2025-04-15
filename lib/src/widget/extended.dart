part of '../../datter.dart';

///
///
/// * [OverlayStateProperty]
///     * [OverlayStateNormalMixin]
///     * [OverlayStateUpdateToRemoveMixin]
///
/// * [OverlayEntryInsertion]
///     * [OverlayEntryInsertionNormal]
///     * [OverlayEntryInsertionUpdateToRemove]
///         --[OverlayStreamWidget]
///             * [OverlayStreamUpdateExist]
///
/// [GlobalKeysWidget]
/// [StreamWidget]
///
///
///

///
///
/// In tradition, when we want to insert an overlay in an stateful widget state, we have to use
///   1. [OverlayState.insert] by [BuildContextExtension.overlay]
///   2. [OverlayPortalController.toggle]
/// both of them have to name an instance,
///   for 1, naming an [OverlayEntry] to handle [OverlayEntry.markNeedsBuild] and [OverlayEntry.remove].
///   for 2, naming and holding an [OverlayPortalController] for passing it to [OverlayPortal.controller]
/// for now, without instance we can still update and remove overlay by [overlays]
///
///
abstract interface class OverlayStateProperty {
  const OverlayStateProperty();

  List<OverlayEntry> get _overlays;

  List<OverlayEntryInsertion> get overlays;
}

///
/// Excluding [overlayInsert], it's unnecessary to create function [overlayUpdate] and [overlayRemove].
/// for update, it's possible to include removing after updating finished, may be async or sync.
/// for remove, naming as a function is a bad practice for entry required updating before remove.
/// therefore, update and remove should be customized by [OverlayStateAbstract] implementation.
/// See Also [OverlayEntryInsertion]
///
mixin OverlayStateNormalMixin<T extends StatefulWidget>
implements State<T>, OverlayStateProperty {
  final List<OverlayEntry> _overlays = [];

  @override
  List<OverlayEntryInsertionNormal> get overlays => List.of(
    _overlays
        .mapToList((entry) => OverlayEntryInsertionNormal._(entry, this)),
    growable: false,
  );

  OverlayEntryInsertionNormal overlayInsert({
    bool opaque = false,
    bool maintainState = false,
    bool canSizeOverlay = false,
    required WidgetBuilder builder,
    OverlayEntry? below,
    OverlayEntry? above,
  }) {
    final entry = OverlayEntry(
      opaque: opaque,
      maintainState: maintainState,
      canSizeOverlay: canSizeOverlay,
      builder: builder,
    );
    context.overlay.insert(entry, below: below, above: above);
    _overlays.add(entry);
    return OverlayEntryInsertionNormal._(entry, this);
  }
}

///
///
///
mixin OverlayStateUpdateToRemoveMixin<T extends StatefulWidget>
implements State<T>, OverlayStateProperty {
  final List<OverlayEntry> _overlays = [];

  @override
  List<OverlayEntryInsertionUpdateToRemove> get overlays => List.of(
    _overlays.mapToList(
          (entry) => OverlayEntryInsertionUpdateToRemove._(entry, this),
    ),
    growable: false,
  );

  OverlayEntryInsertionUpdateToRemove overlayInsert({
    bool opaque = false,
    bool maintainState = false,
    bool canSizeOverlay = false,
    OverlayEntry? below,
    OverlayEntry? above,
    required Mixer<BuildContext, VoidCallback, Widget> builder,
  }) {
    late final OverlayEntry entry;
    entry = OverlayEntry(
      opaque: opaque,
      maintainState: maintainState,
      builder: (context) => builder(context, () {
        entry.remove();
        _overlays.remove(entry);
      }),
    );
    context.overlay.insert(entry, below: below, above: above);
    _overlays.add(entry);
    return OverlayEntryInsertionUpdateToRemove._(entry, this);
  }
}


///
/// prevent stateful widget state implement [OverlayStateProperty] from accessing to [OverlayEntry.remove],
///
abstract base class OverlayEntryInsertion {
  final OverlayEntry _entry;
  final OverlayStateProperty _owner;

  const OverlayEntryInsertion._(this._entry, this._owner);

  void markNeedsBuild() => _entry.markNeedsBuild();

  void remove() => throw Exception(
        "cannot directly remove entry, use 'markNeedsBuild()' instead",
      );
}

final class OverlayEntryInsertionUpdateToRemove
    extends OverlayEntryInsertionNormal {
  const OverlayEntryInsertionUpdateToRemove._(super._entry, super.owner)
      : super._();
}

final class OverlayEntryInsertionNormal extends OverlayEntryInsertion {
  const OverlayEntryInsertionNormal._(super._entry, super._owner) : super._();

  @override
  void remove() {
    _owner._overlays.remove(_entry);
    _entry.remove();
  }
}

///
///
///
class OverlayStreamWidget extends StatefulWidget {
  const OverlayStreamWidget({
    super.key,
    required this.streamUpdate,
    required this.builderFor,
    required this.updateIfExist,
    required this.child,
  });

  final Stream<String> streamUpdate;
  final Mapper<String, WidgetBuilderCallable> builderFor;
  final OverlayStreamUpdateExist updateIfExist;
  final Widget child;

  @override
  State<OverlayStreamWidget> createState() => _OverlayStreamWidgetState();

  static void updateExist(
    List<OverlayEntry> overlays,
    Map<String, OverlayEntry> exists,
    String key,
    OverlayEntry insertion,
  ) {
    insertion.markNeedsBuild();
  }
}

class _OverlayStreamWidgetState extends State<OverlayStreamWidget>
    with OverlayStateUpdateToRemoveMixin<OverlayStreamWidget> {
  late final StreamSubscription<String> subscription;
  final Map<String, OverlayEntryInsertion> exists = {};

  @override
  void initState() {
    subscription = widget.streamUpdate.listen(
      (key) => exists[key].consumeNotNull(
        (value) => widget.updateIfExist(overlays, exists, key, value),
        () => exists.putIfAbsent(
          key,
          () => overlayInsert(builder: widget.builderFor(key)),
        ),
      ),
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
  List<OverlayEntryInsertion> insertions,
  Map<String, OverlayEntryInsertion> exists,
  String key,
    OverlayEntryInsertion insertion,
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
