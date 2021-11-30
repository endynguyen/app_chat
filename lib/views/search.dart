import 'package:app_chat/services/constants.dart';
import 'package:app_chat/services/database.dart';
import 'package:app_chat/views/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  // TextEditingController searchEditingController = new TextEditingController();
  // late QuerySnapshot searchResultSnapshot;
  //
  // bool isLoading = false;
  // bool haveUserSearched = false;

  //
  // initiateSearch() async {
  //   if(searchEditingController.text.isNotEmpty){
  //     setState(() {
  //       isLoading = true;
  //     });
  //      databaseMethods.SearchByName(searchEditingController.text)
  //         .then((snapshot){
  //       searchResultSnapshot = snapshot;
  //       print("$searchResultSnapshot");
  //       setState(() {
  //         isLoading = false;
  //         haveUserSearched = true;
  //       });
  //     });
  //   }
  // }
  // Widget userList(){
  //   return haveUserSearched ? ListView.builder(
  //       shrinkWrap: true,
  //       itemCount: searchResultSnapshot.docs.length,
  //       itemBuilder: (context, index){
  //         return userTile(
  //           searchResultSnapshot.docs[index].data()['name'],
  //           searchResultSnapshot.docs[index].data()['mail'],
  //         );
  //       }) : Container();
  // }
  //
  // Widget userList(){
  //   return StreamBuilder<QuerySnapshot>(
  //       stream: searchResultSnapshot,
  //     builder: (context,AsyncSnapshot<QuerySnapshot> streamSnapshot) {
  //         if(streamSnapshot.hasData){
  //           return ListView.builder(
  //             itemCount: streamSnapshot.data!.docs.length,
  //               itemBuilder: (context, index){
  //               final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
  //               return userTile(
  //                 documentSnapshot['name'],
  //                 documentSnapshot['email'],
  //                           );
  //               }
  //           );
  //         } else return Container(
  //           child: CircularProgressIndicator(),
  //         );
  //
  //     }
  //   );
  // }

  /// 1.create a chatroom, send user to the chatroom, other userdetails
  sendMessage(String userName) {
    List<String> users = [Constants.myName, userName];

    String chatRoomId = getChatRoomId(Constants.myName, userName);

    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId": chatRoomId,
    };
    databaseMethods.addChatRoom(chatRoom, chatRoomId);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Chat(
                  chatRoomId: chatRoomId,
              userName: userName,
                )));
  }

  Widget userTile(String name,String email){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22
                ),
              ),
              Text(
                email,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 13
                ),
              )
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              sendMessage(name);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(24)
              ),
              child: Icon(Icons.send,
              color: Colors.white,
              size: 30,)),
            ),

        ],
      ),
    );
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  @override
  void initState() {
    super.initState();
  }

  String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('All user'),
          backgroundColor: Colors.black,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users') .where('name', isGreaterThanOrEqualTo: name).snapshots(),
            builder: (context,AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if(streamSnapshot.hasData){
                return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index){
                      final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                      if(documentSnapshot['name']!=Constants.myName) {
                        return userTile(
                          documentSnapshot['name'],
                          documentSnapshot['email'],
                        );
                      } else return Container();
                    }
                );
              } else return Container(
                child: CircularProgressIndicator(),
              );

            }
        ));
  }
}
