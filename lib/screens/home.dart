import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';

import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

import 'feedback.dart';
import 'helpdesk.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  List? _result;


  @override
  void initState() {
    super.initState();
    loadModelData().then((value) {
      setState(() {});
    });
  }

  loadModelData() async {
    await Tflite.loadModel(
        model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
        routes: {
          // Mapping
          'login_page': (BuildContext context) => LoginPage(),
          'helpdesk': (BuildContext context) => Help(),
          'feedback': (BuildContext context) => Contact_Us(),

        },
        debugShowCheckedModeBanner: false,
        title: 'UG_DeepMoney',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home:_image != null ? testImage(size, _image) : Builder(builder: (context){
          return Scaffold(
              appBar: AppBar(
                title: Text('UG_DeepMoney'),
                backgroundColor: Colors.blue,
              ),
              drawer: Drawer(
                child: ListView(
                  children: [
                    DrawerHeader(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: <Color>[
                            Colors.deepOrange,
                            Colors.orangeAccent
                          ]
                          ),
                        ),
                        child: Center(
                          child:SizedBox(
                            height: 130,
                            child: Image.asset(
                              "assets/images/logo.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                        )
                    ),
                    RaisedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      label: Text('Back to Home Page'),
                      icon: Icon(Icons.home_outlined),
                      color: Colors.lightBlueAccent,
                      colorBrightness: Brightness.dark,
                      elevation: 10,
                      disabledColor: Colors.cyanAccent,
                    ),
                    ListTile(
                      title: Text('Take image'),
                      leading: Icon(Icons.camera_alt_rounded),
                      onTap: takeImage,
                    ),
                    ListTile(
                      title: Text('Upload image'),
                      leading: Icon(Icons.image),
                      onTap: pickGalleryImage,
                    ),
                    ListTile(
                      title: Text('Share'),
                      leading: Icon(Icons.share),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text('Help'),
                      leading: Icon(Icons.help_center_outlined),
                      onTap: () {
                        Navigator.pushNamed(context, 'helpdesk');
                      },
                    ),
                    ListTile(
                      title: Text('Favorite'),
                      leading: Icon(Icons.favorite_outlined),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text('Contact Us'),
                      leading: Icon(Icons.contact_mail),
                      onTap: () {
                        Navigator.pushNamed(context, 'feedback');
                      },
                    ),
                    ListTile(
                      title: Text('Signin'),
                      leading: Icon(Icons.login_outlined),
                      onTap: () {
                        Navigator.pushNamed(context, 'login_page');
                      },
                    ),
                    ListTile(
                      title: Text('Logout'),
                      leading: Icon(Icons.logout),
                      onTap: () {
                        FirebaseAuth.instance.signOut().then((value) {
                          Navigator.pushNamed(context, 'login_page');
                        });
                      },
                    ),
                  ],
                ),
              ),
              body: Stack(
                  children: <Widget>
                  [
                    Positioned.fill(  //
                      child: Image(
                          image: AssetImage('assets/images/bg.jpg'),
                          fit : BoxFit.fill,
                          color: Color.fromRGBO(255, 255, 255, 0.5),
                          colorBlendMode: BlendMode.modulate
                      ),
                    ),
                    Center(child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 0, top:50, right: 0, bottom:0),
                          height: 170,
                          child: Row(
                            children: [
                              Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width / 2 - 32, // minus 32 due to the margin
                                margin: EdgeInsets.all(16.0),
                                padding: EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey, // background color of the cards
                                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                  boxShadow: [
                                    // this is the shadow of the card
                                    BoxShadow(
                                      color: Colors.black,
                                      spreadRadius: 0.5,
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 5.0,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                    galleryOrCamera(Icons.camera_alt_rounded, ImageSource.camera),
                                  ])
                                ),
                              ),
                              Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width / 2 - 32, // minus 32 due to the margin
                                margin: EdgeInsets.all(16.0),
                                padding: EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey, // background color of the cards
                                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                  boxShadow: [
                                    // this is the shadow of the card
                                    BoxShadow(
                                      color: Colors.black,
                                      spreadRadius: 0.5,
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 5.0,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                    galleryOrCamera(Icons.image_outlined, ImageSource.gallery),
                                  ])
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 170,
                          child: Row(
                            children: [
                              Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width / 2 - 32, // minus 32 due to the margin
                                margin: EdgeInsets.all(16.0),
                                padding: EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey, // background color of the cards
                                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                  boxShadow: [
                                    // this is the shadow of the card
                                    BoxShadow(
                                      color: Colors.black,
                                      spreadRadius: 0.5,
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 5.0,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: InkWell(
                                    child: Icon(
                                      Icons.share_outlined,
                                      color: Colors.white,
                                      size: 100,
                                    ),
                                    onTap: () => print('pressed'),
                                  ),
                                ),
                              ),
                              Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width / 2 - 32, // minus 32 due to the margin
                                margin: EdgeInsets.all(16.0),
                                padding: EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey, // background color of the cards
                                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                  boxShadow: [
                                    // this is the shadow of the card
                                    BoxShadow(
                                      color: Colors.black,
                                      spreadRadius: 0.5,
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 5.0,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: InkWell(
                                    child: Icon(
                                      Icons.help_outline_outlined,
                                      color: Colors.white,
                                      size: 100,
                                    ),
                                    onTap: () {
                                      Navigator.pushNamed(context, 'helpdesk');
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 50),
                        Text(
                          '1. Select or Capture the image.\n 2. Crop the image, click on tick \nicon to submit',textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),),
                  ]
              ),
              floatingActionButton: FloatingActionButton.extended(
                label: Text('Take image'),
                onPressed: takeImage,
                icon: Icon(Icons.camera_alt_outlined),
              )
          );
        }
        )
    );
  }

  void detectDogOrCat() async {
    if (_image != null) {
      try {
        _result = await Tflite.runModelOnImage(
          path: _image!.path,
          numResults: 2,
          threshold: 0.6,
          imageMean: 127.5,
          imageStd: 127.5,
        );
      } catch (e) {
        print("There is no image");
      }

      setState(() {});
    }
  }
  // From camera
  takeImage() async {
    //accessing image from Gallery or Camera.
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
//image is null, then return
    if (image == null) return null;
    File? img = File(image.path);
    img = await _cropImage(imageFile: img);
    setState(() {
      _image = img;
    });
  }
  // From Gallery
  pickGalleryImage() async {
    //accessing image from Gallery or Camera.
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//image is null, then return
    if (image == null) return null;
    File? img = File(image.path);
    img = await _cropImage(imageFile: img);
    setState(() {
      _image = img;
    });
  }

  _getImage(ImageSource imageSource) async {
//accessing image from Gallery or Camera.
    final XFile? image = await _picker.pickImage(source: imageSource);
//image is null, then return
    if (image == null) return null;
    File? img = File(image.path);
    img = await _cropImage(imageFile: img);
    setState(() {
      _image = img;
    });
  }
  // Alert message for cropping
  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Proper cropping improves result!"),
      content: Text("Our image recognition algorithms need your help. To get the best results please ensure: \n"
          "- The image shows ONLY the banknote, no excess background.\n - The banknote appears in the same angle"
          "that would appear in the catalog",
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // Cropping image after picking it
  Future<File?> _cropImage({required File imageFile}) async {
    Fluttertoast.showToast( msg:"You need to crop image first for better result",
      gravity: ToastGravity.CENTER,toastLength: Toast.LENGTH_LONG,backgroundColor: Colors.white, textColor: Colors.greenAccent,

    );
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  Widget testImage(size, image) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UG_DeepMoney'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home_outlined,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage(),),);
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: size.height * 0.40,
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(
                        image!,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                ),
            ),
            Container(
              height: size.height * 0.40,
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(36.0),
                    topRight: Radius.circular(36.0),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                            onPressed: takeImage,
                            child: Icon(
                              Icons.camera,
                              size: 35,
                              color: Colors.blueGrey,
                            ),
                            style: OutlinedButton.styleFrom(
                              elevation: 8,
                              shape: CircleBorder(),
                            ),
                        ),
                        SizedBox(width: 20,),
                        OutlinedButton(
                            onPressed: pickGalleryImage,

                            child: Icon(
                              Icons.image,
                              size: 30,
                              color: Colors.blueGrey,
                            ),
                          style: OutlinedButton.styleFrom(
                            elevation: 8,
                            shape: CircleBorder(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30,),
                    Text("Prediction",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),),
                    SizedBox(height: 10,),
                    _result != null
                        ? Text(
                      'This banknote is ${_result![0]['label']}.', style: TextStyle(fontWeight: FontWeight.bold),
                    )
                        : Text(
                      'Click the submit button.',style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 60),
                          elevation: 4,
                          primary: Colors.grey[500],
                        ),
                        //  onPressed: () {},
                        onPressed: detectDogOrCat,
                        child: Text(
                          'Submit',
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    Text(
                      'All right reserved @2022',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  MaterialButton galleryOrCamera(IconData icon, ImageSource imageSource) {
    return MaterialButton(
      padding: EdgeInsets.all(14.0),
      elevation: 0,
      color: Colors.transparent,
      onPressed: () {
        _getImage(imageSource);
      },
      child: Icon(
        icon,
        size: 80,
        color: Colors.white,
      ),
      shape: CircleBorder(),
    );
  }

}



