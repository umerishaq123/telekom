
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telekom2/provider/image_to_text.dart';
import 'package:telekom2/provider/language_change_comtroller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Imagetotext extends StatefulWidget {
  const Imagetotext({super.key});

  @override
  State<Imagetotext> createState() => _ImagetotextState();
}

enum Language { english, malay, indonesia }

class _ImagetotextState extends State<Imagetotext> {
   late ImageToTextProvider _imageToTextProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _imageToTextProvider = Provider.of<ImageToTextProvider>(context, listen: false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.imageToText,
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          Consumer<AppLanguage>(
            builder: (BuildContext context, appLanguage, Widget? child) {
              return PopupMenuButton<Language>(
                onSelected: (Language item) async {
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
                  Provider.of<ImageToTextProvider>(context, listen: false)
                      .setLanguage(locale.languageCode);
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<Language>>[
                  PopupMenuItem(
                    child: Text('English'),
                    value: Language.english,
                  ),
                  PopupMenuItem(
                    child: Text('Malay'),
                    value: Language.malay,
                  ),
                  PopupMenuItem(
                    child: Text('Indonesia'),
                    value: Language.indonesia,
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: Consumer<ImageToTextProvider>(
        builder: (BuildContext context, imagetotextprovider, Widget? child) {
         return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!imagetotextprovider.isLoading && imagetotextprovider.extractedText != null) // Show extracted text if available and not loading
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(
                      color: Colors.grey,
                      width: 2,
                    ),
                  ),
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  child: Text(
                    imagetotextprovider.extractedText!,
                  ),
                ),
              if (!imagetotextprovider.isLoading && imagetotextprovider.extractedText == null) // Show message if no text available and not loading
                Container(
                  margin: EdgeInsets.all(20),
                  child: Text(
                    AppLocalizations.of(context)!.noTextAvailable,
                  ),
                ),
            ],
          ),
        ),
        if (imagetotextprovider.isLoading)
          Container(
            color: Colors.white, // Optional: Adds a semi-transparent background
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
        },
      ),
    );
  }

   @override
  void dispose() {
    // Defer the call to clearText to avoid issues with the widget tree being locked.
    Future.microtask(() {
      _imageToTextProvider.clearText();
    });
    super.dispose();
  }
}



