import 'package:app_chat/services/auth.dart';
import 'package:app_chat/views/chatroom.dart';
import 'package:app_chat/views/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  const ProfilePage({required this.user});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isSendingVerification = false;
  bool _isSigningOut = false;

  late User _currentUser;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' ${_currentUser.displayName} Profile'),
        elevation: 0.0,
        backgroundColor: Colors.black,
        centerTitle: false,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushReplacement(
                MaterialPageRoute(
                  builder: (context) =>
                      ChatRoom(user:  _currentUser ),
                ),
              );
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icon(Icons.home)),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'NAME: ${_currentUser.displayName}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: 30.0),
            Text(
              'EMAIL: ${_currentUser.email}',
              style: Theme.of(context).textTheme.bodyText2,
            ),

            SizedBox(height: 30.0),
            _isSigningOut
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () async {
                setState(() {
                  _isSigningOut = true;
                });
                await FirebaseAuth.instance.signOut();
                setState(() {
                  _isSigningOut = false;
                });
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              child: Text('Sign out'),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}