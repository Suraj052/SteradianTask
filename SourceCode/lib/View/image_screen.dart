import 'package:aitask/Provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: HexColor("#98DAD9"),
            statusBarIconBrightness: Brightness.dark),
        backgroundColor: HexColor("#98DAD9"),
        centerTitle: true,
        leading: IconButton(icon:Icon(Icons.arrow_back_ios_new,color: HexColor("#2E424D"),size: 25),onPressed: () => Navigator.pop(context)),
        title: Text("Your latest selfie",style:
        TextStyle(fontSize: 18,color: HexColor("#2E424D"),fontFamily: 'ProductSans',fontWeight: FontWeight.bold)),
      ),
      body: Consumer<ImagProvider>
        (
        builder: (context,value,child)
            {
              if(value.isLoading)
                {
                  return Center(child: CircularProgressIndicator(color: HexColor("#2E424D")));
                }
              String urlpath = value.url;
              return (urlpath=='no') ?
                Center(
                  child: Text(
                    'First take a selfie !',
                    style: TextStyle(fontSize: 17,color: HexColor("#2E424D"),fontWeight: FontWeight.w600),
                  ),
                ):
              Container(
                margin: EdgeInsets.all(8.0),
                height: size.height*0.50,
                width: size.width*0.95,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image:  NetworkImage(urlpath)
                  ),
                ),
              );
            }
      )
    );
  }
}
