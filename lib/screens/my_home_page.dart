import 'dart:convert';
import 'package:consumo_api/models/user.dart';
import 'package:consumo_api/widgets/users_list_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<User> users = List<User>();
  Future<List<User>> futureUsers;

  Future<List<User>> getUsers() async {
    List<User> users = List<User>();
    
    await http.get('https://jsonplaceholder.typicode.com/users')
    .then((response) {
      if (response.statusCode == 200) {
        List decodedJson = jsonDecode(response.body);
        decodedJson.forEach((userJson) {
          users.add(User.fromJson(userJson));
        });
      } else {
        print('status code: ${response.statusCode}');
      }
    })
    .catchError((error) {
      print(error);
    });

    return users;
  }

  void reloadUsers() {
    setState(() {
      futureUsers = getUsers();
    });
  }

  @override
  void initState() {
    super.initState();
    futureUsers = getUsers();
  }

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
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.update), 
          onPressed: reloadUsers,
        ),
      ],
    );
  }

  Widget myBody() {
    return FutureBuilder(
      future: futureUsers,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none || snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done) {
          users = snapshot.data;
          return usersListView();
        }
        return Container(
          child: Text('Lista de usuários está vazia'),
        );
      },
    );
  }

  Widget usersListView() {
    return ListView.builder(
      itemCount: users.length, 
      itemBuilder: (context, index) {
        return UsersListItem(user: users[index]);
      },
    );
  }
}