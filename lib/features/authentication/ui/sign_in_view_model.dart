import 'package:chatapp/app/general/constants.dart';
import 'package:chatapp/shared/models/user.dart';
import 'package:chatapp/shared/utils/classes/extended_change_notifier.dart';
import 'package:chatapp/shared/utils/classes/pref_keys.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/shared/services/services.dart';

class SignInViewModel extends ExtendedChangeNotifier {
  SignInViewModel() {
    initialize();
  }

  final formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool _isRemeberMeSwitchedOn = false;

  String _email = '';

  String _password = '';

  bool get isRemeberMeSwitchedOn => _isRemeberMeSwitchedOn;

  String get email => _email;

  String get password => _password;

  Future<void> initialize() async {
    setBusy(true);

    final bool isRememberMeSet = await storage.containsKey(key: PrefKey.readMeKey);
    debugPrint("isRememberMeSet: $isRememberMeSet");

    if (isRememberMeSet) {
      await getMemberInfoFromStorage();

      await Future.delayed(const Duration(milliseconds: 500));
    }
    setBusy(false);

    // if (isRememberMeSet) {
    //   final remeberMeOption = await storage.read(key: PrefKey.readMeKey);

    //   _isRemeberMeSwitchedOn = remeberMeOption!.toLowerCase() == "true";

    //   if (_isRemeberMeSwitchedOn) {
    //     await readEmailAndPasswordFromStorage();
    //   }

    //   notifyListeners();

    //   await Future.delayed(const Duration(milliseconds: 500));
    //   setBusy(false);
    // }
  }

  void setRemember(bool isSwitchedOn) async {
    _isRemeberMeSwitchedOn = isSwitchedOn;

    await saveToStorage(
      PrefKey.readMeKey,
      _isRemeberMeSwitchedOn.toString(),
    );

    notifyListeners();

    debugPrint("remember me user preference saved to storage.");
  }

  void setEmail(String email) {
    _email = email.trim().toLowerCase();
    debugPrint(_email);
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password.trim();
    debugPrint(_password);

    notifyListeners();
  }

  Future<User?> signInWithEmailAndPassword() async {
    setBusy(true);
    var error = await firebaseService.signInWithEmailAndPassword(email, password);

    if (error == null) {
      // currently logged in user data
      final currentUser = await createCurrentUser();
      setBusy(false);

      return currentUser;
    }

    setBusy(false);

    toastService.showSnackBar(ToastServiceErrorMessage.failedLoginError);

    return null;
  }

  Future<User> createCurrentUser() async {
    final String userid = firebaseService.currentUser!.uid;

    // Currently logged in user data
    final currentUser = await userService.getCurrentUser(CollectionPath.users.path, userid);

    return currentUser;
  }

  void clearData() {
    if (!_isRemeberMeSwitchedOn) {
      emailController.clear();
      passwordController.clear();
      setEmail('');
      setPassword('');
      notifyListeners();
    }
  }

  Future<void> getMemberInfoFromStorage() async {
    final remeberMeOption = await storage.read(key: PrefKey.readMeKey);

    debugPrint("remeberMeOption: $remeberMeOption");

    _isRemeberMeSwitchedOn = remeberMeOption!.toLowerCase() == "true";

    if (_isRemeberMeSwitchedOn) {
      await readEmailAndPasswordFromStorage();
    }

    notifyListeners();
  }

  Future<void> handleEmailAndPasswordStorage() async => await runBusyFuture(
      () async => _isRemeberMeSwitchedOn ? await saveEmailAndPasswordToStorage() : await removeEmailAndPasswordFromStorage());

  Future<void> saveEmailAndPasswordToStorage() async {
    await saveToStorage(PrefKey.emailKey, _email);
    await saveToStorage(PrefKey.passwordKey, _password);
    debugPrint("saved email and password to storage.");
  }

  Future<void> removeEmailAndPasswordFromStorage() async {
    await storage.delete(key: PrefKey.emailKey);
    await storage.delete(key: PrefKey.passwordKey);

    debugPrint("removed email and password from storage.");
  }

  Future<void> readEmailAndPasswordFromStorage() async {
    final email = await storage.read(key: PrefKey.emailKey);
    final password = await storage.read(key: PrefKey.passwordKey);

    if (email != null && password != null) {
      emailController.text = email;
      passwordController.text = password;
      _email = email;
      _password = password;
    }
  }

  Future<void> saveToStorage(String key, String value) async => await storage.write(key: key, value: value);
}
