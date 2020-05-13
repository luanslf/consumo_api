import 'package:consumo_api/models/user.dart';
import 'package:flutter/material.dart';

class UsersListItem extends StatelessWidget {
  
  final User user;

  UsersListItem({@required this.user});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text(user.name),
        subtitle: Text(user.company.name),
        leading: Icon(Icons.person_outline),
      ),
    );
  }
}