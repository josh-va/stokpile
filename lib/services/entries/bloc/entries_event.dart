part of 'entries_bloc.dart';

sealed class EntriesEvent {
  const EntriesEvent();
}

class EntriesEventLogIn extends EntriesEvent {
  final String uid;
  const EntriesEventLogIn(this.uid);
}

class EntriesEventLogOut extends EntriesEvent {
  const EntriesEventLogOut();
}

class EntriesEventCtotalUpdated extends EntriesEvent {
  final num ctotal;
  const EntriesEventCtotalUpdated(this.ctotal);
}

class EntriesEventEntriesUpdated extends EntriesEvent {
  final Iterable<Entry> entries;
  const EntriesEventEntriesUpdated(this.entries);
}

class EntriesEventUpdateEntry extends EntriesEvent {
  final String uid;
  final Entry entry;
  const EntriesEventUpdateEntry({
    required this.entry,
    required this.uid,
  });
}

class EntriesEventAddEntry extends EntriesEvent {
  final String uid;
  final Entry entry;
  const EntriesEventAddEntry({
    required this.entry,
    required this.uid,
  });
}

class EntriesEventDeleteAll extends EntriesEvent {
  final String uid;
  const EntriesEventDeleteAll(this.uid);
}
