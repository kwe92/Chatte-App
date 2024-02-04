class FormFieldValidators {
  final String? Function(String?)? emailValidator;
  final String? Function(String?)? userNameValidator;
  final String? Function(String?)? passwordValidator;
  final String? Function(String?)? confirmPasswordValidator;

  const FormFieldValidators({
    this.emailValidator,
    this.userNameValidator,
    this.passwordValidator,
    this.confirmPasswordValidator,
  });
}
