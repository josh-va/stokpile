enum EntryType {
  save,
  spend,
  delete,
}

extension EntryTypeParse on EntryType {
  static EntryType fromString(String typeString) {
    return EntryType.values.firstWhere(
      (e) => e.toString().split('.').last == typeString,
      orElse: () => throw ArgumentError('Invalid Entry Type'),
    );
  }
}
