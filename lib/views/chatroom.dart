import 'package:app_chat/services/constants.dart';
import 'package:app_chat/views/profile.dart';
import 'package:app_chat/views/search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  final User user;
  const ChatRoom({required this.user});
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  late Stream chatRooms;


  // Widget chatRoomsList() {
  //   return StreamBuilder(
  //     stream: chatRooms,
  //     builder: (context, snapshot) {
  //       var docs;
  //       return snapshot.hasData
  //           ? ListView.builder(
  //           itemCount: snapshot.data!.docs.length,
  //           shrinkWrap: true,
  //           itemBuilder: (context, index) {
  //             return ChatRoomsTile(
  //               name:'',
  //               chatRoomId: '',
  //               // name: snapshot.data.documents[index].data['chatRoomId']
  //               //     .toString()
  //               //     .replaceAll("_", "")
  //               //     .replaceAll(Constants.myName, ""),
  //               // chatRoomId: snapshot.data.documents[index].data["chatRoomId"],
  //             );
  //           })
  //           : Container();
  //     },
  //   );
  // }

  // @override
  // void initState() {
  //   getUserInfogetChats();
  //   super.initState();
  // }

  // getUserInfogetChats() async {
  //   Constants.myName = await HelperFunctions.getUserNameSharedPreference();
  //   DatabaseMethods().getUserChats(Constants.myName).then((snapshots) {
  //     setState(() {
  //       chatRooms = snapshots;
  //       print(
  //           "we got the data + ${chatRooms.toString()} this is name  ${Constants.myName}");
  //     });
  //   });
  // }
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
        title: Text('Welcome  ${_currentUser.displayName}'),
        elevation: 0.0,
        centerTitle: false,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushReplacement(
                MaterialPageRoute(
                  builder: (context) =>
                      ProfilePage(user:  _currentUser ),
                ),
              );
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.account_circle)),
          )
        ],
      ),
      body: Container(
        // child: chatRoomsList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Search()));
        },
      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String name;
  final String chatRoomId;

  ChatRoomsTile({required this.name,required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        // Navigator.push(context, MaterialPageRoute(
        //     builder: (context) => Chat(
        //       chatRoomId: chatRoomId,
        //     )
        // ));
      },
      child: Container(
        color: Colors.black26,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: Colors.brown,
                  borderRadius: BorderRadius.circular(30)),
              child: Text(name.substring(0, 1),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'OverpassRegular',
                      fontWeight: FontWeight.w300)),
            ),
            SizedBox(
              width: 12,
            ),
            Text(name,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'OverpassRegular',
                    fontWeight: FontWeight.w300))
          ],
        ),
      ),
    );
  }
}