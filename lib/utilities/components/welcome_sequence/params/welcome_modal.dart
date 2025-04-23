class WelcomeModal {
  final String title;
  final String hintText;
  final String errorText;
  final String variable;

  WelcomeModal({
    required this.title,
    required this.hintText,
    required this.errorText,
    required this.variable,
  });

  static WelcomeModal nameInputModal() => WelcomeModal(
        title: 'What\'s your name?',
        hintText: 'Friend',
        errorText: 'Please enter a name',
        variable: 'name',
      );
  static WelcomeModal saveTitleInputModal() => WelcomeModal(
        title: 'What do you want to give up?',
        hintText: 'Coffee',
        errorText: 'Please enter a something to give up',
        variable: 'saveTitle',
      );
  static WelcomeModal spendTitleInputModal() => WelcomeModal(
        title: 'What do you want to save up for?',
        hintText: 'Massage',
        errorText: 'Please enter a something to save for',
        variable: 'spendTitle',
      );
  static WelcomeModal saveValueInputModal() => WelcomeModal(
        title: 'How much is that worth?',
        hintText: '4.50',
        errorText: 'Please enter a value',
        variable: 'saveValue',
      );
  static WelcomeModal spendValueInputModal() => WelcomeModal(
        title: 'How much is that worth?',
        hintText: '100',
        errorText: 'Please enter a value',
        variable: 'spendValue',
      );
}
