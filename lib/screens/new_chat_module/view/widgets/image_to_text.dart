// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:telekom2/provider/image_to_text.dart';
// import 'package:telekom2/utils/app_constant.dart';

// class Imagetotext extends StatefulWidget {
//   const Imagetotext({super.key});

//   @override
//   State<Imagetotext> createState() => _ImagetotextState();
// }

// class _ImagetotextState extends State<Imagetotext> {
//   String selectedLanguage = 'English'; // Default language selection

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;

//     final imagetotextprovider =
//         Provider.of<ImageToTextProvider>(context, listen: false);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Image to Text',
//           style: TextStyle(fontSize: 18),
//         ),
//         centerTitle: true,
//       ),
//       body: Consumer<ImageToTextProvider>(
//         builder: (BuildContext context, value, Widget? child) {
//           return SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Container(
//                   margin: EdgeInsets.only(right: 10),
//                   height: height * 0.04,
//                   width: width * 0.3,
//                   decoration: ShapeDecoration(
//                       color: Colors.white,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5)),
//                       shadows: AppConstantsWidgetStyle.kShadows),
//                   child: Center(
//                     child: DropdownButton<String>(
//                       value: selectedLanguage,
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           selectedLanguage = newValue!;
//                           // Set selected language in your provider
//                           String languageCode;
//                           switch (newValue) {
//                             case 'Indonesia':
//                               languageCode = 'id';
//                               break;
//                             case 'Malay':
//                               languageCode = 'ms';
//                               break;
//                             default:
//                               languageCode = 'en';
//                               break;
//                           }
//                           imagetotextprovider.setLanguage(languageCode);
//                         });
//                       },
//                       items: <String>['English', 'Indonesia', 'Malay']
//                           .map<DropdownMenuItem<String>>((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.all(Radius.circular(20)),
//                       border: Border.all(
//                         color: Colors.grey,
//                         width: 2,
//                       )),
//                   margin: EdgeInsets.all(20),
//                   padding: EdgeInsets.all(20),
//                   // child: Center(
//                   //     child: Text(value.imageToText?.extractedText ?? '')),
//                   child:Text(imagetotextprovider.extractedText??''),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telekom2/provider/image_to_text.dart';
import 'package:telekom2/provider/language_change_comtroller.dart';
import 'package:telekom2/utils/app_constant.dart';

class Imagetotext extends StatefulWidget {
  const Imagetotext({super.key});

  @override
  State<Imagetotext> createState() => _ImagetotextState();
}

enum Language { english, malay, indonesia }

class _ImagetotextState extends State<Imagetotext> {
  String selectedLanguage = 'English'; // Default language selection

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Image to Text',
            style: TextStyle(fontSize: 18),
          ),
          centerTitle: true,
          actions: [
        //     Consumer<AppLanguage>(
        //       builder: (BuildContext context, value, Widget? child) { 
        //         return            PopupMenuButton(
        //           onSelected: (Language item) {
        //             if(Language.english.name==item.name){
        //               print("::: english1");
        //               value.changeLanguage(Locale('en'));
        //             }else if(Language.malay.name==item.name){
        //               print("::: indonesia 1");
        //               value.changeLanguage(Locale('id'));
        //             }else{
        //               print(":::: malay1");
        //               value.changeLanguage(Locale('ms'));
        //             }
        //           },
        //           itemBuilder: (BuildContext context) =>
        //               <PopupMenuEntry<Language>>[
        //                 PopupMenuItem(
        //                   child: Text('english'),
        //                   value: Language.english,
        //                 ),
        //                 PopupMenuItem(
        //                   child: Text('malay'),
        //                   value: Language.english,
        //                 ),
        //                 PopupMenuItem(
        //                   child: Text('indonesia'),
        //                   value: Language.english,
        //                 ),
        //               ]);
        
        //        },
        // )
        Consumer<AppLanguage>(
            builder: (BuildContext context, appLanguage, Widget? child) {
              return PopupMenuButton<Language>(
                onSelected: (Language item) {
                  Locale locale;
                  switch (item) {
                    case Language.english:
                      locale = Locale('en');
                      break;
                    case Language.malay:
                      locale = Locale('ms');
                      break;
                    case Language.indonesia:
                      locale = Locale('id');
                      break;
                  }
                  appLanguage.changeLanguage(locale);
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<Language>>[
                  const PopupMenuItem(
                    child: Text('English'),
                    value: Language.english,
                  ),
                  const PopupMenuItem(
                    child: Text('Malay'),
                    value: Language.malay,
                  ),
                  const PopupMenuItem(
                    child: Text('Indonesia'),
                    value: Language.indonesia,
                  ),
                ],
              );
            },
          ),
          ]),
      body: Consumer<ImageToTextProvider>(
        builder: (BuildContext context, imagetotextprovider, Widget? child) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
            Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                        color: Colors.grey,
                        width: 2,
                      )),
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  child: Text(
                      imagetotextprovider.extractedText ?? 'No text available'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    Provider.of<ImageToTextProvider>(context, listen: false).clearText();
    super.dispose();
  }
}



