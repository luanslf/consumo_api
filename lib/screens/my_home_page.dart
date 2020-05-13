import 'package:consumo_api/models/user.dart';
import 'package:consumo_api/widgets/users_list_item.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<User> users = List<User>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: myBody(),
    );
  }

  Widget myAppBar() {
    return AppBar(
      title: Text('Api de Usuários'),
    );
  }

  Widget myBody() {
    return ListView.builder(
      itemCount: users.length, 
      itemBuilder: (context, index) {
        return UsersListItem(user: users[index]);
      },
    );
  }
}