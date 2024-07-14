import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telekom2/provider/image_to_text.dart';

class Imagetotext extends StatefulWidget {
  const Imagetotext({super.key});

  @override
  State<Imagetotext> createState() => _ImagetotextState();
}

class _ImagetotextState extends State<Imagetotext> {
  @override
  Widget build(BuildContext context) {
    final imagetotextprovider=Provider.of<ImageToTextProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Image to Text',style: TextStyle(fontSize: 18),),
        centerTitle: true,
      ),
      body: Consumer<ImageToTextProvider>(
        builder: (BuildContext context, value, Widget? child) { 
     return SingleChildScrollView(
       child: Column(
         children: [
          
           Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(
                color: Colors.grey,
                width: 2,

              )
            ),
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
                child:Center(child: Text(value.imageToText?.extractedText?? '')) ,
              ),
         ],
       ),
     );
    
         },
     ),
    );
  }
}