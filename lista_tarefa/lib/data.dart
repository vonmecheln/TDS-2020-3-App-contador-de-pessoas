import 'package:lista_tarefa/persistence/file_persistence.dart';
import 'package:lista_tarefa/persistence/key_value_persistence.dart';
import 'package:lista_tarefa/persistence/sqlite_persistence.dart';

abstract class PersistenceData {
  Future<void> save(String data);
  Future<String> load();
}

enum persistenceProvider { File, KeyValue, SQLite }

class DataFactory {
  static persistenceProvider providerType = persistenceProvider.File;

  static PersistenceData getProvider({persistenceProvider? type}) {
    providerType = type ?? persistenceProvider.File;

    switch (providerType) {
      case persistenceProvider.File:
        return FilePersistence();
      case persistenceProvider.KeyValue:
        return KeyValuePersistence();
      case persistenceProvider.SQLite:
        return SqlitePersistence();
      default:
        return FilePersistence();
    }
  }
}
