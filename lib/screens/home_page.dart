import 'package:flutter/material.dart';
import 'package:todo/models/item.dart';
import 'package:todo/services/databaseClient.dart';
import 'add_task_dialog.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double pad = 15.0;
  List<Item> items = [];

  @override
  void initState() {
    super.initState();
    recuperer();
  }

  void recuperer() async {
    var itemsFromDB = await DatabaseClient().allItem();
    setState(() {
      items = itemsFromDB;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: items.isEmpty
          ?  Center(
        child: Text(
          "Aucune tâche enregistrée dans votre liste",
          style: TextStyle(fontSize: 20.0),
        ),
      )
          : ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          Item item = items[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0), // Rounded corners
            ),
            elevation: 5, // Shadow depth
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5), // Spacing between cards
            child: ListTile(
              title: Text(
                item.nom ?? "No name",
                style: const TextStyle(color: Colors.black),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => DatabaseClient().delete(item.id ?? 0, 'item').then((_) => recuperer()),
              ),
              leading: IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () => ajouter(item: item),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ajouter(),
        tooltip: 'Ajouter une tâche',
        child: const Icon(Icons.add,color: Colors.white),
        backgroundColor: Colors.teal,

      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> ajouter({Item? item}) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AddTaskDialog(item: item),
    );
    if (result != null && result.isNotEmpty) {
      DatabaseClient().update_or_insert(Item({'nom': result, 'id': item?.id})).then((_) => recuperer());
    }
  }
}




