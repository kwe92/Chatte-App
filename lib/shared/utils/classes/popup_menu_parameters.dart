/// the parameters of a popup menu
class PopupMenuParameters<T> {
  /// the popup menu title.
  final String title;

  /// required in case the user does not select an option and exits the modal.
  final T defaultResult;

  /// for every key/value pair in options each key/value will be mapped
  /// to a button as the button text and popup menu return value respectively.
  final Map<String, T> options;

  /// the popup menu content body.
  final String? content;

  const PopupMenuParameters({
    required this.title,
    required this.defaultResult,
    required this.options,
    this.content,
  });
}
