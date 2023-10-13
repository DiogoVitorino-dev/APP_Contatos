import 'package:contatos_app/models/DatabaseContatoModel.dart';
import 'package:contatos_app/repository/database/DatabaseRepository.dart';
import 'package:contatos_app/services/CropImage.dart';
import 'package:contatos_app/shared/widgets/input.dart';
import 'package:contatos_app/shared/widgets/profileImage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class ContatoDetailPage extends StatefulWidget {
  final String headerTitle;
  final ContatoModel? contato;
  final Future<void> Function(ContatoModel contato) onPressSave;

  const ContatoDetailPage(
      {super.key,
      required this.headerTitle,
      required this.onPressSave,
      this.contato});

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
    setState(() {
      loading = true;
    });

    if (validateFields()) {
      var newContato = widget.contato;

      newContato ??= ContatoModel.create(nomeController.text,
          int.parse(telefoneController.text), emailController.text, imagePath);

      newContato.nome = nomeController.text;
      newContato.email = emailController.text;
      newContato.telefone = int.parse(telefoneController.text);
      newContato.profilePath = imagePath;

      await widget.onPressSave(newContato);

      setState(() {
        loading = false;
      });

      close();
    }

    setState(() {
      loading = false;
    });
  }

  bool validateFields() {
    if (nomeController.text.isEmpty || telefoneController.text.isEmpty) {
      showSnackMessage("Há campo(s) vazio(s)!");
      return false;
    }
    return true;
  }

  void showSnackMessage(String message) {
    print(message);
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
      imagePath = widget.contato?.profilePath ?? "";
    });
  }

  Future<String> openCamera() async {
    final ImagePicker picker = ImagePicker();
    XFile? photo = await picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      return photo.path;
    }

    return "";
  }

  Future<String> openGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      return image.path;
    }

    return "";
  }

  void setImage(String path) {
    setState(() {
      imagePath = path;
    });
  }

  void showOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(children: [
          ListTile(
            title: const Text("Câmera"),
            leading: const Icon(Icons.camera_alt),
            onTap: () async {
              var image = await openCamera();
              image = await CropImage(image,save: true);
              setImage(image);
              close();
            },
          ),
          ListTile(
            title: const Text("Galeria"),
            leading: const Icon(Icons.photo),
            onTap: () async {
              var image = await openGallery();
              image = await CropImage(image,save: true);
              setImage(image);
              close();
            },
          )
        ]);
      },
    );
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
                        child: ProfileImage(image: imagePath, size: 120, onPress: showOptions),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Input(label: "Nome*", controller: nomeController),
                      const SizedBox(
                        height: 8,
                      ),
                      Input(label: "Telefone*", controller: telefoneController,inputType: TextInputType.phone),
                      const SizedBox(
                        height: 8,
                      ),
                      Input(label: "Email", controller: emailController,inputType: TextInputType.emailAddress),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              style: const ButtonStyle(
                                  fixedSize: MaterialStatePropertyAll(
                                      Size.fromWidth(120)),
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.green)),
                              onPressed: onPressSave,
                              child: const Text(
                                "Salvar",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              )),
                          Visibility(
                              visible: loading,
                              child: Container(
                                  width: 20,
                                  height: 20,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: const CircularProgressIndicator())),
                          TextButton(
                              style: const ButtonStyle(
                                fixedSize: MaterialStatePropertyAll(
                                    Size.fromWidth(120)),
                              ),
                              onPressed: close,
                              child: const Text("Cancelar"))
                        ],
                      )
                    ]),
              ),
            ),
          )),
    );
  }
}
