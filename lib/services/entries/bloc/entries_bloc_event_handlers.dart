part of 'entries_bloc.dart';

Future<void> _logOut({
  required Emitter<EntriesState> emit,
  StreamSubscription<num>? ctotalSubscription,
  StreamSubscription<Iterable<Entry>>? entriesSubscription,
}) async {
  await ctotalSubscription?.cancel();
  await entriesSubscription?.cancel();
  emit(const EntriesStateLoggedOut());
}

Future<void> _deleteAll(EntriesEventDeleteAll event) async {
  await FirebaseCloudStorage().deleteAllEntries(event.uid);
}

Future<void> _addEntry(EntriesEventAddEntry event) async {
  await FirebaseCloudStorage().createNewEntry(
    inputEntry: event.entry,
    uid: event.uid,
  );
}

Future<void> _updateEntry(EntriesEventUpdateEntry event) async {
  await FirebaseCloudStorage().updateEntryWithEntry(
    uid: event.uid,
    entry: event.entry,
  );
}

void _entriesUpdated({
  required Emitter<EntriesState> emit,
  required EntriesEventEntriesUpdated event,
  required EntriesState state,
}) {
  emit(EntriesStateLoggedIn(
    entries: event.entries,
    ctotal: state.ctotal,
  ));
}

void _ctotalUpdated({
  required Emitter<EntriesState> emit,
  required EntriesEventCtotalUpdated event,
  required EntriesState state,
}) {
  emit(EntriesStateLoggedIn(
    entries: state.entries,
    ctotal: event.ctotal,
  ));
}

Future<void> _logIn({
  required CloudStorageProvider provider,
  required EntriesEventLogIn event,
  required Emitter<EntriesState> emit,
  StreamSubscription<num>? ctotalSubscription,
  StreamSubscription<Iterable<Entry>>? entriesSubscription,
  num? latestCtotal,
  Iterable<Entry>? latestEntries,
  required EntriesBloc bloc,
}) async {
  latestCtotal = await provider.getCtotal(event.uid);
  latestEntries = await provider.getAllEntriesSnapshot(event.uid);
  ctotalSubscription?.cancel();
  ctotalSubscription = provider.getCtotalStream(event.uid).listen(
    (ctotal) {
      bloc.add(EntriesEventCtotalUpdated(ctotal));
    },
  );
  entriesSubscription?.cancel();
  entriesSubscription = provider.getAllEntriesStream(event.uid).listen(
    (entries) {
      bloc.add(EntriesEventEntriesUpdated(entries));
    },
  );
  emit(EntriesStateLoggedIn(
    ctotal: latestCtotal,
    entries: latestEntries,
  ));
}
