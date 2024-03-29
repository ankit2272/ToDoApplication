// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapplication/viewPage.dart';
import 'todo.dart';
import 'todoView.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences prefs;
  List<Todo> todos = [];
  setupTodo() async {
    prefs = await SharedPreferences.getInstance();
    String? stringTodo = prefs.getString('todo');
    List todoList = [];
    if (stringTodo != null) {
      todoList = jsonDecode(stringTodo);
    }
    for (var todo in todoList) {
      setState(() {
        todos.add(
          Todo(
            description: todo['description'],
            status: todo['status'],
            id: todo['id'],
            title: todo['title'],
          ).fromJson(todo),
        );
      });
    }
  }

  void saveTodo() {
    List items = todos.map((e) => e.toJson()).toList();
    prefs.setString('todo', jsonEncode(items));
  }

  @override
  void initState() {
    super.initState();
    setupTodo();
  }

  Color appcolor = Color.fromRGBO(58, 66, 86, 1.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appcolor,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Todo"),
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: todos.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              elevation: 8.0,
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(64, 75, 96, .9),
                ),
                child: InkWell(
                  onTap: () async {
                    Todo? t = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TodoView(todo: todos[index])));
                    if (t != null) {
                      setState(() {
                        todos[index] = t;
                      });
                      saveTodo();
                    }
                  },
                  child: makeListTile(todos[index], index),
                  // todos[index]
                ),
              ));
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromRGBO(58, 66, 86, 1.0),
        child: Text(
          'Tap on task to update ',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color.fromARGB(255, 172, 170, 170)),
        ),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        child: Text("Add"),
        backgroundColor: Colors.black12,
        onPressed: () {
          addTodo();
        },
      ),
    );
  }

  addTodo() async {
    int id = Random().nextInt(30);
    Todo t = Todo(id: id, title: '', description: '', status: false);
    Todo? returnTodo = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => TodoView(todo: t)));
    if (returnTodo != null) {
      setState(() {
        todos.add(returnTodo);
      });
      saveTodo();
    }
  }

  makeListTile(Todo todo, int index) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(width: 1.0, color: Colors.white24),
          ),
        ),
        child: CircleAvatar(
          backgroundColor: Colors.black26,
          child: Text("${index + 1}"),
        ),
      ),
      title: Row(
        children: [
          Text(
            todo.title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 10,
          ),
          todo.status
              ? Icon(
                  Icons.verified,
                  color: Colors.greenAccent,
                )
              : Container()
        ],
      ),
      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

      subtitle: Wrap(
        children: <Widget>[
          Text(todo.description,
              overflow: TextOverflow.clip,
              maxLines: 1,
              style: TextStyle(color: Colors.white))
        ],
      ),
      trailing: Wrap(
        spacing: 5, // space between two icons
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewPage(todo),
                ),
              );
              // ViewPage(todo);
            },
            child: Icon(Icons.open_in_full, color: Colors.white, size: 30.0),
          ),
          InkWell(
            onTap: () {
              delete(todo);
            },
            child: Icon(Icons.delete, color: Colors.white, size: 30.0),
          ),
        ],
      ),
    );
  }

  delete(Todo todo) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Alert"),
        content: Text("Are you sure to delete"),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: Text("No"),
          ),
          FlatButton(
            onPressed: () {
              setState(() {
                todos.remove(todo);
              });
              Navigator.pop(ctx);
              saveTodo();
            },
            child: Text("Yes"),
          )
        ],
      ),
    );
  }
}
