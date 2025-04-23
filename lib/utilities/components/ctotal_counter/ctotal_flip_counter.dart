import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stokpile/services/entries/bloc/entries_bloc.dart';

class CtotalFlipCounter extends StatefulWidget {
  final String uid;

  const CtotalFlipCounter({
    super.key,
    required this.uid,
  });

  @override
  State<CtotalFlipCounter> createState() => _CtotalFlipCounterState();
}

class _CtotalFlipCounterState extends State<CtotalFlipCounter> {
  static const double fontSize = 48;

  @override
  Widget build(BuildContext context) {
    num lastvalue = 0.00;
    return BlocBuilder<EntriesBloc, EntriesState>(builder: (context, state) {
      if (state is EntriesStateLoggedIn) {
        lastvalue = state.ctotal;
        return AnimatedFlipCounter(
          value: state.ctotal,
          textStyle: const TextStyle(
            fontSize: fontSize,
          ),
          fractionDigits: 2,
          prefix: '\$',
        );
      } else {
        return AnimatedFlipCounter(
          value: lastvalue,
          textStyle: const TextStyle(
            fontSize: fontSize,
          ),
          fractionDigits: 2,
          prefix: '\$',
        );
      }
    });
  }
}
