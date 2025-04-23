abstract class CloudStorageException implements Exception {
  const CloudStorageException();
}

class CouldNotCreateEntryException extends CloudStorageException {}

class CouldNotCreateProfileException extends CloudStorageException {}

class CouldNotDeleteEntryException extends CloudStorageException {}

class CouldNotSetFavoriteException extends CloudStorageException {}

class CouldNotUpdateEntryException extends CloudStorageException {}

class CouldNotUpdateProfileNameException extends CloudStorageException {}

class CouldNotUpdateProfileSettingsException extends CloudStorageException {}

class InvalidEntryTypeException extends CloudStorageException {}
