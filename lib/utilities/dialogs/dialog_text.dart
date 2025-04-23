import 'package:stokpile/services/entries/entry.dart';

const String saveTitle = 'Save';
const String spendTitle = 'Spend';
const String errorTitle = 'Uh oh!';
const String deleteTitle = 'Delete?';
const String infoTitle = 'Just so you know...';
const String logoutTitle = 'Logout?';

String saveBody(Entry entry) {
  return 'Are you passing up on ${entry.title} and stokpiling \$${entry.value.toStringAsFixed(2)}?';
}

String spendBody(Entry entry) {
  return 'Are you cashing in \$${entry.value.toStringAsFixed(2)} from your stokpile to get ${entry.title}?';
}

const String deleteBody = 'Are you sure that you want to delete this?';

const String logoutBody = 'Are you sure that you want to logout?';

const String dialogYes = 'Yup';
const String dialogNo = 'Nah';
const String dialogOk = 'OK';
const String dialogDelete = 'Delete';
const String dialogCancel = 'Cancel';
const String dialogContinue = 'Continue';
const String dialogLogout = 'Logout';

const String deleteAllTitle = 'Delete All Entries?';
const String deleteAllBody =
    "Are you sure that you want to delete this? \n There's no way to recover these entries if you change your mind!";
const String deleteAllConfirm = 'Delete them all';
