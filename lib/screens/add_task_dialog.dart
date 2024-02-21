import 'package:flutter/material.dart';
import 'package:todo/models/item.dart';

class AddTaskDialog extends StatefulWidget {
  final Item? item;

  const AddTaskDialog({Key? key, this.item}) : super(key: key);

  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.item?.nom ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.item == null ? 'Ajouter une tâche' : 'Modifier la tâche'),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(hintText: "Nom de la tâche"),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Annuler'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: const Text('Valider'),
          onPressed: () {
            Navigator.of(context).pop(_controller.text);
          },
        ),
      ],
    );
  }
}
