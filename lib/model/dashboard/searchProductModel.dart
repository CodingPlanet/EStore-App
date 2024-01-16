// To parse this JSON data, do
//
//     final searchProductModel = searchProductModelFromJson(jsonString);

import 'dart:convert';

List<SearchProductModel> searchProductModelFromJson(String str) => List<SearchProductModel>.from(json.decode(str).map((x) => SearchProductModel.fromJson(x)));

String searchProductModelToJson(List<SearchProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchProductModel {
  int id;
  String name;
  String slug;
  String permalink;
  DateTime dateCreated;
  DateTime dateModified;
  String type;
  String status;
  bool featured;
  String catalogVisibility;
  String description;
  String shortDescription;
  String sku;
  String price;
  String regularPrice;
  String salePrice;
  String dateOnSaleFrom;
  String dateOnSaleTo;
  String priceHtml;
  bool onSale;
  bool purchasable;
  int totalSales;
  bool virtual;
  bool downloadable;
  List<dynamic> downloads;
  int downloadLimit;
  int downloadExpiry;
  String downloadType;
  String externalUrl;
  String buttonText;
  String taxStatus;
  String taxClass;
  bool manageStock;
  dynamic stockQuantity;
  bool inStock;
  String backorders;
  bool backordersAllowed;
  bool backordered;
  bool soldIndividually;
  String weight;
  bool shippingRequired;
  bool shippingTaxable;
  String shippingClass;
  int shippingClassId;
  bool reviewsAllowed;
  String averageRating;
  int ratingCount;
  List<int> relatedIds;
  List<dynamic> upsellIds;
  List<dynamic> crossSellIds;
  int parentId;
  String purchaseNote;
  List<Category> categories;
  List<dynamic> tags;
  List<Image1> images;
  List<SearchProductModelAttribute> attributes;
  List<dynamic> defaultAttributes;
  List<Variation> variations;
  List<dynamic> groupedProducts;
  String vendorId;
  int menuOrder;
  List<MetaDatum> metaData;

  SearchProductModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.permalink,
    required this.dateCreated,
    required this.dateModified,
    required this.type,
    required this.status,
    required this.featured,
    required this.catalogVisibility,
    required this.description,
    required this.shortDescription,
    required this.sku,
    required this.price,
    required this.regularPrice,
    required this.salePrice,
    required this.dateOnSaleFrom,
    required this.dateOnSaleTo,
    required this.priceHtml,
    required this.onSale,
    required this.purchasable,
    required this.totalSales,
    required this.virtual,
    required this.downloadable,
    required this.downloads,
    required this.downloadLimit,
    required this.downloadExpiry,
    required this.downloadType,
    required this.externalUrl,
    required this.buttonText,
    required this.taxStatus,
    required this.taxClass,
    required this.manageStock,
    this.stockQuantity,
    required this.inStock,
    required this.backorders,
    required this.backordersAllowed,
    required this.backordered,
    required this.soldIndividually,
    required this.weight,
    required this.shippingRequired,
    required this.shippingTaxable,
    required this.shippingClass,
    required this.shippingClassId,
    required this.reviewsAllowed,
    required this.averageRating,
    required this.ratingCount,
    required this.relatedIds,
    required this.upsellIds,
    required this.crossSellIds,
    required this.parentId,
    required this.purchaseNote,
    required this.categories,
    required this.tags,
    required this.images,
    required this.attributes,
    required this.defaultAttributes,
    required this.variations,
    required this.groupedProducts,
    required this.vendorId,
    required this.menuOrder,
    required this.metaData,
  });

  factory SearchProductModel.fromJson(Map<String, dynamic> json) => SearchProductModel(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    permalink: json["permalink"],
    dateCreated: DateTime.parse(json["date_created"]),
    dateModified: DateTime.parse(json["date_modified"]),
    type: json["type"],
    status: json["status"],
    featured: json["featured"],
    catalogVisibility: json["catalog_visibility"],
    description: json["description"],
    shortDescription: json["short_description"],
    sku: json["sku"],
    price: json["price"],
    regularPrice: json["regular_price"],
    salePrice: json["sale_price"],
    dateOnSaleFrom: json["date_on_sale_from"],
    dateOnSaleTo: json["date_on_sale_to"],
    priceHtml: json["price_html"],
    onSale: json["on_sale"],
    purchasable: json["purchasable"],
    totalSales: json["total_sales"],
    virtual: json["virtual"],
    downloadable: json["downloadable"],
    downloads: List<dynamic>.from(json["downloads"].map((x) => x)),
    downloadLimit: json["download_limit"],
    downloadExpiry: json["download_expiry"],
    downloadType: json["download_type"],
    externalUrl: json["external_url"],
    buttonText: json["button_text"],
    taxStatus: json["tax_status"],
    taxClass: json["tax_class"],
    manageStock: json["manage_stock"],
    stockQuantity: json["stock_quantity"],
    inStock: json["in_stock"],
    backorders: json["backorders"],
    backordersAllowed: json["backorders_allowed"],
    backordered: json["backordered"],
    soldIndividually: json["sold_individually"],
    weight: json["weight"],
    shippingRequired: json["shipping_required"],
    shippingTaxable: json["shipping_taxable"],
    shippingClass: json["shipping_class"],
    shippingClassId: json["shipping_class_id"],
    reviewsAllowed: json["reviews_allowed"],
    averageRating: json["average_rating"],
    ratingCount: json["rating_count"],
    relatedIds: List<int>.from(json["related_ids"].map((x) => x)),
    upsellIds: List<dynamic>.from(json["upsell_ids"].map((x) => x)),
    crossSellIds: List<dynamic>.from(json["cross_sell_ids"].map((x) => x)),
    parentId: json["parent_id"],
    purchaseNote: json["purchase_note"],
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    tags: List<dynamic>.from(json["tags"].map((x) => x)),
    images: List<Image1>.from(json["images"].map((x) => Image1.fromJson(x))),
    attributes: List<SearchProductModelAttribute>.from(json["attributes"].map((x) => SearchProductModelAttribute.fromJson(x))),
    defaultAttributes: List<dynamic>.from(json["default_attributes"].map((x) => x)),
    variations: List<Variation>.from(json["variations"].map((x) => Variation.fromJson(x))),
    groupedProducts: List<dynamic>.from(json["grouped_products"].map((x) => x)),
    vendorId: json["vendor_id"],
    menuOrder: json["menu_order"],
    metaData: List<MetaDatum>.from(json["meta_data"].map((x) => MetaDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "permalink": permalink,
    "date_created": dateCreated.toIso8601String(),
    "date_modified": dateModified.toIso8601String(),
    "type": type,
    "status": status,
    "featured": featured,
    "catalog_visibility": catalogVisibility,
    "description": description,
    "short_description": shortDescription,
    "sku": sku,
    "price": price,
    "regular_price": regularPrice,
    "sale_price": salePrice,
    "date_on_sale_from": dateOnSaleFrom,
    "date_on_sale_to": dateOnSaleTo,
    "price_html": priceHtml,
    "on_sale": onSale,
    "purchasable": purchasable,
    "total_sales": totalSales,
    "virtual": virtual,
    "downloadable": downloadable,
    "downloads": List<dynamic>.from(downloads.map((x) => x)),
    "download_limit": downloadLimit,
    "download_expiry": downloadExpiry,
    "download_type": downloadType,
    "external_url": externalUrl,
    "button_text": buttonText,
    "tax_status": taxStatus,
    "tax_class": taxClass,
    "manage_stock": manageStock,
    "stock_quantity": stockQuantity,
    "in_stock": inStock,
    "backorders": backorders,
    "backorders_allowed": backordersAllowed,
    "backordered": backordered,
    "sold_individually": soldIndividually,
    "weight": weight,
    "shipping_required": shippingRequired,
    "shipping_taxable": shippingTaxable,
    "shipping_class": shippingClass,
    "shipping_class_id": shippingClassId,
    "reviews_allowed": reviewsAllowed,
    "average_rating": averageRating,
    "rating_count": ratingCount,
    "related_ids": List<dynamic>.from(relatedIds.map((x) => x)),
    "upsell_ids": List<dynamic>.from(upsellIds.map((x) => x)),
    "cross_sell_ids": List<dynamic>.from(crossSellIds.map((x) => x)),
    "parent_id": parentId,
    "purchase_note": purchaseNote,
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
    "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
    "default_attributes": List<dynamic>.from(defaultAttributes.map((x) => x)),
    "variations": List<dynamic>.from(variations.map((x) => x.toJson())),
    "grouped_products": List<dynamic>.from(groupedProducts.map((x) => x)),
    "vendor_id": vendorId,
    "menu_order": menuOrder,
    "meta_data": List<dynamic>.from(metaData.map((x) => x.toJson())),
  };
}

class SearchProductModelAttribute {
  int id;
  String name;
  int position;
  bool visible;
  bool variation;
  List<String> options;

  SearchProductModelAttribute({
    required this.id,
    required this.name,
    required this.position,
    required this.visible,
    required this.variation,
    required this.options,
  });

  factory SearchProductModelAttribute.fromJson(Map<String, dynamic> json) => SearchProductModelAttribute(
    id: json["id"],
    name: json["name"],
    position: json["position"],
    visible: json["visible"],
    variation: json["variation"],
    options: List<String>.from(json["options"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "position": position,
    "visible": visible,
    "variation": variation,
    "options": List<dynamic>.from(options.map((x) => x)),
  };
}

class Category {
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
  dynamic thumbnail;

  Category({
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
    this.thumbnail,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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
    thumbnail: json["thumbnail"],
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
    "thumbnail": thumbnail,
  };
}

class Image1 {
  int id;
  DateTime dateCreated;
  DateTime dateModified;
  String src;
  String name;
  String alt;
  int position;

  Image1({
    required this.id,
    required this.dateCreated,
    required this.dateModified,
    required this.src,
    required this.name,
    required this.alt,
    required this.position,
  });

  factory Image1.fromJson(Map<String, dynamic> json) => Image1(
    id: json["id"],
    dateCreated: DateTime.parse(json["date_created"]),
    dateModified: DateTime.parse(json["date_modified"]),
    src: json["src"],
    name: json["name"],
    alt: json["alt"],
    position: json["position"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date_created": dateCreated.toIso8601String(),
    "date_modified": dateModified.toIso8601String(),
    "src": src,
    "name": name,
    "alt": alt,
    "position": position,
  };
}

class MetaDatum {
  int id;
  String key;
  String value;

  MetaDatum({
    required this.id,
    required this.key,
    required this.value,
  });

  factory MetaDatum.fromJson(Map<String, dynamic> json) => MetaDatum(
    id: json["id"],
    key: json["key"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "key": key,
    "value": value,
  };
}

class Variation {
  int id;
  DateTime dateCreated;
  DateTime dateModified;
  String permalink;
  String sku;
  String price;
  String regularPrice;
  String salePrice;
  String dateOnSaleFrom;
  String dateOnSaleTo;
  bool onSale;
  bool purchasable;
  bool visible;
  bool virtual;
  bool downloadable;
  List<dynamic> downloads;
  int downloadLimit;
  int downloadExpiry;
  String taxStatus;
  String taxClass;
  bool manageStock;
  dynamic stockQuantity;
  bool inStock;
  String backorders;
  bool backordersAllowed;
  bool backordered;
  String weight;
  Dimensions dimensions;
  String shippingClass;
  int shippingClassId;
  List<Image1> image;
  List<VariationAttribute> attributes;

  Variation({
    required this.id,
    required this.dateCreated,
    required this.dateModified,
    required this.permalink,
    required this.sku,
    required this.price,
    required this.regularPrice,
    required this.salePrice,
    required this.dateOnSaleFrom,
    required this.dateOnSaleTo,
    required this.onSale,
    required this.purchasable,
    required this.visible,
    required this.virtual,
    required this.downloadable,
    required this.downloads,
    required this.downloadLimit,
    required this.downloadExpiry,
    required this.taxStatus,
    required this.taxClass,
    required this.manageStock,
    this.stockQuantity,
    required this.inStock,
    required this.backorders,
    required this.backordersAllowed,
    required this.backordered,
    required this.weight,
    required this.dimensions,
    required this.shippingClass,
    required this.shippingClassId,
    required this.image,
    required this.attributes,
  });

  factory Variation.fromJson(Map<String, dynamic> json) => Variation(
    id: json["id"],
    dateCreated: DateTime.parse(json["date_created"]),
    dateModified: DateTime.parse(json["date_modified"]),
    permalink: json["permalink"],
    sku: json["sku"],
    price: json["price"],
    regularPrice: json["regular_price"],
    salePrice: json["sale_price"],
    dateOnSaleFrom: json["date_on_sale_from"],
    dateOnSaleTo: json["date_on_sale_to"],
    onSale: json["on_sale"],
    purchasable: json["purchasable"],
    visible: json["visible"],
    virtual: json["virtual"],
    downloadable: json["downloadable"],
    downloads: List<dynamic>.from(json["downloads"].map((x) => x)),
    downloadLimit: json["download_limit"],
    downloadExpiry: json["download_expiry"],
    taxStatus: json["tax_status"],
    taxClass: json["tax_class"],
    manageStock: json["manage_stock"],
    stockQuantity: json["stock_quantity"],
    inStock: json["in_stock"],
    backorders: json["backorders"],
    backordersAllowed: json["backorders_allowed"],
    backordered: json["backordered"],
    weight: json["weight"],
    dimensions: Dimensions.fromJson(json["dimensions"]),
    shippingClass: json["shipping_class"],
    shippingClassId: json["shipping_class_id"],
    image: List<Image1>.from(json["image"].map((x) => Image1.fromJson(x))),
    attributes: List<VariationAttribute>.from(json["attributes"].map((x) => VariationAttribute.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date_created": dateCreated.toIso8601String(),
    "date_modified": dateModified.toIso8601String(),
    "permalink": permalink,
    "sku": sku,
    "price": price,
    "regular_price": regularPrice,
    "sale_price": salePrice,
    "date_on_sale_from": dateOnSaleFrom,
    "date_on_sale_to": dateOnSaleTo,
    "on_sale": onSale,
    "purchasable": purchasable,
    "visible": visible,
    "virtual": virtual,
    "downloadable": downloadable,
    "downloads": List<dynamic>.from(downloads.map((x) => x)),
    "download_limit": downloadLimit,
    "download_expiry": downloadExpiry,
    "tax_status": taxStatus,
    "tax_class": taxClass,
    "manage_stock": manageStock,
    "stock_quantity": stockQuantity,
    "in_stock": inStock,
    "backorders": backorders,
    "backorders_allowed": backordersAllowed,
    "backordered": backordered,
    "weight": weight,
    "dimensions": dimensions.toJson(),
    "shipping_class": shippingClass,
    "shipping_class_id": shippingClassId,
    "image": List<dynamic>.from(image.map((x) => x.toJson())),
    "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
  };
}

class VariationAttribute {
  int id;
  String name;
  String option;

  VariationAttribute({
    required this.id,
    required this.name,
    required this.option,
  });

  factory VariationAttribute.fromJson(Map<String, dynamic> json) => VariationAttribute(
    id: json["id"],
    name: json["name"],
    option: json["option"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "option": option,
  };
}

class Dimensions {
  String length;
  String width;
  String height;

  Dimensions({
    required this.length,
    required this.width,
    required this.height,
  });

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
    length: json["length"],
    width: json["width"],
    height: json["height"],
  );

  Map<String, dynamic> toJson() => {
    "length": length,
    "width": width,
    "height": height,
  };
}
