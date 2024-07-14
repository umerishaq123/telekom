// To parse this JSON data, do
//
//     final imagetotext = imagetotextFromJson(jsonString);

import 'dart:convert';

ImagetotextModel imagetotextFromJson(String str) => ImagetotextModel.fromJson(json.decode(str));

String imagetotextToJson(ImagetotextModel data) => json.encode(data.toJson());

class ImagetotextModel {
    String? extractedText;
    String? imageUrl;
    String? textUrl;

    ImagetotextModel({
        this.extractedText,
        this.imageUrl,
        this.textUrl,
    });

    factory ImagetotextModel.fromJson(Map<String, dynamic> json) => ImagetotextModel(
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
