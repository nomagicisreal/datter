part of '../../datter.dart';

///
///
/// * [FrameCallbackInitMixin]
/// * [StreamSubscriptionInitMixin]
///
/// * [MaterialColorMixin]
/// * [FabLocationMixin]
///
/// * [DialogRichMixin]
///
/// * [TextEditingControllerMixin]
/// * [FormKeyMixin]
/// * [RadioListMixin]
/// * [Form1By1Mixin], [Form2By2Mixin]
///
/// * [ListItemStateMixin]
/// * [ImageBuilderMixin]
///
///

///
///
///
mixin FrameCallbackInitMixin<T extends StatefulWidget> on State<T> {
  FrameCallback get frameCallbackInitial;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(frameCallbackInitial);
  }
}

///
///
///
mixin StreamSubscriptionInitMixin<T extends StatefulWidget, S> on State<T> {
  late final StreamSubscription<S> _subscription;

  Stream<S> get streamInit;

  Consumer<S> get streamConsumerInit;

  Function? get streamOnErrorInit;

  VoidCallback? streamOnDoneInit;

  bool? streamCancelOnErrorInit;

  @override
  void initState() {
    super.initState();
    _subscription = streamInit.listen(
      streamConsumerInit,
      onError: streamOnErrorInit,
      onDone: streamOnDoneInit,
      cancelOnError: streamCancelOnErrorInit,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }
}

///
///
///
mixin MaterialColorMixin<T extends StatefulWidget> on State<T> {
  late MaterialColor? _color;

  MaterialColor? get colorInit => null;

  @override
  void initState() {
    super.initState();
    _color = colorInit;
  }

  @nonVirtual
  MaterialColor? get color => _color;

  @nonVirtual
  set color(MaterialColor? color) => setState(() => _color = color);
}

///
///
///
mixin FabLocationMixin<T extends StatefulWidget> on State<T> {
  late FloatingActionButtonLocation? _location;

  FloatingActionButtonLocation? get fabLocationInit => null;

  @override
  void initState() {
    super.initState();
    _location = fabLocationInit;
  }

  @nonVirtual
  FloatingActionButtonLocation? get fabLocation => _location;

  @nonVirtual
  set fabLocation(FloatingActionButtonLocation? location) =>
      setState(() => _location = location);
}

///
///
///
///
///
///
mixin DialogRichMixin<T extends StatefulWidget> on State<T> {
  Future<void> showDialogTapToContinue({required WidgetBuilder builder}) =>
      showDialog(
        context: context,
        builder: (context) => Stack(
          fit: StackFit.expand,
          children: [
            builder(context),
            GestureDetector(onTap: context.navigator.pop),
          ],
        ),
      );

  Future<bool?> showDialogBinary({
    required Widget textEnsure,
    required Widget textCancel,
    required Parenting builder,
  }) =>
      showDialog(
        context: context,
        builder: (context) => builder([
          TextButton(
            onPressed: () => context.navigator.pop(false),
            child: textCancel,
          ),
          TextButton(
            onPressed: () => context.navigator.pop(true),
            child: textEnsure,
          ),
        ]),
      );

  Future<I?> showDialogList<I>({
    required List<I> items,
    required Parenting builder,
  }) =>
      showDialog<I>(
        context: context,
        builder: (context) => builder(items.mapToList(
          (item) => TextButton(
            onPressed: () => context.navigator.pop(item),
            child: Text(item.toString()),
          ),
        )),
      );

  Future<V?> showDialogMap<V>({
    required Map<String, V> options,
    required Parenting builder,
  }) =>
      showDialog(
        context: context,
        builder: (context) => builder(options.keys.fold(
          [],
          (list, title) => list
            ..add(TextButton(
              onPressed: () => context.navigator.pop(options[title]),
              child: Text(title),
            )),
        )),
      );

  ///
  ///
  ///
  Future<bool?> dialogBinarySimple({
    required String title,
    required String ensure,
    required String cancel,
  }) =>
      showDialogBinary(
        textEnsure: Text(ensure),
        textCancel: Text(cancel),
        builder: (children) =>
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
///
///
mixin TextEditingControllerMixin<T extends StatefulWidget> on State<T> {
  ///
  /// if required [TextInputType.number], text editing controller also needs to be as follow:
  /// ```
  /// TextEditingController.fromValue(
  ///   TextEditingValue(
  ///     text: '',
  ///     selection: TextSelection.collapsed(offset: 0),
  ///   ),
  /// )
  /// ```
  /// see https://stackoverflow.com/questions/68895441/flutter-textformfield-textinputtype-number-is-not-working-properly-when-i-use-c
  ///
  late final List<TextEditingController> textEditingControllers;

  int get countTextEditingController;

  Generator<TextEditingController> get generateTextEditingControllers;

  @override
  void initState() {
    super.initState();
    textEditingControllers = List.generate(
      countTextEditingController,
      generateTextEditingControllers,
      growable: false,
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (var editors in textEditingControllers) {
      editors.dispose();
    }
  }

  ///
  ///
  ///
  void clearTextEditingControllers() {
    for (var editor in textEditingControllers) {
      editor.clear();
    }
  }
}

///
/// [keyForm], ...
/// [validator_notEmpty], ...
///
mixin FormKeyMixin<T extends StatefulWidget> on State<T> {
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  void formFinish();

  void formReform({required bool keepAnswer});

  Future<bool> goFormFinishOrReform();

  Future<void> formFinishOrReform({
    bool keepAnswerIfReform = true,
    VoidCallback? callbackReset,
    VoidCallback? callbackFinish,
  }) async {
    if (await goFormFinishOrReform()) {
      formFinish();
      callbackFinish?.call();
      return;
    }
    formReform(keepAnswer: keepAnswerIfReform);
    callbackReset?.call();
  }

  ///
  ///
  ///
  static FormFieldValidator<String> validator_notEmpty(
          {required String messageEmpty}) =>
      (value) => value == null || value.isEmpty ? messageEmpty : null;

  static FormFieldValidator<String> validator_length({
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

  ///
  ///
  ///
  static FormFieldValidator<String> validator_intBetween({
    required int min,
    required int max,
    required String messageEmpty,
    required String messageNotInt,
    required String messageOutOfRange,
  }) =>
      min > max
          ? (throw StateError('there is no integer between $min ~ $max'))
          : (value) {
              if (value == null || value.isEmpty) return messageEmpty;
              final v = int.tryParse(value);
              if (v == null) return messageNotInt;
              if (v.isOutsideOpen(min, max)) {
                return '$messageOutOfRange: $min~$max';
              }
              return null;
            };

  static FormFieldValidator<String> validator_intWithin({
    required int floor,
    required int ceil,
    required String messageEmpty,
    required String messageNoInt,
    required String messageOutOfRange,
  }) =>
      floor + 1 >= ceil
          ? throw StateError('there is no integer within $floor ~ $ceil')
          : (value) {
              if (value == null || value.isEmpty) return messageEmpty;
              final v = int.tryParse(value);
              if (v == null) return messageNoInt;
              if (v.isOutsideClose(floor, ceil)) {
                return floor + 2 == ceil
                    ? '$messageOutOfRange: ${floor + 1}'
                    : '$messageOutOfRange: ${floor + 1}~${ceil - 1}';
              }
              return null;
            };
}

///
///
///
mixin RadioListMixin<T extends StatefulWidget> on State<T>
    implements TextEditingControllerMixin<T> {
  ///
  ///
  ///
  @override
  int get countTextEditingController => 1;

  ///
  ///
  ///
  void _onRadioOptionChanged(String? value) =>
      setState(() => textEditingControllers.first.text = value ?? '');

  List<RadioListTile<String?>> radioListOptions(List<String> options) =>
      List.of(
        options.mapToList(
          (option) => RadioListTile<String?>(
            groupValue: textEditingControllers.first.text,
            title: Text(option),
            value: option,
            onChanged: _onRadioOptionChanged,
          ),
        ),
        growable: false,
      );
}

///
///
///
mixin Form1By1Mixin<T extends StatefulWidget> on State<T>
    implements FormKeyMixin<T>, TextEditingControllerMixin<T> {
  int get formQuestionStepInit => 1;

  List<String> get formQuestionsInit;

  ///
  ///
  ///
  late int _formQuestionStep;
  late final Map<String, String?> formAnswers;

  String get _formQuestionCurrent =>
      formAnswers.keys.elementAt(_formQuestionStep - 1);

  ///
  ///
  ///
  @override
  int get countTextEditingController => 1;

  @override
  void initState() {
    super.initState();
    _formQuestionStep = formQuestionStepInit;
    formAnswers = formQuestionsInit.iterator.toMapKeys();
  }

  @override
  void formFinish() => setState(() => formAnswers.reset());

  @override
  void formReform({required bool keepAnswer}) => setState(() {
        _formQuestionStep = formQuestionStepInit;
        if (keepAnswer) return;
        textEditingControllers.first.clear();
        formAnswers.reset();
      });

  ///
  ///
  ///
  bool goFormNext(String question, String answer);

  void formNext() {
    if (!keyForm.currentState!.validate()) return;
    if (goFormNext(_formQuestionCurrent, textEditingControllers.first.text)) {
      textEditingControllers.first.clear();
      setState(() => _formQuestionStep++);
    }
  }
}

///
///
///
mixin Form2By2Mixin<T extends StatefulWidget> on State<T>
    implements FormKeyMixin<T>, TextEditingControllerMixin<T> {
  ///
  ///
  ///
  int get formQuestionStepInit => 1;

  int get formQuestionStepAInit => 1;

  int get formQuestionStepBInit => 1;

  List<String> get formQuestionsAInit;

  List<String> get formQuestionsBInit;

  ///
  ///
  ///
  late int _step;
  late int _stepA;
  late int _stepB;
  late final Map<String, String?> answersA;
  late final Map<String, String?> answersB;

  String get _formQuestionACurrent => answersA.keys.elementAt(_stepA - 1);

  String get _formQuestionBCurrent => answersB.keys.elementAt(_stepB - 1);

  ///
  ///
  ///
  @override
  int get countTextEditingController => 2;

  @override
  void initState() {
    super.initState();
    _step = formQuestionStepInit;
    _stepA = formQuestionStepAInit;
    _stepB = formQuestionStepBInit;
    answersA = formQuestionsAInit.iterator.toMapKeys();
    answersB = formQuestionsBInit.iterator.toMapKeys();
  }

  @override
  void formFinish() => setState(() {
        answersA.reset();
        answersB.reset();
      });

  @override
  void formReform({required bool keepAnswer}) => setState(() {
        _step = formQuestionStepInit;
        _stepA = formQuestionStepAInit;
        _stepB = formQuestionStepBInit;
        if (keepAnswer) return;
        clearTextEditingControllers();
        answersA.reset();
        answersB.reset();
      });

  ///
  ///
  ///
  Widget questionAnswerA(int index);

  Widget questionAnswerB(int index);

  Widget get centerBetweenAB;

  List<Widget> get children => [
        if (_stepA == _step) questionAnswerA(_step),
        if (_step == _stepA && _step == _stepB) centerBetweenAB,
        if (_stepB == _step) questionAnswerB(_step),
      ];

  ///
  ///
  ///
  bool goFormNext(String qA, String qB, String aA, String aB);

  bool haveToAnswerNextA(String qA, String qB, String aA, String aB);

  bool haveToAnswerNextB(String qA, String qB, String aA, String aB);

  void formNext() {
    if (!keyForm.currentState!.validate()) return;
    final qA = _formQuestionACurrent;
    final qB = _formQuestionBCurrent;
    final aA = textEditingControllers[0].text;
    final aB = textEditingControllers[1].text;
    if (!goFormNext(qA, qB, aA, aB)) return;
    clearTextEditingControllers();
    if (haveToAnswerNextA(qA, qB, aA, aB)) _stepA = _step + 1;
    if (haveToAnswerNextB(qA, qB, aA, aB)) _stepB = _step + 1;
    setState(() => _step++);
  }
}

///
///
///
mixin ListItemStateMixin<T extends StatefulWidget, I, S> on State<T> {
  late final List<I> _listItems;
  late final Map<S, WidgetValuedBuilder<I>> _listItemBuilders;

  List<I> get listItemsInit;

  Map<S, WidgetValuedBuilder<I>> get listItemBuilders;

  Mapper<I, S> get listItemToState;

  @override
  void initState() {
    super.initState();
    _listItems = listItemsInit;
    _listItemBuilders = Map.unmodifiable(_listItemBuilders);
  }

  Widget? itemBuilder(BuildContext context, int index) =>
      _listItemBuilders[listItemToState(_listItems[index])]!(
        context,
        _listItems[index],
      );

  void listItemUpdate({
    int? index,
    required I itemNew,
    required PredicatorReducer<I> fusion,
  }) {
    index ??= _listItems.indexWhere((itemOld) => fusion(itemOld, itemNew));
    setState(() => _listItems[index!] = itemNew);
  }
}

///
///
///
mixin ImageBuilderMixin<T extends StatefulWidget> on State<T> {
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

  ///
  ///
  ///
  static ImageErrorWidgetBuilder error_of(Widget child) =>
      (context, error, trace) => child;
}
