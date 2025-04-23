// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:stokpile/services/auth/bloc/auth_bloc.dart';
// import 'package:stokpile/utilities/dialogs/info_dialog.dart';

// class VerifyEmailView extends StatefulWidget {
//   const VerifyEmailView({super.key});

//   @override
//   State<VerifyEmailView> createState() => _VerifyEmailViewState();
// }

// class _VerifyEmailViewState extends State<VerifyEmailView> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Email Verification'),
//       ),
//       body: Column(
//         children: [
//           const Center(child: Text("We've sent an email verification to you")),
//           TextButton(
//             onPressed: () {
//               context
//                   .read<AuthBloc>()
//                   .add(const AuthEventSendEmailVerification());
//               showInfoDialog(
//                 context,
//                 text: "We've just sent another email!",
//               );
//             },
//             child: const Text(
//               'Resend email verification',
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
