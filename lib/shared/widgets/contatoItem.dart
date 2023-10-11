import 'dart:io';

import 'package:contatos_app/models/DatabaseContatoModel.dart';
import 'package:flutter/material.dart';

class ContatoItem extends StatefulWidget {
  final ContatoModel contato;
  final Function() onPress;

  const ContatoItem({
    super.key,
    required this.contato,
    required this.onPress,
  });

  @override
  State<ContatoItem> createState() => _ContatoItemState();
}

class _ContatoItemState extends State<ContatoItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPress,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: ListTile(leading: Image.file(File(widget.contato.profilePath) ),)
      ),
    );
  }
}
