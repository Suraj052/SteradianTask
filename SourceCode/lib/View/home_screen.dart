
import 'package:aitask/Model/controlmodel.dart';
import 'package:aitask/View/image_screen.dart';
import 'package:aitask/Provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    final provider = Provider.of<ImagProvider>(context);

    return Scaffold(
      backgroundColor: HexColor("#EAEBED"),
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: HexColor("#98DAD9"),
            statusBarIconBrightness: Brightness.dark),
        backgroundColor: HexColor("#98DAD9"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder:(context)=>ImageScreen())),
              icon: Icon(Icons.folder_copy_rounded,color: HexColor("#2E424D"),size: 25))
        ],
        title: Text("FlutterSelfie",style:
        TextStyle(fontSize: 18,color: HexColor("#2E424D"),fontFamily: 'ProductSans',fontWeight: FontWeight.bold)),
      ),
      
      
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(8.0),
            height: size.height*0.50,
            width: size.width*0.95,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image:  AssetImage('assets/flutterbird.png')
                ,
              ),
            ),
          ),
          SizedBox(height: 50),
          StreamBuilder<List<Control>>(
              stream: readSwitch(),
              builder: (context,snapshot)
              {
                if(snapshot.hasData)
                  {
                    final switchControl = snapshot.data;
                    bool click = switchControl![0].selfie;

                    if(click==true)
                      {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:HexColor("#98DAD9"),
                            minimumSize: const Size(350, 60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onPressed: () => provider.pfun(),
                          child: Text("Click Your Selfie",style: TextStyle(color: HexColor("#2E424D"))),
                        );
                      }
                    else
                      {
                        return Text(" Sorry, can't take selfie ",style: TextStyle(fontSize: 15,color: Colors.red,fontFamily: 'ProductSans',fontWeight: FontWeight.bold));
                      }
                  }
                else if(snapshot.hasError)
                  {
                    print(snapshot.error);
                    return Center(child: CircularProgressIndicator(color: HexColor("#2E424D")));
                  }
                return Center(child: CircularProgressIndicator(color: HexColor("#2E424D")));
              }

          ),

        ],
      ),
    );
  }

  Stream<List<Control>> readSwitch() => FirebaseFirestore.instance
      .collection('control')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => Control.fromJson(doc.data())).toList());
}

