
import 'package:planz/Config/config.dart';
import 'package:planz/DialogBox/errorDialog.dart';

import 'package:planz/Widgets/customTextField.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planz/pages/page1.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final TextEditingController _cPasswordTextEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String userImageUrl = "";
  // File _imageFile;
  final ImagePicker pickerImg = ImagePicker();

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width,
        // ignore: unused_local_variable
        _screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 10.0,
            ),
            // InkWell(
            //   onTap: _selectAndPickImage,
            //   child: CircleAvatar(
            //     radius: _screenWidth * 0.15,
            //     backgroundColor: Colors.white,
            //     backgroundImage:
            //         _imageFile == null ? null : FileImage(_imageFile),
            //     child: _imageFile == null
            //         ? Icon(
            //             Icons.add_photo_alternate,
            //             size: _screenWidth * 0.15,
            //             color: Colors.grey,
            //           )
            //         : null,
            //   ),
            // ),
            SizedBox(
              height: 8.0,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _nameTextEditingController,
                    data: Icons.person,
                    hintText: "Name",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _emailTextEditingController,
                    data: Icons.email,
                    hintText: "Email",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _passwordTextEditingController,
                    data: Icons.person,
                    hintText: "Password",
                    isObsecure: true,
                  ),
                  CustomTextField(
                    controller: _cPasswordTextEditingController,
                    data: Icons.person,
                    hintText: "Confirm Password",
                    isObsecure: true,
                  ),
                ],
              ),
            ),
            RaisedButton(
              onPressed: () {
                uploadAndSaveImage();
              },
              color: Colors.orange,
              child: Text(
                "Sign up",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              height: 4.0,
              width: _screenWidth * 0.8,
              color: Colors.orangeAccent,
            ),
            SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
    );
  } // Future<void> _selectAndPickImage() async {
  //   final _imageFileP = await pickerImg.getImage(source: ImageSource.gallery);
  //   setState(() {
  //     _imageFile = File(_imageFileP.path);
  //   });
  // }

  Future<void> uploadAndSaveImage() async {
    _passwordTextEditingController.text == _cPasswordTextEditingController.text
        ? _emailTextEditingController.text.isNotEmpty &&
                _passwordTextEditingController.text.isNotEmpty &&
                _cPasswordTextEditingController.text.isNotEmpty &&
                _nameTextEditingController.text.isNotEmpty
            ? _registerUser()
            : displayDilog("Please fill up the registration complete form..")
        : displayDilog("Passsword do not macth.");
  }

  displayDilog(String msg) {
    showDialog(
        context: context,
        builder: (c) {
          return ErrorAlertDialog(
            message: msg,
          );
        });
  }

  // uploadToStorage() async {
  //   showDialog(
  //       context: context,
  //       builder: (c) {
  //         return LoadingAlertDialog();
  //       });
  //   String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();

  //   Reference storageReference =
  //       FirebaseStorage.instance.ref().child(imageFileName);

  //   UploadTask storageUploadTask = storageReference.putFile(_imageFile);

  //   TaskSnapshot taskSnapshot = await storageUploadTask;
  //   await taskSnapshot.ref.getDownloadURL().then((urlImage) {
  //     userImageUrl = urlImage;

  //     _registerUser();
  //   });
  // }

  FirebaseAuth _auth = FirebaseAuth.instance;
  void _registerUser() async {
    User firebaseUser;

    await _auth
        .createUserWithEmailAndPassword(
      email: _emailTextEditingController.text.trim(),
      password: _passwordTextEditingController.text.trim(),
    )
        .then((auth) {
      firebaseUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              message: error.message.toString(),
            );
          });
    });
    if (firebaseUser != null) {
      saveUserInfoToFireStore(firebaseUser).then((value) {
        saveUserInfoToFireStorer();
        
      });
    }
  }

  Future saveUserInfoToFireStore(User fUser) async {
    FirebaseFirestore.instance.collection("users").doc(fUser.uid).set({
      "uid": fUser.uid,
      "email": fUser.email,
      "name": _nameTextEditingController.text.trim(),
      // "url": userImageUrl,
      // EcommerceApp.userCartList: ["garbaValue"]
    }).then((value) {});

    await EcommerceApp.sharedPreferences.setString("uid", fUser.uid);
    await EcommerceApp.sharedPreferences
        .setString(EcommerceApp.userEmail, fUser.email);
    await EcommerceApp.sharedPreferences
        .setString(EcommerceApp.userName, _nameTextEditingController.text);
    // await EcommerceApp.sharedPreferences
    //     .setString(EcommerceApp.userAvatarUrl, userImageUrl);
    await EcommerceApp.sharedPreferences
        .setStringList(EcommerceApp.userCartList, ["garbaValue"]);
  }

  Future saveUserInfoToFireStorer() async {
    var dDay = DateTime.now();
    EcommerceApp.firestore
        .collection(EcommerceApp.collectionUser)
        .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .collection("date")
        .doc(dDay.toString())
        .set({
      "columna1": dDay,
      "columna2": int.parse(0.toString()),
      "columna3": int.parse(0.toString()),
      "columna4": int.parse(0.toString()),
      "columna5": int.parse(0.toString()),
      "columna6": int.parse(0.toString()),
      "columna7": int.parse(0.toString()),
      "columna8": int.parse(0.toString()),
      "columna9": int.parse(0.toString()),
      "columna10": int.parse(0.toString()),
      "columna11": int.parse(0.toString()),
      "columna12": int.parse(0.toString()),
      "columna13": int.parse(0.toString()),
    }).then((value) => saveUserInfoToFireStorer2());
  }
 var dDay = DateTime.now();
  Future saveUserInfoToFireStorer2() async {
    DateTime dDay2 = dDay.add(Duration(days: 7));
    EcommerceApp.firestore
        .collection(EcommerceApp.collectionUser)
        .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .collection("date")
        .doc(dDay2.toString())
        .set({
      "columna1": dDay2,
      "columna2": int.parse(0.toString()),
      "columna3": int.parse(0.toString()),
      "columna4": int.parse(0.toString()),
      "columna5": int.parse(0.toString()),
      "columna6": int.parse(0.toString()),
      "columna7": int.parse(0.toString()),
      "columna8": int.parse(0.toString()),
      "columna9": int.parse(0.toString()),
      "columna10": int.parse(0.toString()),
      "columna11": int.parse(0.toString()),
      "columna12": int.parse(0.toString()),
      "columna13": int.parse(0.toString()),
    }).then((value) => saveUserInfoToFireStoreTitles());
  }

  Future saveUserInfoToFireStoreTitles() async {
    var dDay = DateTime.now();
    EcommerceApp.firestore
        .collection(EcommerceApp.collectionUser)
        .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .collection("categorias")
        .doc(dDay.toString())
        .set({
      "titulo1": "Titulo1",
      "titulo2": "Titulo2",
      "titulo3": "Titulo3",
      "titulo4": "Titulo4",
      "titulo5": "Titulo5",
      "titulo6": "Titulo6",
      "titulo7": "Titulo7",
      "titulo8": "Titulo8",
      "titulo9": "Titulo9",
      "titulo10": "Titulo10",
      "titulo11": "Titulo11",
      "titulo12": "Titulo12",
      "titulo13": "Titulo13",
    }).then((value) {
      Navigator.pop(context);
      Route route = MaterialPageRoute(builder: (c) => TableTest());
      Navigator.push(context, route);
    });
  }
}
