// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:stokpile/exceptions/auth_exceptions.dart';
// import 'package:stokpile/services/auth/bloc/auth_bloc.dart';
// import 'package:stokpile/utilities/dialogs/error_dialog.dart';
// import 'package:stokpile/utilities/dialogs/info_dialog.dart';

// class ForgotPasswordView extends StatefulWidget {
//   const ForgotPasswordView({super.key});

//   @override
//   State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
// }

// class _ForgotPasswordViewState extends State<ForgotPasswordView> {
//   late final TextEditingController _controller;
//   @override
//   void initState() {
//     _controller = TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AuthBloc, AuthState>(
//       listener: (context, state) async {
//         await dialogPopupListener(
//           state,
//           context,
//         );
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Forgot Password'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               const Text(
//                   "Enter your email address and we'll send you a password reset email!"),
//               TextField(
//                 controller: _controller,
//                 keyboardType: TextInputType.emailAddress,
//                 autocorrect: false,
//                 autofocus: true,
//                 decoration: const InputDecoration(
//                   hintText: 'Your email address...',
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {
//                   final email = _controller.text;
//                   if (email.isNotEmpty) {
//                     context
//                         .read<AuthBloc>()
//                         .add(AuthEventSendPasswordReminder(email));
//                   }
//                 },
//                 child: const Text('Send a password reset link'),
//               ),
//               TextButton(
//                 onPressed: () {
//                   context.read<AuthBloc>().add(const AuthEventLogOut());
//                 },
//                 child: const Text('Back to login page'),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> dialogPopupListener(
//       AuthState state, BuildContext context) async {
//     if (state is AuthStateForgotPassword) {
//       if (state.hasSentEmail) {
//         _controller.clear();
//         await showInfoDialog(
//           context,
//           text: "We've sent a password reset email to you",
//         );
//       }
//       if ((state.exception is InvalidEmailException ||
//               state.exception is UserNotFoundAuthException) &&
//           context.mounted) {
//         await showErrorDialog(
//           context,
//           errorText: "Oops! That email doesn't seem to match any users.",
//         );
//       } else if (context.mounted) {
//         await showErrorDialog(
//           context,
//           errorText:
//               'Oops! Something went wrong and we could not send an email to you.',
//         );
//       }
//     }
//   }
// }
