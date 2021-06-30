import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutterloginwithtodo/constants/constants.dart';
import 'package:flutterloginwithtodo/provider/todo_provider.dart';
import 'package:flutterloginwithtodo/widgets/color_wideget.dart';
import 'package:provider/provider.dart';

class AddTodo extends StatefulWidget {
  final bool isEditing;
  final String note;
  final int id;

  AddTodo({this.id = 0, this.note = "", this.isEditing = false});

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final storage = new FlutterSecureStorage();
  TextEditingController todo = TextEditingController();
  List<int> colorList = [whiteColor, blueColor, redColor, blackColor];
  int selectedColor = whiteColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      todo.text = widget.isEditing ? widget.note : "";
    });
    // this.todo.text = widget.isEditing ? widget.note : "hello";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? "Update Todo" : "Add to Todo"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            TextField(
              controller: todo,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Coding ....",
              ),
            ),
            colorWidgetList(),
            ElevatedButton(
              child: Text(
                widget.isEditing ? "Update Todo" : "Add to Todo",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                addTodos(context);
                // addTodos(widget.id);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget colorWidgetList() {
    return Container(
      height: 60.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: colorList.length,
        itemBuilder: (context, index) {
          return TextButton(
            child: ColorWidget(colorList[index]),
            onPressed: () {
              selectedColor = colorList[index];
            },
          );
        },
      ),
    );
  }

  void addTodos(BuildContext ctx) async {
    if (todo.text.isEmpty) {
      final snackBar = SnackBar(
        content: Text("Please enter your todo's"),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );

      ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
    } else {
      if (widget.isEditing) {
        Provider.of<TodoProvider>(context, listen: false)
            .updateTodo(widget.id, todo.text, selectedColor);
        // await storage.write(key: "todo", value: todo.text);
        Navigator.pop(context);
      } else {
        Provider.of<TodoProvider>(context, listen: false)
            .addTodo(todo.text, selectedColor);
        // await storage.write(key: "todo", value: todo.text);
        Navigator.pop(context);
      }
    }
  }
}
