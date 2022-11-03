import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swishapp/componets/home_page.dart';
import 'package:swishapp/pages/products/description.dart';
import 'package:swishapp/pages/products/products.dart';

class Gird4 extends StatefulWidget {
  @override
  _Gird4State createState() => _Gird4State();
}

class _Gird4State extends State<Gird4> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('Products')
            .doc('zIVlsgOJiZGiR9RT5oGa')
            .collection('Home')
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Container(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                height: 320.0,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 100,
                      childAspectRatio: 1.6 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => ProductDescription.seif(
                                snapshot.data.docs[index].id, 'Home')));
                      },
                      child: Gridelement(snapshot.data.docs[index]['image'],
                          snapshot.data.docs[index]['name']),
                    );
                  },
                ));
          }
        });
  }
}

class Gridelement extends StatelessWidget {
  final String image;
  final String title;

  Gridelement(this.image, this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                width: double.infinity,
                child: Image.network(
                  image,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(title),
            ),
          ],
        ),
      ),
    );
  }
}

class WomenGrid extends StatefulWidget {
  @override
  _WomenGridState createState() => _WomenGridState();
}

class _WomenGridState extends State<WomenGrid> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('Products')
            .doc('zIVlsgOJiZGiR9RT5oGa')
            .collection('Women')
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Container(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                height: 320.0,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 100,
                      childAspectRatio: 1.6 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => ProductDescription.seif(
                                snapshot.data.docs[index].id, 'Women')));
                      },
                      child: Gridelement(snapshot.data.docs[index]['image'],
                          snapshot.data.docs[index]['name']),
                    );
                  },
                ));
          }
        });
  }
}

class MenGrid extends StatefulWidget {
  @override
  _MenGridState createState() => _MenGridState();
}

class _MenGridState extends State<MenGrid> {
  // _onPressed() async {
  //   await firestoreInstance.collection("Products").get().then((querySnapshot) {
  //     querySnapshot.docs.forEach((result) {
  //       firestoreInstance
  //           .collection("Products")
  //           .doc(result.id)
  //           .collection("Men")
  //           .get()
  //           .then((querySnapshot) {
  //         querySnapshot.docs.forEach((result) {
  //           setState(() {
  //             firebasemendata.add(result.data());
  //           });
  //         });
  //       });
  //     });
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // _onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('Products')
            .doc('zIVlsgOJiZGiR9RT5oGa')
            .collection('Men')
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Container(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                height: 320.0,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 100,
                      childAspectRatio: 1.6 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => ProductDescription.seif(
                                snapshot.data.docs[index].id, 'Men')));
                      },
                      child: Gridelement(snapshot.data.docs[index]['image'],
                          snapshot.data.docs[index]['name']),
                    );
                  },
                ));
          }
        });
  }
}

class KidsGrid extends StatefulWidget {
  @override
  _KidsGridState createState() => _KidsGridState();
}

class _KidsGridState extends State<KidsGrid> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('Products')
            .doc('zIVlsgOJiZGiR9RT5oGa')
            .collection('kids')
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Container(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                height: 320.0,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 100,
                      childAspectRatio: 1.6 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => ProductDescription.seif(
                                snapshot.data.docs[index].id, 'kids')));
                      },
                      child: Gridelement(snapshot.data.docs[index]['image'],
                          snapshot.data.docs[index]['name']),
                    );
                  },
                ));
          }
        });
  }
}
