import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stokpile/extensions/month_breakpoints.dart';
import 'package:stokpile/constants/cloud_storage_constants.dart';
import 'package:stokpile/services/entries/bloc/entries_bloc.dart';
import 'package:stokpile/services/entries/entry.dart';
import 'package:stokpile/services/profile/bloc/profile_bloc.dart';
import 'package:stokpile/utilities/components/entry_cards/builds/add_entry_methods.dart';
import 'package:stokpile/utilities/components/entry_cards/builds/remove_entry_methods.dart';
import 'package:stokpile/utilities/components/entry_cards/builds/update_entry_methods.dart';
import 'package:stokpile/utilities/components/history_box/history_box.dart';
import 'package:stokpile/utilities/loading_screen/empty_loading_state.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  final GlobalKey<AnimatedListState> _animatedListKey =
      GlobalKey<AnimatedListState>();
  List<Entry> entriesCache = [];
  Map<String, Map<String, bool>> entryCardMetadata = {};
  List<dynamic> displayedItems = [];

  @override
  void initState() {
    entriesCache = context.read<EntriesBloc>().state.entries.toList();
    for (var entry in entriesCache) {
      entryCardMetadata.addAll({
        entry.documentId!: {
          entryCardIsExpandedFieldName: false,
          entryCardIsNewFieldName: true,
        }
      });
    }
    displayedItems = entriesCache.withMonthYearBreakpoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      if (state is ProfileStateLoggedIn) {
        return BlocBuilder<EntriesBloc, EntriesState>(
          builder: (context, state) {
            if (state is EntriesStateLoggedIn) {
              List<Entry> entriesToRemove = createEntriesToRemoveList(state);
              List<Entry> entriesToAdd = createEntriesToAddList(state);
              List<Entry> entriesUpdated = createEntriesUpdatedList(
                entriesToAdd,
                entriesToRemove,
              );
              if (_animatedListKey.currentState != null) {
                updateEntriesLists(
                  entriesUpdated: entriesUpdated,
                  entriesToRemove: entriesToRemove,
                  entriesToAdd: entriesToAdd,
                );
              }
              return HistoryBox(
                animatedListKey: _animatedListKey,
                entriesCache: entriesCache,
                entryCardMetadata: entryCardMetadata,
              );
            } else {
              throw Exception(state);
            }
          },
        );
      } else {
        return const LoadingState();
      }
    });
  }

  List<Entry> createEntriesToAddList(EntriesStateLoggedIn state) {
    return state.entries.toSet().difference(entriesCache.toSet()).toList();
  }

  List<Entry> createEntriesToRemoveList(EntriesStateLoggedIn state) {
    return entriesCache.toSet().difference(state.entries.toSet()).toList();
  }

  void updateEntriesLists({
    required List<Entry> entriesUpdated,
    required List<Entry> entriesToRemove,
    required List<Entry> entriesToAdd,
  }) {
    updateChangedEntries(
      animatedListKey: _animatedListKey,
      displayedList: displayedItems,
      entriesCacheList: entriesCache,
      entriesList: entriesUpdated,
      expandedCardsList: entryCardMetadata,
    );
    removeDeletedEntries(
      animatedListKey: _animatedListKey,
      displayedList: displayedItems,
      entriesCacheList: entriesCache,
      entriesList: entriesToRemove,
      expandedCardsList: entryCardMetadata,
    );
    addNewEntries(
      animatedListKey: _animatedListKey,
      displayedList: displayedItems,
      entriesCacheList: entriesCache,
      entriesList: entriesToAdd,
      expandedCardsList: entryCardMetadata,
    );
  }
}
