///
///
/// this file contains:
///
/// extension:
/// [TimeOfDayExtension]
/// [ClipboardExtension]
/// [FocusManagerExtension], [FocusNodeExtension]
/// [GlobalKeyExtension]
///
/// [AnimationControllerExtension]
///
/// [BuildContextExtension]
///
/// extension for functions:
/// [FFormFieldValidator]
/// [FImageLoadingBuilder], [FImageErrorWidgetBuilder]
///
///
///
///
///
///
///
///
///
part of '../../datter.dart';

///
///
///
extension TimeOfDayExtension on TimeOfDay {
  static TimeOfDay pm(int hour, int minute) {
    assert(hour.isRangeClose(0, 11));
    return TimeOfDay(hour: 12 + hour, minute: minute);
  }

  static TimeOfDay am(int hour, int minute) {
    assert(hour.isRangeClose(0, 11));
    return TimeOfDay(hour: hour, minute: minute);
  }
}

///
///
///
extension ClipboardExtension on Clipboard {
  static void copy(String text, {VoidCallback? then}) =>
      Clipboard.setData(ClipboardData(text: text)).then((_) => then?.call());
}

///
/// focus manager, focus general, global key
///
extension FocusManagerExtension on FocusManager {
  void unFocus() => primaryFocus?.unfocus();
}

extension FocusNodeExtension on FocusNode {
  VoidCallback addFocusChangedListener(VoidCallback listener) =>
      hasFocus ? listener : FListener.none;
}

//
extension GlobalKeyExtension on GlobalKey {
  RenderBox get renderBox => currentContext?.findRenderObject() as RenderBox;

  Rect get renderRect => renderBox.fromLocalToGlobalRect;

  Offset adjustScaffoldOf(Offset offset) {
    final translation = currentContext
        ?.findRenderObject()
        ?.getTransformTo(null)
        .getTranslation();

    return translation == null
        ? offset
        : Offset(
            offset.dx - translation.x,
            offset.dy - translation.y,
          );
  }
}

///
/// [theme], [themeText], .... , [colorScheme]
/// [sizeMedia], [mediaViewInsets]
/// [isKeyboardShowing]
///
/// [renderBox]
/// [scaffold], [scaffoldMessenger]
/// [navigator]
///
/// [closeKeyboardIfShowing]
/// [showSnackbar], [showSnackbarWithMessage]
/// [showDialogOptionsSupply], [showDialogOptionActions], [showDialogListAndGetItem], [showDialogDecideTureOfFalse]
///
extension BuildContextExtension on BuildContext {
  // AppLocalizations get loc => AppLocalizations.of(this)!;

  ///
  ///
  ///
  void closeKeyboardIfShowing() {
    if (isKeyboardShowing) {
      FocusScopeNode currentFocus = FocusScope.of(this);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }
  }

  ///
  ///
  ///
  bool get isKeyboardShowing => mediaViewInsetsBottom > 0;

  ///
  ///
  ///
  double get mediaViewInsetsBottom => mediaViewInsets.bottom;

  ///
  ///
  ///
  Size get sizeMedia => MediaQuery.sizeOf(this);

  Size get sizeRenderBox => renderBox.size;

  ///
  ///
  ///
  EdgeInsets get mediaViewInsets => MediaQuery.viewInsetsOf(this);

  ///
  ///
  ///
  DefaultTextStyle get defaultTextStyle => DefaultTextStyle.of(this);

  TextDirection get textDirection => Directionality.of(this);

  ///
  /// state
  ///
  ScaffoldState get scaffold => Scaffold.of(this);

  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  NavigatorState get navigator => Navigator.of(this);

  OverlayState get overlay => Overlay.of(this);

  ///
  /// diagnosticable
  ///
  ColorScheme get colorScheme => theme.colorScheme;

  RenderBox get renderBox => findRenderObject() as RenderBox;

  ///
  ///
  ///
  ThemeData get theme => Theme.of(this);

  TargetPlatform get platform => theme.platform;

  IconThemeData get themeIcon => theme.iconTheme;

  TextTheme get themeText => theme.textTheme;

  AppBarTheme get themeAppBar => theme.appBarTheme;

  BadgeThemeData get themeBadge => theme.badgeTheme;

  MaterialBannerThemeData get themeBanner => theme.bannerTheme;

  BottomAppBarTheme get themeBottomAppBar => theme.bottomAppBarTheme;

  BottomNavigationBarThemeData get themeBottomNavigationBar =>
      theme.bottomNavigationBarTheme;

  BottomSheetThemeData get themeBottomSheet => theme.bottomSheetTheme;

  ButtonThemeData get themeButton => theme.buttonTheme;

  CardThemeData get themeCard => theme.cardTheme;

  CheckboxThemeData get themeCheckbox => theme.checkboxTheme;

  ChipThemeData get themeChip => theme.chipTheme;

  DataTableThemeData get themeDataTable => theme.dataTableTheme;

  DatePickerThemeData get themeDatePicker => theme.datePickerTheme;

  DialogThemeData get themeDialog => theme.dialogTheme;

  DividerThemeData get themeDivider => theme.dividerTheme;

  DrawerThemeData get themeDrawer => theme.drawerTheme;

  DropdownMenuThemeData get themeDropdownMenu => theme.dropdownMenuTheme;

  ElevatedButtonThemeData get themeElevatedButton => theme.elevatedButtonTheme;

  ExpansionTileThemeData get themeExpansionTile => theme.expansionTileTheme;

  FilledButtonThemeData get themeFilledButton => theme.filledButtonTheme;

  FloatingActionButtonThemeData get themeFloatingActionButton =>
      theme.floatingActionButtonTheme;

  IconButtonThemeData get themeIconButton => theme.iconButtonTheme;

  ListTileThemeData get themeListTile => theme.listTileTheme;

  MenuBarThemeData get themeMenuBar => theme.menuBarTheme;

  MenuButtonThemeData get themeMenuButton => theme.menuButtonTheme;

  MenuThemeData get themeMenu => theme.menuTheme;

  NavigationBarThemeData get themeNavigationBar => theme.navigationBarTheme;

  NavigationDrawerThemeData get themeNavigationDrawer =>
      theme.navigationDrawerTheme;

  NavigationRailThemeData get themeNavigationRail => theme.navigationRailTheme;

  OutlinedButtonThemeData get themeOutlinedButton => theme.outlinedButtonTheme;

  PopupMenuThemeData get themePopupMenu => theme.popupMenuTheme;

  ProgressIndicatorThemeData get themeProgressIndicator =>
      theme.progressIndicatorTheme;

  RadioThemeData get themeRadio => theme.radioTheme;

  SearchBarThemeData get themeSearchBar => theme.searchBarTheme;

  SearchViewThemeData get themeSearchView => theme.searchViewTheme;

  SegmentedButtonThemeData get themeSegmentedButton =>
      theme.segmentedButtonTheme;

  SliderThemeData get themeSlider => theme.sliderTheme;

  SnackBarThemeData get themeSnackBar => theme.snackBarTheme;

  SwitchThemeData get themeSwitch => theme.switchTheme;

  TabBarThemeData get themeTabBar => theme.tabBarTheme;

  TextButtonThemeData get themeTextButton => theme.textButtonTheme;

  TextSelectionThemeData get themeTextSelection => theme.textSelectionTheme;

  TimePickerThemeData get themeTimePicker => theme.timePickerTheme;

  ToggleButtonsThemeData get themeToggleButtons => theme.toggleButtonsTheme;

  TooltipThemeData get themeTooltip => theme.tooltipTheme;

  ///
  /// snackbar, material banner
  ///
  void showSnackbar(SnackBar snackBar) =>
      scaffoldMessenger.showSnackBar(snackBar);

  void showMaterialBanner(MaterialBanner banner) =>
      scaffoldMessenger.showMaterialBanner(banner);

  void hideMaterialBanner({
    MaterialBannerClosedReason reason = MaterialBannerClosedReason.dismiss,
  }) =>
      scaffoldMessenger.hideCurrentMaterialBanner(reason: reason);

  ///
  /// dialog
  ///
  Future<T?> showDialogOptionsSupply<T>({
    required String title,
    required String content,
    required Supplier<Map<String, T>> optionsSupply,
  }) {
    final options = optionsSupply();
    return showDialog(
      context: this,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: options.keys
            .map((optionTitle) => TextButton(
                  onPressed: () => context.navigator.pop(options[optionTitle]),
                  child: Text(optionTitle),
                ))
            .toList(),
      ),
    );
  }

  Future<T?> showDialogOptionActions<T>({
    required String title,
    required String? content,
    required Map<String, Supplier<T>> optionActions,
  }) async {
    final actions = <Widget>[];
    T? returnValue;
    optionActions.forEach((label, action) {
      actions.add(TextButton(
        onPressed: () {
          navigator.pop();
          returnValue = action();
        },
        child: Text(label),
      ));
    });
    await showDialog(
        context: this,
        builder: (context) => content == null
            ? SimpleDialog(title: Text(title), children: actions)
            : AlertDialog(
                title: Text(title),
                content: Text(content),
                actions: actions,
              ));
    return returnValue;
  }

  Future<void> showDialogEnsureCancel({
    required String textEnsure,
    required String textCancel,
    WidgetBuilder? content,
    VoidCallback? onEnsure,
    VoidCallback? onCancel,
  }) async =>
      showDialog<void>(
        context: this,
        useRootNavigator: false,
        builder: (context) => AlertDialog(
          content: content?.call(context),
          actions: [
            TextButton(
              onPressed: onCancel ?? context.navigator.pop,
              child: Text(textCancel),
            ),
            if (onEnsure != null)
              TextButton(onPressed: onEnsure, child: Text(textEnsure)),
          ],
        ),
      );

  Future<T?> showDialogListAndGetItem<T>(
      {required String title, required List<T> itemList, Size? size}) async {
    late final T? selectedItem;
    await showDialog(
      context: this,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SizedBox.fromSize(
          size: KGeometry.size_w1_h2.flipped * 100,
          child: ListView.builder(
            itemCount: itemList.length,
            itemBuilder: (context, index) {
              final item = itemList[index];
              return Center(
                child: TextButton(
                  onPressed: () {
                    selectedItem = item;
                    context.navigator.pop();
                  },
                  child: Text(item.toString()),
                ),
              );
            },
          ),
        ),
      ),
    );
    return selectedItem;
  }

  Future<bool?> showDialogDecideTureOfFalse(
    Widget iconProcess,
    Widget iconCancel,
  ) async {
    bool? result;
    await showDialog(
        context: this,
        builder: (context) => SimpleDialog(
              children: [
                TextButton(
                  onPressed: () {
                    result = true;
                    context.navigator.pop();
                  },
                  child: iconProcess,
                ),
                TextButton(
                  onPressed: () {
                    result = false;
                    context.navigator.pop();
                  },
                  child: iconCancel,
                ),
              ],
            ));
    return result;
  }
}

///
///
///
/// extension for functions
///
///
///
///

///
///
/// [notEmpty]
/// [intBetween], [lengthOf]
///
extension FFormFieldValidator on TextFormFieldValidator {
  static FormFieldValidator<String> notEmpty([String messageEmpty = '請輸入']) =>
      (value) => value == null || value.isEmpty ? messageEmpty : null;

  static FormFieldValidator<String> intBetween({
    required int min,
    required int max,
    String messageEmpty = '請輸入',
    String messageNoInt = '請輸入數字',
    String messageOutOfRange = '可接受範圍',
  }) =>
      (value) {
        if (value == null || value.isEmpty) return messageEmpty;
        final v = int.tryParse(value);
        if (v == null) return messageNoInt;
        if (v.isOutsideOpen(min, max)) return '$messageOutOfRange: $min~$max';
        return null;
      };

  static FormFieldValidator<String> lengthOf({
    required int count,
    String messageEmpty = '請輸入',
    String messageLengthWrong = '長度不符',
  }) =>
      (value) {
        if (value == null || value.isEmpty) return messageEmpty;
        if (value.length != count) return messageLengthWrong;
        return null;
      };
}

extension FImageLoadingBuilder on ImageLoadingBuilder {
  static Widget style1(
    BuildContext context,
    Widget child,
    ImageChunkEvent? loadingProgress,
  ) =>
      loadingProgress == null
          ? child
          : Center(
              child: CircularProgressIndicator(
                color: Colors.blueGrey,
                value: loadingProgress.expectedTotalBytes != null &&
                        loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );

  static Widget style2(
    BuildContext context,
    Widget child,
    ImageChunkEvent? loadingProgress,
  ) =>
      loadingProgress == null
          ? child
          : SizedBox(
              width: 90,
              height: 90,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.grey,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            );

  static Widget style3(
    BuildContext ctx,
    Widget child,
    ImageChunkEvent? loadingProgress,
  ) =>
      loadingProgress == null
          ? child
          : Center(
              child: CircularProgressIndicator(
                color: Colors.blueGrey,
                value: loadingProgress.expectedTotalBytes != null &&
                        loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );

  static Widget style4(
    BuildContext context,
    Widget child,
    ImageChunkEvent? loadingProgress,
  ) =>
      loadingProgress == null
          ? child
          : SizedBox(
              width: 200,
              height: 200,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.brown,
                  value: loadingProgress.expectedTotalBytes != null &&
                          loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            );
}

///
///
/// [FImageErrorWidgetBuilder]
///
///
extension FImageErrorWidgetBuilder on ImageErrorWidgetBuilder {
  static Widget accountStyle2(BuildContext c, Object o, StackTrace? s) =>
      WIconMaterial.accountCircleStyle2;

  static Widget errorStyle1(BuildContext c, Object o, StackTrace? s) =>
      const SizedBox(height: 200, width: 200, child: Icon(Icons.error));
}
