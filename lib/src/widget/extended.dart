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
///
/// * [RadioListMixin]
/// * [DialogBinarySimpleMixin]
/// * [FormTextEditingMixin]
/// * [ImageBuilderMixin]
///
///
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

  List<OverlayEntryInsertion> get _overlays;

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
  final List<OverlayEntryInsertion> _overlays = [];

  @override
  List<OverlayEntryInsertion> get overlays => List.of(
        _overlays,
        growable: false,
      );

  ///
  ///
  ///
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
    final insertion = OverlayEntryInsertionNormal(entry, this);
    _overlays.add(insertion);
    return insertion;
  }

  OverlayEntryInsertionUpdateToRemove overlayInsertUpdateToRemove({
    bool opaque = false,
    bool maintainState = false,
    bool canSizeOverlay = false,
    OverlayEntry? below,
    OverlayEntry? above,
    required WidgetCallableBuilder builder,
  }) {
    late final OverlayEntry entry;
    late final OverlayEntryInsertionUpdateToRemove insertion;
    entry = OverlayEntry(
      opaque: opaque,
      maintainState: maintainState,
      builder: (context) => builder(context, () {
        entry.remove();
        _overlays.remove(insertion);
      }),
    );
    insertion = OverlayEntryInsertionUpdateToRemove(entry, this);
    context.overlay.insert(entry, below: below, above: above);
    _overlays.add(insertion);
    return insertion;
  }

  ///
  ///
  ///
  Future<S> overlayWaitingFuture<S>({
    required Future<S> future,
    required WidgetBuilder waiting,
  }) async {
    final entry = OverlayEntry(builder: waiting);
    context.overlay.insert(entry);
    final result = await future;
    entry.remove();
    return result;
  }

  Future<S> overlayWaitingFutureUpdateToRemove<S>({
    required Future<S> future,
    required WidgetCallableBuilder waiting,
  }) async {
    late final OverlayEntry entry;
    entry = OverlayEntry(builder: (context) => waiting(context, entry.remove));
    context.overlay.insert(entry);
    final result = await future;
    entry.markNeedsBuild();
    return result;
  }
}

///
/// prevent stateful widget state implement [OverlayStateProperty] from accessing to [OverlayEntry.remove],
///
abstract base class OverlayEntryInsertion {
  final OverlayEntry _entry;
  final OverlayStateProperty _owner;

  const OverlayEntryInsertion(this._entry, this._owner);

  void markNeedsBuild() => _entry.markNeedsBuild();

  void remove() => throw Exception(
        "cannot directly remove entry, use 'markNeedsBuild()' instead",
      );
}

final class OverlayEntryInsertionUpdateToRemove
    extends OverlayEntryInsertionNormal {
  const OverlayEntryInsertionUpdateToRemove(super._entry, super.owner);
}

final class OverlayEntryInsertionNormal extends OverlayEntryInsertion {
  const OverlayEntryInsertionNormal(super._entry, super._owner);

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
  final Mapper<String, WidgetCallableBuilder> builderFor;
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
    with OverlayStateNormalMixin<OverlayStreamWidget> {
  late final StreamSubscription<String> subscription;
  final Map<String, OverlayEntryInsertion> exists = {};

  @override
  void initState() {
    subscription = widget.streamUpdate.listen(
      (key) => exists[key].consumeNotNull(
        (value) => widget.updateIfExist(overlays, exists, key, value),
        () => exists.putIfAbsent(
          key,
          () => overlayInsertUpdateToRemove(builder: widget.builderFor(key)),
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
mixin RadioListMixin<W extends StatefulWidget, T> on State<W> {
  late final List<T?> options;

  int get optionCount => 1;

  @override
  void initState() {
    super.initState();
    options = List.filled(optionCount, null, growable: false);
  }

  ///
  ///
  ///
  void onRadioOptionChanged(T? value, [int index = 0]) =>
      setState(() => options[index] = value);

  void clearRadioOptions() {
    for (var i = 0; i < optionCount; i++) {
      options[i] = null;
    }
  }
}

///
///
///
mixin DialogBinarySimpleMixin<T extends StatefulWidget> on State<T> {
  Future<bool?> dialogBinarySimple({
    required String title,
    required String ensure,
    required String cancel,
  }) => context.showDialogBinary(
    textEnsure: Text(ensure),
    textCancel: Text(cancel),
    builder:
        (context, children) =>
        SimpleDialog(title: Center(child: Text(title)), children: children),
  );

  Future<bool> dialogUntilDoubleEnsure({
    required Supplier<Future<bool?>> check,
    required String verbose,
    required String verboseEnsure,
    required String verboseCancel,
  }) async {
    bool? requiredFinish;
    do {
      requiredFinish = await check();
      if (requiredFinish == true &&
          await dialogBinarySimple(
            title: verbose,
            ensure: verboseEnsure,
            cancel: verboseCancel,
          ) ==
              true) {
        return true;
      }
    } while (requiredFinish != false);
    return false;
  }
}

///
///
/// [keyForm], ...
/// [validate_notEmpty], ...
///
///
mixin FormTextEditingMixin<T extends StatefulWidget> on State<T> {
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  late final List<TextEditingController> textEditors;

  // see https://stackoverflow.com/questions/68895441/flutter-textformfield-textinputtype-number-is-not-working-properly-when-i-use-c
  int get countTextEditor => 1;

  bool get requireTextControllerCollapsed => true;

  @override
  void initState() {
    super.initState();
    textEditors = List.generate(
      countTextEditor,
          (_) =>
      requireTextControllerCollapsed
          ? TextEditingController.fromValue(
        TextEditingValue(
          text: '',
          selection: TextSelection.collapsed(offset: 0),
        ),
      )
          : TextEditingController(),
      growable: false,
    );
  }

  ///
  ///
  ///
  void clearTextEditors() {
    for (var editor in textEditors) {
      editor.clear();
    }
  }

  ///
  ///
  ///
  static FormFieldValidator<String> validate_notEmpty(
      {required String messageEmpty}) =>
          (value) => value == null || value.isEmpty ? messageEmpty : null;

  static FormFieldValidator<String> validate_length({
    required int count,
    required String messageEmpty,
    required String messageLengthWrong,
  }) =>
          (value) {
        if (value == null || value.isEmpty) return messageEmpty;
        if (value.length != count) return messageLengthWrong;
        return null;
      };

  static FormFieldValidator<String> validator_int({
    required String messageEmpty,
    required String messageNotInt,
  }) =>
          (value) {
        if (value == null || value.isEmpty) return messageEmpty;
        final v = int.tryParse(value);
        if (v == null) return messageNotInt;
        return null;
      };

  static FormFieldValidator<String> validate_intBetween({
    required int min,
    required int max,
    required String messageEmpty,
    required String messageNoInt,
    required String messageOutOfRange,
  }) =>
          (value) {
        if (value == null || value.isEmpty) return messageEmpty;
        final v = int.tryParse(value);
        if (v == null) return messageNoInt;
        if (v.isOutsideOpen(min, max)) return '$messageOutOfRange: $min~$max';
        return null;
      };
}

///
///
///
mixin ImageBuilderMixin<T extends StatefulWidget> on State<T> {
  ///
  ///
  ///
  static ImageErrorWidgetBuilder error_of(Widget child) =>
          (context, error, trace) => child;

  ///
  ///
  ///
  Color get colorProgressIndicator_imageLoading => Colors.blueGrey;

  ImageLoadingBuilder imageLoadingCircular(WidgetChildBuilder builder) =>
          (context, child, loadingProgress) => loadingProgress == null
          ? child
          : builder(
        context,
        CircularProgressIndicator(
          color: colorProgressIndicator_imageLoading,
          value: loadingProgress.expectedTotalBytes != null &&
              loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
              loadingProgress.expectedTotalBytes!
              : null,
        ),
      );
}

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
