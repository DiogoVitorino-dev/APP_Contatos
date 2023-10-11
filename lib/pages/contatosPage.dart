import 'package:contatos_app/models/DatabaseContatoModel.dart';
import 'package:contatos_app/pages/contatoDetailPage.dart';
import 'package:contatos_app/repository/database/DatabaseRepository.dart';
import 'package:contatos_app/shared/widgets/contatoItem.dart';
import 'package:flutter/material.dart';

class ContatosPage extends StatefulWidget with WidgetsBindingObserver {
  const ContatosPage({super.key});

  @override
  State<ContatosPage> createState() => _ContatosPageState();
}

class _ContatosPageState extends State<ContatosPage> {
  TextEditingController nomeController = TextEditingController();
  List<ContatoModel> list = [];
  DatabaseRepository repositoryDatabase = DatabaseRepository();
  bool loading = false;

  Future<void> getList({String? nome}) async {
    setState(() {
      loading = true;
    });

    list = await repositoryDatabase.get();

    setState(() {
      loading = false;
    });
  }

  Future<void> createItem(ContatoModel contato) async {
    await repositoryDatabase.create(contato);
    await getList();
  }

  Future<void> updateItem(ContatoModel contato) async {
    await repositoryDatabase.update(contato);
    await getList();
  }

  void navigateToDetail(String headerTitle,
      Future<void> Function(ContatoModel contato) onPressSave,
      {ContatoModel? contato}) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ContatoDetailPage(
              headerTitle: headerTitle,
              contato: contato,
              onPressSave: onPressSave),
        ));
  }

  Future<void> deleteItem(ContatoModel contato) async {
    await repositoryDatabase.delete(contato.objectId);
    await getList();
  }

  @override
  void initState() {
    getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Consultar Contato"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToDetail("Criar contato", createItem),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: TextField(
                    controller: nomeController,
                    maxLength: 8,
                    onSubmitted: (value) async {
                      await getList(nome: value);
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: const Icon(Icons.search),
                        hintText: "contato"),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                IconButton(
                    onPressed: () async {
                      await getList();
                    },
                    icon: const Icon(Icons.refresh))
              ],
            ),
            loading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (_, index) {
                        var item = list[index];
                        return Dismissible(
                          key: Key(item.objectId),
                          onDismissed: (direction) async {
                            await deleteItem(item);
                          },
                          child: ContatoItem(
                            contato: item,
                            onPress: () {
                              navigateToDetail("Criar contato", updateItem,
                                  contato: item);
                            },
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
