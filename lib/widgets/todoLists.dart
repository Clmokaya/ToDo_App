import 'package:flutter/material.dart';

class todoListBuilder extends StatefulWidget {
  List<String> todoList;

  void Function() updateLocalData;
  todoListBuilder(
      {super.key, required this.todoList, required this.updateLocalData});

  @override
  State<todoListBuilder> createState() => _todoListBuilderState();
}

class _todoListBuilderState extends State<todoListBuilder> {
//This item gets triggered when list item is clicked

  void onItenClicked({required int index}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    widget.todoList.removeAt(index);
                  });
                  widget.updateLocalData();
                  Navigator.pop(context);
                },
                child: Text('mark as done')),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return (widget.todoList.isEmpty)
        ? Center(child: Text('No items on your todo list'))
        : ListView.builder(
            itemCount: widget.todoList.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.startToEnd,
                background: Container(
                  color: Colors.green[300],
                  child: Row(
                    children: [
                      Padding(padding: EdgeInsets.all(8.0)),
                      Icon(Icons.check),
                    ],
                  ),
                ),
                onDismissed: (direction) {
                  setState(() {
                    widget.todoList.removeAt(index);
                  });
                  widget.updateLocalData();
                },
                child: ListTile(
                    onTap: () {
                      onItenClicked(index: index);
                    },
                    title: Text(widget.todoList[index])),
              );
            });
  }
}
