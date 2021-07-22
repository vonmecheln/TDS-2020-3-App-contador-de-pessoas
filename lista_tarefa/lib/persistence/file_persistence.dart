import 'dart:io';

import 'package:lista_tarefa/data.dart';
import 'package:path_provider/path_provider.dart';

class FilePersistence implements PersistenceData {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/DATA.txt');
  }

  @override
  Future<String> load() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return '';
    }
  }

  @override
  Future<void> save(String data) async {
    final file = await _localFile;
    file.writeAsString('$data');
  }
}
