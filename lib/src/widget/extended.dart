part of '../../datter.dart';

///
///
/// [OverlayStreamWidget]
///   * [OverlayStreamUpdateExist]
///   * [OverlayStateMixin]
///   * [OverlayInsertion]
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
  final Mapper<String, OverlayInsertion> insert;
  final OverlayStreamUpdateExist updateIfExist;
  final Widget child;

  @override
  State<OverlayStreamWidget> createState() => _OverlayStreamWidgetState();

  static void updateExist(
    List<OverlayInsertion> insertions,
    Map<String, OverlayInsertion> exists,
    String key,
    OverlayInsertion insertion,
  ) {
    insertion.entry.markNeedsBuild();
  }

  static void updateExistThenRemove(
    List<OverlayInsertion> insertions,
    Map<String, OverlayInsertion> exists,
    String key,
    OverlayInsertion insertion,
  ) {
    insertion.entry.markNeedsBuild();
    exists.remove(key);
    insertions.remove(insertion);
  }
}

class _OverlayStreamWidgetState extends State<OverlayStreamWidget>
    with OverlayStateMixin {
  late final StreamSubscription<String> subscription;
  final Map<String, OverlayInsertion> exists = {};

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
        widget.updateIfExist(insertions, exists, key, insertion);
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
  List<OverlayInsertion> insertions,
  Map<String, OverlayInsertion> exists,
  String key,
  OverlayInsertion insertion,
);

mixin OverlayStateMixin {
  BuildContext get context;

  final List<OverlayInsertion> insertions = [];

  void overlayInsert(OverlayInsertion o) {
    context.overlay.insert(o.entry, below: o.below, above: o.above);
    insertions.add(o);
  }
}

class OverlayInsertion {
  final WidgetBuilder builder;
  final bool opaque;
  final bool maintainState;
  final OverlayEntry? below;
  final OverlayEntry? above;

  const OverlayInsertion({
    required this.builder,
    this.opaque = false,
    this.maintainState = false,
    this.below,
    this.above,
  });

  OverlayEntry get entry => OverlayEntry(
        builder: builder,
        opaque: opaque,
        maintainState: maintainState,
      );

  static VoidCallback callbackEntryRemove(OverlayEntry entry) =>
      () => entry.remove();
}

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

typedef LeaderFollowerInitializer = Mapper<String, OverlayInsertion> Function(
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
