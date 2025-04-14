part of '../../datter.dart';

///
///
/// [FFormFieldValidator]
/// [FImageBuilder]
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

extension FImageBuilder on ImageLoadingBuilder {
  static Widget loading_style1(
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

  static Widget loading_style2(
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

  static Widget loading_style3(
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

  static Widget loading_style4(
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

  ///
  ///
  ///
  static ImageErrorWidgetBuilder error_of(Widget child) =>
      (context, error, trace) => child;
}
