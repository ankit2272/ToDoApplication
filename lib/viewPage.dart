import 'package:flutter/material.dart';
import 'todo.dart';

class ViewPage extends StatefulWidget {
  Todo todo;
  ViewPage(Todo this.todo);

  @override
  State<ViewPage> createState() => _ViewPageState(todo: this.todo);
}

class _ViewPageState extends State<ViewPage> {
  Todo todo;
  _ViewPageState({required this.todo});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        centerTitle: true,
        elevation: 5,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text("Todo View"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 10.0),
                alignment: Alignment.center,
                width: double.infinity,
                child: Text(
                  "Title",
                  style: TextStyle(
                    color: Color.fromARGB(255, 171, 190, 152),
                    fontSize: 35.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 20.0),
                alignment: Alignment.center,
                width: double.infinity,
                child: Text(
                  "${todo.title}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10.0),
                alignment: Alignment.center,
                width: double.infinity,
                child: Text(
                  "Description",
                  style: TextStyle(
                    color: Color.fromARGB(255, 171, 190, 152),
                    fontSize: 35.0,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: Text(
                  "${todo.description}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
