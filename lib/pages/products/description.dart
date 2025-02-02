// import 'package:flutter/material.dart';
// import 'package:swishapp/pages/products/constants.dart';
// import 'package:swishapp/pages/products/firebase_services.dart';

// import 'custom_action_bar.dart';
// import 'image_swipe.dart';
// import 'product_size.dart';

// class ProductPage extends StatefulWidget {
//   final String productId;
//   ProductPage({this.productId});

//   @override
//   _ProductPageState createState() => _ProductPageState();
// }

// class _ProductPageState extends State<ProductPage> {
//   FirebaseServices _firebaseServices = FirebaseServices();
//   String _selectedProductSize = "0";

//   Future _addToCart() {
//     return _firebaseServices.usersRef
//         .doc(_firebaseServices.getUserId())
//         .collection("Cart")
//         .doc(widget.productId)
//         .set({"size": _selectedProductSize});
//   }

//   Future _addToSaved() {
//     return _firebaseServices.usersRef
//         .doc(_firebaseServices.getUserId())
//         .collection("Saved")
//         .doc(widget.productId)
//         .set({"size": _selectedProductSize});
//   }

//   final SnackBar _snackBar = SnackBar(content: Text("Product added to the cart"),);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           FutureBuilder(
//             future: _firebaseServices.productsRef.doc(widget.productId).get(),
//             builder: (context, snapshot) {
//               if (snapshot.hasError) {
//                 return Scaffold(
//                   body: Center(
//                     child: Text("Error: ${snapshot.error}"),
//                   ),
//                 );
//               }

//               if (snapshot.connectionState == ConnectionState.done) {
//                 // Firebase Document Data Map
//                 Map<String, dynamic> documentData = snapshot.data.data();

//                 // List of images
//                 List imageList = documentData['images'];
//                 List productSizes = documentData['size'];

//                 // Set an initial size
//                 _selectedProductSize = productSizes[0];

//                 return ListView(
//                   padding: EdgeInsets.all(0),
//                   children: [
//                     ImageSwipe(
//                       imageList: imageList,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(
//                         top: 24.0,
//                         left: 24.0,
//                         right: 24.0,
//                         bottom: 4.0,
//                       ),
//                       child: Text(
//                         "${documentData['name']}",
//                         style: Constants.boldHeading,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 4.0,
//                         horizontal: 24.0,
//                       ),
//                       child: Text(
//                         "\$${documentData['price']}",
//                         style: TextStyle(
//                           fontSize: 18.0,
//                           color: Theme.of(context).accentColor,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 8.0,
//                         horizontal: 24.0,
//                       ),
//                       child: Text(
//                         "${documentData['desc']}",
//                         style: TextStyle(
//                           fontSize: 16.0,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 24.0,
//                         horizontal: 24.0,
//                       ),
//                       child: Text(
//                         "Select Size",
//                         style: Constants.regularDarkText,
//                       ),
//                     ),
//                     ProductSize(
//                       productSizes: productSizes,
//                       onSelected: (size) {
//                         _selectedProductSize = size;
//                       },
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(24.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           GestureDetector(
//                             onTap: () async {
//                               await _addToSaved();
//                               Scaffold.of(context).showSnackBar(_snackBar);
//                             },
//                             child: Container(
//                               width: 65.0,
//                               height: 65.0,
//                               decoration: BoxDecoration(
//                                 color: Color(0xFFDCDCDC),
//                                 borderRadius: BorderRadius.circular(12.0),
//                               ),
//                               alignment: Alignment.center,
//                               child: Image(
//                                 image: AssetImage(
//                                   "assets/images/tab_saved.png",
//                                 ),
//                                 height: 22.0,
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: GestureDetector(
//                               onTap: () async {
//                                 await _addToCart();
//                                 Scaffold.of(context).showSnackBar(_snackBar);
//                               },
//                               child: Container(
//                                 height: 65.0,
//                                 margin: EdgeInsets.only(
//                                   left: 16.0,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: Colors.black,
//                                   borderRadius: BorderRadius.circular(12.0),
//                                 ),
//                                 alignment: Alignment.center,
//                                 child: Text(
//                                   "Add To Cart",
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 16.0,
//                                       fontWeight: FontWeight.w600),
//                                 ),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 );
//               }

//               // Loading State
//               return Scaffold(
//                 body: Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               );
//             },
//           ),
//           CustomActionBar(
//             hasBackArrrow: true,
//             hasTitle: false,
//             hasBackground: false,
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductDescription extends StatefulWidget {
  final String id, tableName;
  ProductDescription.seif(this.id, this.tableName);

  @override
  _ProductDescriptionState createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  int _amount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange,
        elevation: 0,
        title: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('Products')
                .doc('zIVlsgOJiZGiR9RT5oGa')
                .collection(widget.tableName)
                .doc(widget.id)
                .get(),
            builder: (context, snap) {
              return snap.hasData ? Text(snap.data['name']) : Text("...");
            }),
      ),
      body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('Products')
              .doc('zIVlsgOJiZGiR9RT5oGa')
              .collection(widget.tableName)
              .doc(widget.id)
              .get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Column(children: [
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          border: Border.all(color: Colors.orange, width: 2),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25))),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 25),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              snapshot.data['image']),
                                          fit: BoxFit.cover,
                                        )))),
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Text("${snapshot.data['prix']}\$",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Text("${snapshot.data['description']}",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                                padding: EdgeInsets.all(20),
                                child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    width: MediaQuery.of(context).size.width,
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  if (_amount >= 2) {
                                                    setState(() {
                                                      _amount--;
                                                    });
                                                  }
                                                },
                                                child: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.06,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.06,
                                                    decoration: BoxDecoration(
                                                      border:
                                                          Border.all(width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: FittedBox(
                                                        child: Text("-",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)))),
                                              ),
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.1),
                                              Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.06,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.06,
                                                  decoration: BoxDecoration(
                                                    border:
                                                        Border.all(width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: FittedBox(
                                                      child: Text("$_amount",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)))),
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.1),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    _amount++;
                                                  });
                                                },
                                                child: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.06,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.06,
                                                    decoration: BoxDecoration(
                                                      border:
                                                          Border.all(width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: FittedBox(
                                                        child: Text("+",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)))),
                                              )
                                            ])))),
                          ])),
                ),
                Padding(
                    padding: EdgeInsets.all(20),
                    child: InkWell(
                      onTap: () async {
                        await FirebaseFirestore.instance
                            .collection('cart')
                            .doc(auth.currentUser.uid)
                            .collection('productlist')
                            .add({
                          'name': snapshot.data['name'],
                          'image': snapshot.data['image'],
                          'amount': _amount,
                          'prix': snapshot.data['prix'] * _amount,
                        }).then((value) => {
                                  Navigator.of(context).pop(),
                                });
                      },
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          margin: EdgeInsets.symmetric(horizontal: 25),
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              border:
                                  Border.all(color: Colors.orange, width: 2),
                              borderRadius: BorderRadius.circular(25)),
                          child: Align(
                              alignment: Alignment.center,
                              child: Text("Add to cart",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)))),
                    ))
              ]);
            }
          }),
    );
  }
}
