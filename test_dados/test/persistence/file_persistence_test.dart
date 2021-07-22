import 'package:flutter_test/flutter_test.dart';
import 'package:test_dados/persistence/file_persistence.dart';

void main() {
  String texto = '';

  setUpAll(() {
    texto = 'TEXTO DE TESTE';
  });

  group('FilePersistence', () {
    test('Salvar um texto', () async {
      var persist = await FilePersistence();
      await persist.save(texto);
    });

    test('Ler um texto', () async {
      var persist = await FilePersistence();
      var content = await persist.load();
      assert(content == texto);
    });
  });
}
