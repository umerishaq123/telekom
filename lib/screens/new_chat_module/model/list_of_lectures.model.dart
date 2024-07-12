// To parse this JSON data, do
//
//     final listoflecture = listoflectureFromJson(jsonString);

import 'dart:convert';

List<Listoflecture> listoflectureFromJson(String str) => List<Listoflecture>.from(json.decode(str).map((x) => Listoflecture.fromJson(x)));

String listoflectureToJson(List<Listoflecture> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Listoflecture {
    int? id;
    int? pdfDocument;
    String? operationType;
    String? status;
    String? details;
    DateTime? createdAt;
    String? fileUrl;
    int? imageDocument;

    Listoflecture({
        this.id,
        this.pdfDocument,
        this.operationType,
        this.status,
        this.details,
        this.createdAt,
        this.fileUrl,
        this.imageDocument,
    });

    factory Listoflecture.fromJson(Map<String, dynamic> json) => Listoflecture(
        id: json["id"],
        pdfDocument: json["pdf_document"],
        operationType: json["operation_type"],
        status: json["status"],
        details: json["details"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        fileUrl: json["file_url"],
        imageDocument: json["image_document"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "pdf_document": pdfDocument,
        "operation_type": operationType,
        "status": status,
        "details": details,
        "created_at": createdAt?.toIso8601String(),
        "file_url": fileUrl,
        "image_document": imageDocument,
    };
}
