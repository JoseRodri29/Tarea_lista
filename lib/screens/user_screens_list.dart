import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_lista/models/user.dart';
import 'package:flutter_lista/screens/user_details_screen.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late List<User> _users;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    String data = await DefaultAssetBundle.of(context).loadString('assets/tarea.json');
    List<dynamic> usersData = jsonDecode(data)['users'];
    setState(() {
      _users = usersData.map((user) => User.fromJson(user)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: _users == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_users[index].name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDetailsScreen(user: _users[index]),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
