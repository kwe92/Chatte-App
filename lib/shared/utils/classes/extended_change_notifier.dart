import 'package:flutter/material.dart';

class ExtendedChangeNotifier extends ChangeNotifier {
  bool _isBusy = false;

  bool get isBusy => _isBusy;

  void setBusy(bool busy) {
    _isBusy = busy;
    notifyListeners();
  }

  Future<T> runBusyFuture<T>(Future<T> Function() busyFuture) async {
    setBusy(true);
    final T result = await busyFuture();
    setBusy(false);

    return result;
  }
}
