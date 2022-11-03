import 'package:flutter/material.dart';
import 'package:swishapp/componets/home_page.dart';
import 'package:swishapp/pages/Checkout1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    super.initState();
    _getSomme().then((value) => {setState(() => nb = value)});
  }

  bool clicked = false;
  bool clicked2 = false;

  bool click = false;
  bool click2 = false;
  bool click3 = false;
  bool click4 = false;
  var rating = 3.0;
  int number = 1;
  int numberx = 1;
  double somme = 0;
  double nb = 0;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<double> _getSomme() async {
    double s = 0;
    List<QueryDocumentSnapshot> list1 = [];
    await FirebaseFirestore.instance
        .collection('cart')
        .doc(auth.currentUser.uid)
        .collection('productlist')
        .get()
        .then(
          (value) => list1 = value.docs,
        );

    list1.forEach((element) {
      s += double.parse(element['prix'].toString());
    });
    print('sm : ' + s.toString());
    return s;
  }

  @override
  Widget build(BuildContext context) {
    // _getSomme();
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text("Total: "),
                  Text(
                    "$nb \$",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFFFF5D55))),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Checkout1()));
                  },
                  child: Text("Checkout")),
            )
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'My Cart',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('cart')
              .doc(auth.currentUser.uid)
              .collection('productlist')
              .get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      onDismissed: (drt) async {
                        await FirebaseFirestore.instance
                            .collection('cart')
                            .doc(auth.currentUser.uid)
                            .collection('productlist')
                            .doc(snapshot.data.docs[index].id)
                            .delete();
                        _getSomme()
                            .then((value) => {setState(() => nb = value)});
                      },
                      background: Container(
                          color: Color(0xFFFF0000),
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.delete, color: Colors.white),
                              ))),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4.5,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 130,
                                      width: 130,
                                      child: Image.network(
                                          "${snapshot.data.docs[index]['image']}"),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            "${snapshot.data.docs[index]['name']}"),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "${snapshot.data.docs[index]['prix']}\$",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        InkWell(
                                            onTap: () {
                                              print('somme : ' +
                                                  somme.toString());
                                            },
                                            child: Icon(Icons.close)),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    )
                                  ]),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}

Widget customverticaldivider() {
  return Column(
    children: [
      Container(
        width: 2,
        height: 30,
        color: Colors.orange,
      ),
    ],
  );
}
