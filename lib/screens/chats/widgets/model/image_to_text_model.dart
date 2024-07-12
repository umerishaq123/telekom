// To parse this JSON data, do
//
//     final imagetotext = imagetotextFromJson(jsonString);

import 'dart:convert';

Imagetotext imagetotextFromJson(String str) => Imagetotext.fromJson(json.decode(str));

String imagetotextToJson(Imagetotext data) => json.encode(data.toJson());

class Imagetotext {
    String? extractedText;
    String? imageUrl;
    String? textUrl;

    Imagetotext({
        this.extractedText,
        this.imageUrl,
        this.textUrl,
    });

    factory Imagetotext.fromJson(Map<String, dynamic> json) => Imagetotext(
        extractedText: json["extracted_text"],
        imageUrl: json["image_url"],
        textUrl: json["text_url"],
    );

    Map<String, dynamic> toJson() => {
        "extracted_text": extractedText,
        "image_url": imageUrl,
        "text_url": textUrl,
    };
}
