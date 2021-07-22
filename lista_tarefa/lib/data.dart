abstract class PersistenceData {
  Future<void> save(String data);
  Future<String> load();
}

// PerssitenceData
//  ->load
//  ->save

// FilePersistence
// SQLitePersistence
// 