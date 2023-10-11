import 'package:contatos_app/models/DatabaseContatoModel.dart';

abstract class InterfaceDatabaseRepository {
  Future<List<ContatoModel>> get({String? nome});

  Future<void> create(ContatoModel contato);

  Future<void> update(ContatoModel contato);

  Future<void> delete(String id);
}
