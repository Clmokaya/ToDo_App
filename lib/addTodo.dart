import 'package:flutter/material.dart';

class AddTodo extends StatefulWidget {
  void Function({required String todoText}) addTodo;

  AddTodo({super.key, required this.addTodo});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController todoText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('add todo'),
        TextField(
          onSubmitted: (value) {
            if (todoText.text != "") {
              widget.addTodo(todoText: todoText.text);
            }
            todoText.text = "";
          },
          autofocus: true,
          controller: todoText,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(5),
              hintText: "write your to do here..."),
        ),
        ElevatedButton(
            onPressed: () {
              if (todoText.text != "") {
                widget.addTodo(todoText: todoText.text);
              }

              todoText.text = "";
            },
            child: Text('Add'))
      ],
    );
  }
}
