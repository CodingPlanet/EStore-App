// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  bool error;
  String message;
  List<Datum> data;

  CategoryModel({
    required this.error,
    required this.message,
    required this.data,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    error: json["error"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int termId;
  String name;
  String slug;
  int termGroup;
  int termTaxonomyId;
  String taxonomy;
  String description;
  int parent;
  int count;
  String filter;
  int catId;
  int categoryCount;
  String categoryDescription;
  String catName;
  String categoryNicename;
  int categoryParent;
  dynamic image;

  Datum({
    required this.termId,
    required this.name,
    required this.slug,
    required this.termGroup,
    required this.termTaxonomyId,
    required this.taxonomy,
    required this.description,
    required this.parent,
    required this.count,
    required this.filter,
    required this.catId,
    required this.categoryCount,
    required this.categoryDescription,
    required this.catName,
    required this.categoryNicename,
    required this.categoryParent,
    required this.image,
  });

  checkDataType(dynamic variable) {
    if (variable is String) {
      print('String');
    } else if (variable is int) {
      print('int');
    } else if (variable is bool) {
      print('bool');
    } else {
      print('Unknown type');
    }
  }

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    termId: json["term_id"],
    name: json["name"],
    slug: json["slug"],
    termGroup: json["term_group"],
    termTaxonomyId: json["term_taxonomy_id"],
    taxonomy: json["taxonomy"],
    description: json["description"],
    parent: json["parent"],
    count: json["count"],
    filter: json["filter"],
    catId: json["cat_ID"],
    categoryCount: json["category_count"],
    categoryDescription: json["category_description"],
    catName: json["cat_name"],
    categoryNicename: json["category_nicename"],
    categoryParent: json["category_parent"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "term_id": termId,
    "name": name,
    "slug": slug,
    "term_group": termGroup,
    "term_taxonomy_id": termTaxonomyId,
    "taxonomy": taxonomy,
    "description": description,
    "parent": parent,
    "count": count,
    "filter": filter,
    "cat_ID": catId,
    "category_count": categoryCount,
    "category_description": categoryDescription,
    "cat_name": catName,
    "category_nicename": categoryNicename,
    "category_parent": categoryParent,
    "image": image,
  };
}
