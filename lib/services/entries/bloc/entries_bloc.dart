import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stokpile/services/cloud/cloud_storage_provider.dart';
import 'package:stokpile/services/cloud/firebase_cloud_storage.dart';
import 'package:stokpile/services/entries/entry.dart';

part 'entries_event.dart';
part 'entries_state.dart';
part 'entries_bloc_event_handlers.dart';

class EntriesBloc extends Bloc<EntriesEvent, EntriesState> {
  StreamSubscription<num>? _ctotalSubscription;
  StreamSubscription<Iterable<Entry>>? _entriesSubscription;
  num? _latestCtotal;
  Iterable<Entry>? _latestEntries;

  EntriesBloc(CloudStorageProvider provider)
      : super(const EntriesStateLoggedOut()) {
    _initializeEventHandlers(provider);
  }

  void _initializeEventHandlers(CloudStorageProvider provider) {
    on<EntriesEventLogIn>((event, emit) async {
      await _logIn(
        provider: provider,
        event: event,
        emit: emit,
        ctotalSubscription: _ctotalSubscription,
        entriesSubscription: _entriesSubscription,
        latestCtotal: _latestCtotal,
        latestEntries: _latestEntries,
        bloc: this,
      );
    });

    on<EntriesEventCtotalUpdated>((event, emit) {
      _ctotalUpdated(
        emit: emit,
        event: event,
        state: state,
      );
    });

    on<EntriesEventEntriesUpdated>((event, emit) {
      _entriesUpdated(
        emit: emit,
        event: event,
        state: state,
      );
    });

    on<EntriesEventUpdateEntry>((event, emit) async {
      await _updateEntry(event);
    });

    on<EntriesEventAddEntry>((event, emit) async {
      await _addEntry(event);
    });

    on<EntriesEventDeleteAll>((event, emit) async {
      await _deleteAll(event);
    });

    on<EntriesEventLogOut>((event, emit) async {
      await _logOut(
        emit: emit,
        ctotalSubscription: _ctotalSubscription,
        entriesSubscription: _entriesSubscription,
      );
    });
  }
}
