abstract class AuthException implements Exception {
  final String errorText;
  const AuthException(this.errorText);
}

class EmailAlreadyInUseException extends AuthException {
  const EmailAlreadyInUseException()
      : super("Looks like you already have an account with that email address");
}

class EmptyEmailException extends AuthException {
  const EmptyEmailException()
      : super("You haven't entered an email address yet");
}

class EmptyPasswordException extends AuthException {
  const EmptyPasswordException() : super("You haven't entered a password yet");
}

class GenericAuthException extends AuthException {
  const GenericAuthException()
      : super(
            "Something didn't work with authentication, I'm not super sure why");
}

class GenericException extends AuthException {
  const GenericException()
      : super("Something didn't work, I'm not super sure why");
}

class InvalidEmailException extends AuthException {
  const InvalidEmailException()
      : super("That doesn't look like a valid email address");
}

class UserNotFoundAuthException extends AuthException {
  const UserNotFoundAuthException()
      : super("Your credentials don't seem right");
}

class UserNotLoggedInException extends AuthException {
  const UserNotLoggedInException()
      : super("You don't seem to be logged in yet");
}

class WeakPasswordException extends AuthException {
  const WeakPasswordException()
      : super("Your password needs to be a little stronger");
}
