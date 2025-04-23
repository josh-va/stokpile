part of 'entries_bloc.dart';

sealed class EntriesState {
  final Iterable<Entry> entries;
  final num ctotal;
  const EntriesState({
    required this.entries,
    required this.ctotal,
  });
}

final class EntriesStateLoggedOut extends EntriesState {
  const EntriesStateLoggedOut()
      : super(
          entries: const [],
          ctotal: 0,
        );
}

final class EntriesStateLoggedIn extends EntriesState {
  const EntriesStateLoggedIn({
    required super.entries,
    required super.ctotal,
  });
}
