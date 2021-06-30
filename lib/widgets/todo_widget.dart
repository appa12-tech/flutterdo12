import 'package:flutter/material.dart';
import 'package:flutterloginwithtodo/add_todo_page.dart';
import 'package:flutterloginwithtodo/model/todo.dart';
import 'package:flutterloginwithtodo/provider/todo_provider.dart';
import 'package:provider/provider.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;
  Color listColor;

  TodoWidget(this.todo);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Color(int.parse(todo.color)),
        child: ListTile(
          title: Text('${todo.note}'),
          trailing: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Provider.of<TodoProvider>(context, listen: false)
                  .removeTodo(todo.id);
            },
          ),
          leading: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddTodo(id: todo.id, note: todo.note, isEditing: true),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
