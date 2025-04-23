// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:stokpile/exceptions/auth_exceptions.dart';
// import 'package:stokpile/services/auth/bloc/auth_bloc.dart';
// import 'package:stokpile/utilities/dialogs/error_dialog.dart';
// import 'package:stokpile/utilities/loading_screen/loading_screen.dart';

// class RegisterView extends StatefulWidget {
//   const RegisterView({super.key});

//   @override
//   State<RegisterView> createState() => _RegisterViewState();
// }

// class _RegisterViewState extends State<RegisterView> {
//   late final TextEditingController _email;
//   late final TextEditingController _password;

//   @override
//   void initState() {
//     _email = TextEditingController();
//     _password = TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _email.dispose();
//     _password.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authBloc = context.read<AuthBloc>();
//     return BlocListener<AuthBloc, AuthState>(
//       listener: (context, state) async {
//         if (state.isLoading) {
//           LoadingScreen().show(
//               context: context,
//               text: state.loadingText ?? 'Please wait a moment...');
//         } else {
//           LoadingScreen().hide();
//         }
//         if (state is AuthStateRegistering) {
//           if (state.exception is WeakPasswordException) {
//             await showErrorDialog(
//               context,
//               errorText: 'Your password must be at least 6 characters long',
//             );
//           } else if (state.exception is EmptyEmailException) {
//             await showErrorDialog(
//               context,
//               errorText: "You haven't entered an email address yet",
//             );
//           } else if (state.exception is EmptyPasswordException) {
//             await showErrorDialog(
//               context,
//               errorText: "You haven't entered a password yet",
//             );
//           } else if (state.exception is InvalidEmailException) {
//             await showErrorDialog(
//               context,
//               errorText: "That doesn't look like a valid email address",
//             );
//           } else if (state.exception is EmailAlreadyInUseException) {
//             await showErrorDialog(
//               context,
//               errorText: 'This account already exists! Try logging in instead',
//             );
//           } else if (state.exception is GenericAuthException) {
//             await showErrorDialog(
//               context,
//               errorText:
//                   "Something didn't work with authentication, not sure though",
//             );
//           } else if (state.exception is GenericException) {
//             await showErrorDialog(
//               context,
//               errorText: "Something didn't work, not sure though",
//             );
//           }
//         }
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Register'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               const Text('Please register in to your account here!'),
//               const SizedBox(
//                 height: 10,
//               ),
//               TextField(
//                 controller: _email,
//                 autocorrect: false,
//                 autofocus: true,
//                 enableSuggestions: false,
//                 inputFormatters: <TextInputFormatter>[
//                   FilteringTextInputFormatter.deny(RegExp(r'\s'))
//                 ],
//                 textAlign: TextAlign.center,
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: const InputDecoration(
//                   hintText: 'Email',
//                 ),
//               ),
//               TextField(
//                 controller: _password,
//                 textAlign: TextAlign.center,
//                 obscureText: true,
//                 autocorrect: false,
//                 enableSuggestions: false,
//                 decoration: const InputDecoration(
//                   hintText: 'Password',
//                 ),
//               ),
//               TextButton(
//                 onPressed: () async {
//                   final email = _email.text;
//                   final password = _password.text;
//                   authBloc.add(AuthEventRegister(
//                     email: email,
//                     password: password,
//                   ));
//                 },
//                 child: const Text('Register'),
//               ),
//               TextButton(
//                 onPressed: () {
//                   authBloc.add(
//                     const AuthEventLogOut(),
//                   );
//                 },
//                 child: const Text("I already have an account"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
