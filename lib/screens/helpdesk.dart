import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User HelpDesk'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              const Text('Quickly get more detailed info on any banknote you see by uploading its'
                  ' picture.',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
              ),
              Text('First, upload the banknote image.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 2,
                ),
              ),
              const Text('You could use your devices camera by tapping on the camera icon. NOTE: '
                  'take a well-focus vertical picture directly from above the banknote so the banknote'
                  'appears as a rectangle. Tap Tick sign to submit the picture or cancle to retry again.'
                  'Instead you could also choose and upload a picture from your gallery by tapping on the image icone'
                  'and choosing the picture.',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
              ),
              Text('Second, Crop the image.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 2,
                ),
              ),
              const Text("For the banknote to be recognized correctly, it's important to crop "
                  "and rotate it properly so that there's no needless background. Cropping is "
                  "done by tapping and moving the highlighted edges. Rotation is available with "
                  "the arrows below the image.",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
              ),
              Text('Now, Search and see',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 2,
                ),
              ),
              const Text("Tap the checkmark to find the matching banknote. You may seee very "
                  "similar matches as some banknotes are similar. You may see results that don't"
                  " match due to the quality of the picture you submitted and limitations of the"
                  " search algorithm. On the result list, tap any banknote to see detailed "
                  "information about it. You nay also add this banknote to your favorites "
                  "by tapping on the icon or share it with others by tapping share icon",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
              ),
              Text('Favorites List',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 2,
                ),
              ),
              const Text("Once you've used the favorite icon to make a banknote  a favoprite, "
                  "it'll be your favorites list accessible with the favorite button in the app's"
                  " Main Screen. when seeing Favorites, you can tap any favorite to see it's "
                  "details. You can also remove several images from Favorites by Long clicking "
                  "on one of them and then tapping on the delete icon",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
