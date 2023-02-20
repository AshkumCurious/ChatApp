import 'chatroom.dart';
import 'package:flutter/material.dart';
import 'firebase_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FriendsContact extends StatefulWidget {
  const FriendsContact({Key? key}) : super(key: key);

  @override
  State<FriendsContact> createState() => _FriendsContactState();
}

class _FriendsContactState extends State<FriendsContact> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic>? userMap;
  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Messages'),
        ),
        body: StreamBuilder(
          stream: FF.firestore.collection('users').snapshots(),
            builder: (context,snapshot){


            if(snapshot.hasData){
              final data = snapshot.data?.docs;
              // for(var i in data!){
              //   list.add(i.data()['name']);
              // }

              return ListView.builder(
                itemCount: data!.length,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        userMap = {
                          'name' : data[index].data()['name'],
                          'uid': data[index].data()['uid']
                        };
                        String roomId = chatRoomId(
                        _auth.currentUser!.displayName!,userMap!['name']);

                        Navigator.of(context).push(
                        MaterialPageRoute(
                        builder: (_) => ChatRoom(
                        chatRoomId: roomId,
                        userMap: userMap!,
                        ),
                        ),
                        );
                      },
                      child: Container(
                        height: 60.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.person,
                              size: 50.0,),
                            Text(data[index].data()['name'].toString()),
                            Icon(Icons.arrow_right,
                              size: 50.0,
                            ),
                          ],
                        ),
                        color: Colors.yellow,
                      ),
                    ),
                  );
                },

              );


            }
            return Container();
                          },
        ),
        )
    );
  }
}


