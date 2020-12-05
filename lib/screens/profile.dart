import 'package:flash_chat/screens/login.dart';
import 'package:flash_chat/screens/register.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flash_chat/providers/app_provider.dart';
import 'package:flash_chat/screens/splash.dart';
import 'package:flash_chat/util/const.dart';
import 'package:flash_chat/util/items.dart';
import 'package:flash_chat/widgets/grid_product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'editProfile.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

final _firestore = FirebaseFirestore.instance;
User loggedInUser;
final FirebaseAuth authGlobal = FirebaseAuth.instance;
String _username;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
//
//  Profile({Key key, this.firstName, this.lastName, this.phoneNumber})
//      : super(key: key);
//  final String firstName;
//  final String lastName;
//  final String phoneNumber;
}

class _ProfileState extends State<Profile> {
  final _auth = FirebaseAuth.instance;
  String _firstName = "";
  String _lastName = "";
  String _email = "";
  String _phoneNumber = "";

  // TODO: ADD THIS TO EVERY VIEW THAT DISPLAYS UNIQUE DATA FOR THE USER
  void getCurrentUser() {
    final user = _auth.currentUser;
    if (user != null) {
      loggedInUser = user;
      print(loggedInUser.email);
    }
  }

//  Future<void> getData(userID) async {
//// return await     Firestore.instance.collection('users').document(userID).get();
//    DocumentSnapshot result = await Firestore.instance.collection('users')
//        .document(userID)
//        .get();
//    return result;
//  }

  Future<String> getUserInfo(String userInfo) async {
    //CollectionReference users = FirebaseFirestore.instance.collection('Users');
    FirebaseAuth auth = FirebaseAuth.instance;
    print(auth.currentUser.uid + ' USERID');

    //initializing the variable for the collection
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('Users');

    print(userCollection.doc(auth.currentUser.uid).get());
    return null;
  }

  // TODO: ADD THIS TO EVERY VIEW THAT DISPLAYS UNIQUE DATA FOR THE USER
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
//                Padding(
//                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
//                  child: Image.asset(
//                    "assets/t10.jpg",
//                    fit: BoxFit.cover,
//                    width: 100.0,
//                    height: 100.0,
//                  ),
//                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 5, top: 0, right: 0, bottom: 0),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('Users')
                                .doc(authGlobal.currentUser.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.lightBlueAccent,
                                  ),
                                );
                              }
                              var userDocument = snapshot.data;
                              _firstName = userDocument['First Name'];
                              _lastName = userDocument['Last Name'];
                              _email = userDocument['Email'];
                              _phoneNumber = userDocument['Phone Number'];

                              return Column(
                                children: <Widget>[
                                  Text(
                                    //can use uid???
                                    userDocument['First Name'] +
                                        " " +
                                        userDocument['Last Name'],
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 5.0),
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Users')
                            .doc(authGlobal.currentUser.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.lightBlueAccent,
                              ),
                            );
                          }
                          var userDocument = snapshot.data;
                          _firstName = userDocument['First Name'];
                          _lastName = userDocument['Last Name'];
                          _email = userDocument['Email'];
                          _phoneNumber = userDocument['Phone Number'];

                          return Column(
                            children: <Widget>[
                              Text(
                                //can use uid???
                                userDocument['Email'],
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: 20.0),
                    ],
                  ),
                  flex: 3,
                ),
              ],
            ),
            Divider(
              thickness: 2,
              color: Colors.grey[999],
            ),
            Container(height: 15.0),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                "Account Information".toUpperCase(),
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: Text(
                "First Name",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Users')
                    .doc(authGlobal.currentUser.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    );
                  }
                  var userDocument = snapshot.data;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        userDocument['First Name'],
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            ListTile(
              title: Text(
                "Last Name",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Users')
                    .doc(authGlobal.currentUser.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    );
                  }
                  var userDocument = snapshot.data;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        userDocument['Last Name'],
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            ListTile(
              title: Text(
                "Email",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Users')
                    .doc(authGlobal.currentUser.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    );
                  }
                  var userDocument = snapshot.data;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        userDocument['Email'],
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            ListTile(
              title: Text(
                "Phone Number",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Users')
                    .doc(authGlobal.currentUser.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    );
                  }
                  var userDocument = snapshot.data;
                  _firstName = userDocument['First Name'];
                  _lastName = userDocument['Last Name'];
                  _email = userDocument['Email'];
                  _phoneNumber = userDocument['Phone Number'];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        //can use uid???
                        userDocument['Phone Number'],
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Divider(
              thickness: 2,
              color: Colors.grey[999],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "My Posted Items",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            GridView.builder(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.25),
              ),
              itemCount: items == null ? 0 : items.length,
              itemBuilder: (BuildContext context, int index) {
//                Item item = Item.fromJson(items[index]);
                Map item = items[index];
//                print(items);
//                print(items.length);
                return GridProduct(
                  img: item['img'],
                  name: item['name'],
                );
              },
            ),
//            MediaQuery.of(context).platformBrightness == Brightness.dark
//                ? SizedBox()
//                : ListTile(
//                    title: Text(
//                      "Dark Theme",
//                      style: TextStyle(
//                        fontSize: 17,
//                        fontWeight: FontWeight.w700,
//                      ),
//                    ),
//                    trailing: Switch(
//                      value: Provider.of<AppProvider>(context).theme ==
//                              Constants.lightTheme
//                          ? false
//                          : true,
//                      onChanged: (v) async {
//                        if (v) {
//                          Provider.of<AppProvider>(context, listen: false)
//                              .setTheme(Constants.darkTheme, "dark");
//                        } else {
//                          Provider.of<AppProvider>(context, listen: false)
//                              .setTheme(Constants.lightTheme, "light");
//                        }
//                      },
//                      activeColor: Theme.of(context).accentColor,
//                    ),
//                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Edit Profile",
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return EditProfile(
                    firstName: _firstName,
                    lastName: _lastName,
                    phoneNumber: _phoneNumber);
              },
            ),
          );
        },
        child: Icon(
          Icons.create,
        ),
        heroTag: Object(),
      ),
    );
  }
}
