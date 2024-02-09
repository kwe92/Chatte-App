// TODO: ensure that collectionPath parameters have a type of CollectionPath instead of String

enum CollectionPath {
  users("users"),

  chat("/chat/3Rzps9JekqBlFfihf2Jq/messages"),

  images("user_images");

  final String path;

  const CollectionPath(this.path);
}

class ToastServiceErrorMessage {
  const ToastServiceErrorMessage._();

  static const imageError = "image maybe corrupted, please try another image.";

  static const failedLoginError = "invalid username or password, please try again.";

  static const unavailableUserNameError = "user name taken.";

  static const unavailableEmailError = "email address in use.";

  static const accountCreationError = "there was an issue creating your account.";

  static const passwordMismatchError = "passwords do not match.";

  static const termsAndConditionsError = "accept terms and conditions before proceeding";

  static const fillAllRequiredFieldsError = "please fill out all required fields.";
}
