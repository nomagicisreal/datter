part of '../../datter.dart';

///
///
/// [IconAction]
///
///
/// extensions:
/// [TimeOfDayExtension]
/// [ClipboardExtension]
/// [FocusManagerExtension], [FocusNodeExtension]
/// [GlobalKeyExtension]
///
/// [BuildContextExtension]
///
///

///
///
///
class IconAction {
  final Icon icon;
  final VoidCallback action;

  const IconAction(this.icon, this.action);

  double dimensionFrom(BuildContext context) =>
      icon.size ?? context.theme.iconTheme.size ?? 24.0;

  Widget buildBy(Mixer<Icon, VoidCallback, Widget> mixer) =>
      mixer(icon, action);

  static double maxSize(
    Iterable<IconAction> icons,
    BuildContext context,
    double defaultSize,
  ) =>
      math.max(
        icons.iterator.induct((i) => i.icon.size ?? 0, math.max),
        context.themeIcon.size ?? defaultSize,
      );
}

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
/// [showDialogMap], [showDialogMapActions], [showDialogList], [showDialogBinary]
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

  void showSnackBarMessage(
    String message, {
    Duration duration = KCore.durationMilli500,
    bool center = true,
  }) =>
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: center ? Center(child: Text(message)) : Text(message),
          duration: duration,
        ),
      );

  void showMaterialBanner(MaterialBanner banner) =>
      scaffoldMessenger.showMaterialBanner(banner);

  void hideMaterialBanner({
    MaterialBannerClosedReason reason = MaterialBannerClosedReason.dismiss,
  }) =>
      scaffoldMessenger.hideCurrentMaterialBanner(reason: reason);

  ///
  ///
  ///
  Future<bool?> showDialogBinary({
    required Widget textEnsure,
    required Widget textCancel,
    required WidgetParentBuilder builder,
  }) =>
      showDialog(
        context: this,
        builder: (context) => builder(
          context,
          [
            TextButton(
              onPressed: () => context.navigator.pop(true),
              child: textEnsure,
            ),
            TextButton(
              onPressed: () => context.navigator.pop(false),
              child: textCancel,
            ),
          ],
        ),
      );

  Future<T?> showDialogList<T>({
    required List<T> items,
    required WidgetParentBuilder builder,
  }) =>
      showDialog(
        context: this,
        builder: (context) => builder(
          context,
          items.mapToList(
            (item) => TextButton(
              onPressed: () => context.navigator.pop(item),
              child: Text(item.toString()),
            ),
          ),
        ),
      );

  Future<T?> showDialogMap<T>({
    required Map<String, T> options,
    required WidgetParentBuilder builder,
  }) =>
      showDialog(
        context: this,
        builder: (context) => builder(
          context,
          options.keys.fold(
            [],
            (list, title) => list
              ..add(TextButton(
                onPressed: () => context.navigator.pop(options[title]),
                child: Text(title),
              )),
          ),
        ),
      );

  ///
  ///
  ///
  void showGeneralDialogFadeIn(
    RoutePageBuilder pageBuilder, {
    Duration duration = KCore.durationMilli200,
  }) =>
      showGeneralDialog(
        context: this,
        pageBuilder: pageBuilder,
        transitionBuilder: (context, a1, a2, child) =>
            FadeTransition(opacity: a1, child: child),
        transitionDuration: duration,
      );
}
