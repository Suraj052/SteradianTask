
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class ImagProvider extends ChangeNotifier
{
  String url = 'no' ;
  bool enable = true;

  bool isLoading = false;

  Future<void> pfun() async
  {

    isLoading = true;
    notifyListeners();

    ImagePicker imagePicker = ImagePicker();
    XFile? file =  await imagePicker.pickImage(source: ImageSource.camera);

    if(file==null) return;
    String unique = DateTime.now().microsecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');

    Reference referenceImageToUpload = referenceDirImages.child(unique);

    try
    {
      await referenceImageToUpload.putFile(File(file!.path));
      url = await referenceImageToUpload.getDownloadURL();
      print(url);

    }catch(e)
    {
      showToast(e.toString());
    }

    isLoading = false;
    notifyListeners();

  }
}

void showToast(String text) => Fluttertoast.showToast
  (
  msg: text,
  fontSize: 13.0,
  backgroundColor: HexColor("#fed701"),
  textColor: Colors.black,
  gravity: ToastGravity.BOTTOM,
);