import 'package:lista_tarefa/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyValuePersistence implements PersistenceData {
  final String key = 'DATA';

  @override
  Future<String> load() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }

  @override
  Future<void> save(String data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, data);
  }
}
