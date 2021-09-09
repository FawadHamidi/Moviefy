import 'package:flutter/material.dart';
import 'package:moviefy/Services/database_helper/database.dart';
import 'package:moviefy/Services/database_helper/service_locator.dart';
import 'package:moviefy/providers/provider.dart';
import 'package:provider/provider.dart';

class DeleteIcon extends StatefulWidget {
  final int index;
  ValueChanged<int> onDelete;

  DeleteIcon(this.index, {this.onDelete});

  @override
  _DeleteIconState createState() => _DeleteIconState();
}

class _DeleteIconState extends State<DeleteIcon> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ApiProvider>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.black26.withOpacity(0.2),
      ),
      child: IconButton(
          icon: Icon(Icons.delete, color: Colors.yellow),
          onPressed: () async {
            print('###############');

            widget.onDelete(widget.index);
            setState(() {
              var db = locator<DatabaseHelper>();
              db.delete(provider.queryList[widget.index].id);
            });

            await provider.loadQueries();
          }),
    );
  }
}
