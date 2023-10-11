import 'package:contatos_app/models/DatabaseContatoModel.dart';
import 'package:contatos_app/repository/database/DatabaseRepository.dart';
import 'package:contatos_app/shared/widgets/input.dart';
import 'package:contatos_app/shared/widgets/profileImage.dart';
import 'package:flutter/material.dart';

class ContatoDetailPage extends StatefulWidget {
  final String headerTitle;
  final ContatoModel? contato;
  final Future<void> Function(ContatoModel contato) onPressSave;

  const ContatoDetailPage(
      {super.key,      
      required this.headerTitle,
      required this.onPressSave,this.contato});

  @override
  State<ContatoDetailPage> createState() => _ContatoDetailPageState();
}

class _ContatoDetailPageState extends State<ContatoDetailPage> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String imagePath = "";

  DatabaseRepository repository = DatabaseRepository();
  bool loading = false;

  void close() async => Navigator.pop(context);

  void onPressSave() async {
    if (validateFields()) {
      await widget.onPressSave(ContatoModel.create(nomeController.text,
          int.parse(telefoneController.text), emailController.text, imagePath));
      close();
    }
  }

  Future<void> showModal() async {}

  bool validateFields() {
    if (nomeController.text.isEmpty ||
        telefoneController.text.isEmpty ||
        emailController.text.isEmpty) {
      showSnackMessage("Há campo(s) vazio(s)!");
      return false;
    }
    setFields();
    return true;
  }

  void showSnackMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return ScaffoldMessenger(
            child: SnackBar(
                content: Text(message), duration: const Duration(seconds: 3)));
      },
    );
  }

  @override
  void initState() {
    initFields();
    super.initState();
  }

  void initFields() {
    setState(() {
      nomeController.text = widget.contato?.nome ?? "";
      telefoneController.text = widget.contato?.telefone.toString() ?? "";
      emailController.text = widget.contato?.email ?? "";
    });
  }

  void setFields() {
    setState(() {
      widget.contato?.nome = nomeController.text;
      widget.contato?.telefone = int.parse(telefoneController.text);
      widget.contato?.email = emailController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.headerTitle),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Container(
                width: 500,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: ProfileImage(
                            imagePath: widget.contato?.profilePath ?? "",
                            onPress: showModal),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Input(label: "Nome", controller: nomeController),
                      const SizedBox(
                        height: 8,
                      ),
                      Input(label: "Telefone", controller: telefoneController),
                      const SizedBox(
                        height: 8,
                      ),
                      Input(label: "Email", controller: emailController),
                      const SizedBox(
                        height: 16,
                      ),
                    ]),
              ),
            ),
          )),
    );
  }
}
