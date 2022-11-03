import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class AdminControlPanel extends StatefulWidget {
  @override
  _AdminControlPanelState createState() => _AdminControlPanelState();
}

@immutable
// ignore: must_be_immutable
class _AdminControlPanelState extends State<AdminControlPanel> {
  String _imageurl = "";
  File _image;
  final picker = ImagePicker();

  Future _getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {}
    });
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            // toolbarColor: col,
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    uploadFile(croppedFile);
  }

  Future<String> uploadFile(File _image) async {
    String returnURL;
    var dt = DateTime.now();

    try {
      await FirebaseStorage.instance
          .ref()
          .child('${dt.toString()}')
          .putFile(_image)
          // ignore: missing_return
          .then((value) async {
        value.ref.getDownloadURL().then((url) => {
              setState(() {
                _imageurl = url;
              }),
            });
        // print('++++');
        // print(value.ref.getDownloadURL());
      });
    } catch (e) {}

    return returnURL;
  }

  Future _getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {}
    });
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    uploadFile(croppedFile);
  }

  Widget myWidget(
      String hint, bool isNumber, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          margin: EdgeInsets.symmetric(horizontal: 17),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controller,
                keyboardType:
                    isNumber ? TextInputType.number : TextInputType.text,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: '$hint'),
              ),
            ),
          )),
    );
  }

  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();
  TextEditingController controller6 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print('link is : ' + _imageurl);
    return Scaffold(
        //backgroundColor: Colors.orange,
        appBar: AppBar(
          title: Text("Control Panel"),
          centerTitle: true,
          backgroundColor: Colors.orange,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.17,
                  width: MediaQuery.of(context).size.height * 0.17,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image:
                            _imageurl.isEmpty ? null : NetworkImage(_imageurl),
                      )),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
                          child: FittedBox(
                              child: IconButton(
                            icon: Icon(Icons.add, color: Colors.white),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Image Source"),
                                      content:
                                          Text("Please Select Image Source"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              _getImageFromCamera();
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Camera")),
                                        TextButton(
                                            onPressed: () {
                                              _getImageFromGallery();
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Gallery")),
                                      ],
                                    );
                                  });
                            },
                          ))))),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              myWidget('Product Name', false, controller1),
              myWidget('Brand', false, controller2),
              myWidget('Prix', true, controller3),
              myWidget('Description', false, controller4),
              myWidget('Remise', true, controller5),
              myWidget('Table Name', false, controller6),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () async {
                    await FirebaseFirestore.instance
                        .collection('Products')
                        .doc('zIVlsgOJiZGiR9RT5oGa')
                        .collection(controller6.text)
                        .add({
                      'name': controller1.text,
                      'brand': controller2.text,
                      'prix': controller3.text,
                      'description': controller4.text,
                      'remose': controller5.text,
                      'image': _imageurl,
                    }).then((value) => {
                              setState(() {
                                controller1.clear();
                                controller2.clear();
                                controller3.clear();
                                controller4.clear();
                                controller5.clear();
                                controller6.clear();
                              })
                            });
                  },
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      margin: EdgeInsets.symmetric(horizontal: 17),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        border: Border.all(color: Colors.orange, width: 2),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Add Product",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ))),
                      )),
                ),
              ),

              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.02,
              // ),
            ],
          ),
        ));
  }
}
