import 'package:flutter/material.dart';
import 'friendscontact.dart';
import 'login.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  TextEditingController usercontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatApp'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Enter your name',
            style: TextStyle(
              fontSize: 25.0,
            ),
            ),
            SizedBox(
              height: 30.0,
            ),
            SizedBox(
              width: 300,
              child: TextField(
                controller: usercontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),

                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            GestureDetector(
              onTap: (){
                login(usercontroller.text).then((user){
                  if(user != null)
                    {
                      Navigator.of(context).push(MaterialPageRoute(builder:(_) =>  FriendsContact()));
                    }
                  else
                  {
                    print("Invalid name");
                  }
                });
                    },
    //=> Navigator.of(context).push(MaterialPageRoute(builder: FriendsContact())),
              child: Container(
                width: 60.0,
                height: 30.0,
                child: Center(child: Text("Submit")),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.blue,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
