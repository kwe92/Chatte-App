class FormFieldValidators {
  final String? Function(String?)? emailValidator;
  final String? Function(String?)? userNameValidator;
  final String? Function(String?)? passwordValidator;

  const FormFieldValidators({
    this.emailValidator,
    this.userNameValidator,
    this.passwordValidator,
  });
}
