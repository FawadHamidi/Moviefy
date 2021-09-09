import 'package:flutter/material.dart';
import 'package:moviefy/providers/provider.dart';
import 'package:provider/provider.dart';

class DeleteAll extends StatefulWidget {
  @override
  _DeleteAllState createState() => _DeleteAllState();
}

class _DeleteAllState extends State<DeleteAll> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ApiProvider>(context, listen: false);
    return FloatingActionButton(
      backgroundColor: Colors.yellow,
      child: Icon(
        Icons.delete,
        color: Colors.black,
      ),
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Delete all'),
          content: const Text('Do you want to delete all?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'OK');
                setState(() {
                  provider.deleteAllQueries();
                });

                await provider.loadQueries();
              },
              child: const Text('Yes'),
            ),
          ],
        ),
      ),
    );
  }
}
