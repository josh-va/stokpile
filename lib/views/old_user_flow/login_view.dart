// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:stokpile/services/auth/bloc/auth_bloc.dart';
// import 'package:stokpile/utilities/dialogs/error_dialog.dart';

// class LoginView extends StatefulWidget {
//   const LoginView({super.key});

//   @override
//   State<LoginView> createState() => _LoginViewState();
// }

// class _LoginViewState extends State<LoginView> {
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
//       listener: (context, authState) async {
//         await showErrorsOnAuthExceptions(authState, context);
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Login'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               const Text('Please log in to your account here!'),
//               const SizedBox(
//                 height: 10,
//               ),
//               TextField(
//                 controller: _email,
//                 autocorrect: false,
//                 enableSuggestions: false,
//                 autofocus: true,
//                 inputFormatters: <TextInputFormatter>[
//                   FilteringTextInputFormatter.deny(RegExp(r'\s'))
//                 ],
//                 textAlign: TextAlign.center,
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: const InputDecoration(hintText: 'Email'),
//               ),
//               TextField(
//                 controller: _password,
//                 textAlign: TextAlign.center,
//                 obscureText: true,
//                 autocorrect: false,
//                 onSubmitted: (value) async {
//                   final email = _email.text;
//                   final password = _password.text;
//                   authBloc.add(
//                     AuthEventLogIn(
//                       email: email,
//                       password: password,
//                     ),
//                   );
//                 },
//                 enableSuggestions: false,
//                 decoration: const InputDecoration(hintText: 'Password'),
//               ),
//               TextButton(
//                 onPressed: () async {
//                   final email = _email.text;
//                   final password = _password.text;
//                   authBloc.add(
//                     AuthEventLogIn(
//                       email: email,
//                       password: password,
//                     ),
//                   );
//                 },
//                 child: const Text('Login'),
//               ),
//               TextButton(
//                 onPressed: () {
//                   authBloc.add(
//                     const AuthEventForgotPassword(),
//                   );
//                 },
//                 child: const Text("I've forgotten my password"),
//               ),
//               TextButton(
//                 onPressed: () {
//                   authBloc.add(
//                     const AuthEventShouldRegister(),
//                   );
//                 },
//                 child: const Text("Create a new account"),
//               ),
//               TextButton(
//                 onPressed: () async {
//                   authBloc.add(
//                     const AuthEventLogInAnonymously(),
//                   );
//                 },
//                 child: const Text("I'll create an account later"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> showErrorsOnAuthExceptions(
//       AuthState authState, BuildContext context) async {
//     if (authState is AuthStateUnauthenticated && authState.exception != null) {
//       await showErrorDialog(
//         context,
//         errorText: authState.exception!.errorText,
//       );
//     }
//   }
// }
