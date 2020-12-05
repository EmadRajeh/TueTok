import 'package:flash_chat/widgets/slider_item2.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/widgets/grid_product2.dart';
import 'package:flash_chat/screens/checkout2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TutorScreen extends StatefulWidget {
  @override
  _TutorScreenState createState() => _TutorScreenState();
}

class _TutorScreenState extends State<TutorScreen> {
  bool _isLoading = true;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  List<DocumentSnapshot> posts;

  int _current = 0;

  @override
  void initState() {
    _fetchPosts();
    super.initState();
  }

  _fetchPosts() async {
    try {
      setState(() {
        _isLoading = true;
      });
      QuerySnapshot snap =
          await _db.collection("tutorPosts").orderBy("date", descending: true).get();
      setState(() {
        posts = snap.docs;
        _isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Container(
          child: SpinKitDualRing(
            color: Theme.of(context).accentColor,
            size: 60.0,
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 20, 10.0, 30),
          child: RefreshIndicator(
            onRefresh: () {
              _fetchPosts();
              return null;
            },
            child:
                ListView(shrinkWrap: true, primary: false, children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Recent Items",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10.0),

              //Slider Here

              CarouselSlider(
                height: MediaQuery.of(context).size.height / 2.4,
                items: map<Widget>(
                  posts.toList(),
                  (index, i) {
                    return SliderItem2(
                      img: posts[index].data()['photoUrl'],
                      name: posts[index].data()['name'],
                      price: posts[index].data()['Price'],
                      title: posts[index].data()['title'],
                      description: posts[index].data()['description'],
                      phoneNo: posts[index].data()['phoneNo'],
                    );
                  },
                ).toList(),
                autoPlay: true,
//                enlargeCenterPage: true,
                viewportFraction: 1.0,
//              aspectRatio: 2.0,
                onPageChanged: (index) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
              SizedBox(height: 20.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Popular Items",
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
                itemCount: posts.length,
                itemBuilder: (ctx, i) {
                  return GridProduct2(
                    name: posts[i].data()['name'],
                    img: posts[i].data()['photoUrl'],
                    title: posts[i].data()['title'],
                    price: posts[i].data()['Price'],
                    description: posts[i].data()['description'],
                    phoneNo: posts[i].data()['phoneNo'],
                  );
                },
              ),
            ]),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: "Checkout",
          mini: true,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return Checkout2();
                },
              ),
            );
          },
          child: Icon(
            Icons.add,
          ),
          heroTag: Object(),
        ),
      );
    }
  }
}