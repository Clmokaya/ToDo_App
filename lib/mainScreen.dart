import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/addTodo.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todoapp/widgets/todoLists.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> todoList = [];

  void addTodo({required String todoText}) {
    if (todoList.contains(todoText)) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Already exists"),
              content: Text("This todo data already exists"),
              actions: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text("close"))
              ],
            );
          });
      return;
    }

    setState(() {
      todoList.insert(0, todoText);
    });
    updateLocalData();
    Navigator.pop(context);
  }

  void getTodo() {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: 200,
              child: AddTodo(
                addTodo: addTodo,
              ),
            ),
          );
        });
  }

  void updateLocalData() async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('todoList', todoList);
  }

  void loadData() async {
// Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      todoList = (prefs.getStringList("todoList") ?? []).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          shape: CircleBorder(),
          backgroundColor: Colors.blueGrey[900],
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: getTodo),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              color: Colors.blueGrey[900],
              height: 200,
              child: Center(
                  child: Text(
                "ToDo App",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
              width: double.infinity,
            ),
            ListTile(
              onTap: () {
                launchUrl(Uri.parse("https://cmm.app"));
              },
              leading: Icon(Icons.person),
              title: Text(
                'About Me',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              onTap: () {
                launchUrl(Uri.parse("mailto:someone@example.com"));
              },
              leading: Icon(Icons.email),
              title: Text(
                'Contact Me',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('ToDo App'),
      ),
      body: todoListBuilder(
        todoList: todoList,
        updateLocalData: updateLocalData,
      ),
    );
  }
}
