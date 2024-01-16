// // To parse this JSON data, do
// //
// //     final dashboardModel = dashboardModelFromJson(jsonString);
//
// import 'dart:convert';
//
// DashboardModel dashboardModelFromJson(String str) => DashboardModel.fromJson(json.decode(str));
//
// String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());
//
// class DashboardModel {
//   List<Product> products;
//   List<Category> categories;
//   List<FeaturedProduct> featuredProducts;
//   List<Product> topSellingProducts;
//   String currencySymbol;
//   String currencyCode;
//
//   DashboardModel({
//     required this.products,
//     required this.categories,
//     required this.featuredProducts,
//     required this.topSellingProducts,
//     required this.currencySymbol,
//     required this.currencyCode,
//   });
//
//   factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
//     products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
//     categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
//     featuredProducts: List<FeaturedProduct>.from(json["featured_products"].map((x) => FeaturedProduct.fromJson(x))),
//     topSellingProducts: List<Product>.from(json["top_selling_products"].map((x) => Product.fromJson(x))),
//     currencySymbol: json["currency_symbol"],
//     currencyCode: json["currency_code"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "products": List<dynamic>.from(products.map((x) => x.toJson())),
//     "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
//     "featured_products": List<dynamic>.from(featuredProducts.map((x) => x.toJson())),
//     "top_selling_products": List<dynamic>.from(topSellingProducts.map((x) => x.toJson())),
//     "currency_symbol": currencySymbol,
//     "currency_code": currencyCode,
//   };
// }
//
// class Category {
//   int termId;
//   String name;
//   String slug;
//   int termGroup;
//   int termTaxonomyId;
//   Taxonomy taxonomy;
//   String description;
//   int parent;
//   int count;
//   Filter filter;
//   dynamic thumbnail;
//
//   Category({
//     required this.termId,
//     required this.name,
//     required this.slug,
//     required this.termGroup,
//     required this.termTaxonomyId,
//     required this.taxonomy,
//     required this.description,
//     required this.parent,
//     required this.count,
//     required this.filter,
//     this.thumbnail,
//   });
//
//   factory Category.fromJson(Map<String, dynamic> json) => Category(
//     termId: json["term_id"],
//     name: json["name"],
//     slug: json["slug"],
//     termGroup: json["term_group"],
//     termTaxonomyId: json["term_taxonomy_id"],
//     taxonomy: taxonomyValues.map[json["taxonomy"]]!,
//     description: json["description"],
//     parent: json["parent"],
//     count: json["count"],
//     filter: filterValues.map[json["filter"]]!,
//     thumbnail: json["thumbnail"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "term_id": termId,
//     "name": name,
//     "slug": slug,
//     "term_group": termGroup,
//     "term_taxonomy_id": termTaxonomyId,
//     "taxonomy": taxonomyValues.reverse[taxonomy],
//     "description": description,
//     "parent": parent,
//     "count": count,
//     "filter": filterValues.reverse[filter],
//     "thumbnail": thumbnail,
//   };
// }
//
// enum Filter { RAW }
//
// final filterValues = EnumValues({
//   "raw": Filter.RAW
// });
//
// enum Taxonomy { PRODUCT_CAT }
//
// final taxonomyValues = EnumValues({
//   "product_cat": Taxonomy.PRODUCT_CAT
// });
//
// class FeaturedProduct {
//   int id;
//   String name;
//   String slug;
//   String permalink;
//   DateTime dateCreated;
//   DateTime dateModified;
//   String type;
//   Status status;
//   bool featured;
//   CatalogVisibility catalogVisibility;
//   String description;
//   String shortDescription;
//   String sku;
//   String price;
//   String regularPrice;
//   String salePrice;
//   String dateOnSaleFrom;
//   String dateOnSaleTo;
//   String priceHtml;
//   bool onSale;
//   bool purchasable;
//   int totalSales;
//   bool virtual;
//   bool downloadable;
//   List<dynamic> downloads;
//   int downloadLimit;
//   int downloadExpiry;
//   DownloadType downloadType;
//   String externalUrl;
//   String buttonText;
//   TaxStatus taxStatus;
//   String taxClass;
//   bool manageStock;
//   dynamic stockQuantity;
//   bool inStock;
//   Backorders backorders;
//   bool backordersAllowed;
//   bool backordered;
//   bool soldIndividually;
//   String weight;
//   bool shippingRequired;
//   bool shippingTaxable;
//   String shippingClass;
//   int shippingClassId;
//   bool reviewsAllowed;
//   String averageRating;
//   int ratingCount;
//   List<int> relatedIds;
//   List<dynamic> upsellIds;
//   List<dynamic> crossSellIds;
//   int parentId;
//   String purchaseNote;
//   List<Category> categories;
//   List<dynamic> tags;
//   List<Images> images;
//   List<FeaturedProductAttribute> attributes;
//   List<dynamic> defaultAttributes;
//   List<FeaturedProductVariation> variations;
//   List<dynamic> groupedProducts;
//   String vendorId;
//   int menuOrder;
//   List<MetaDatum> metaData;
//
//   FeaturedProduct({
//     required this.id,
//     required this.name,
//     required this.slug,
//     required this.permalink,
//     required this.dateCreated,
//     required this.dateModified,
//     required this.type,
//     required this.status,
//     required this.featured,
//     required this.catalogVisibility,
//     required this.description,
//     required this.shortDescription,
//     required this.sku,
//     required this.price,
//     required this.regularPrice,
//     required this.salePrice,
//     required this.dateOnSaleFrom,
//     required this.dateOnSaleTo,
//     required this.priceHtml,
//     required this.onSale,
//     required this.purchasable,
//     required this.totalSales,
//     required this.virtual,
//     required this.downloadable,
//     required this.downloads,
//     required this.downloadLimit,
//     required this.downloadExpiry,
//     required this.downloadType,
//     required this.externalUrl,
//     required this.buttonText,
//     required this.taxStatus,
//     required this.taxClass,
//     required this.manageStock,
//     this.stockQuantity,
//     required this.inStock,
//     required this.backorders,
//     required this.backordersAllowed,
//     required this.backordered,
//     required this.soldIndividually,
//     required this.weight,
//     required this.shippingRequired,
//     required this.shippingTaxable,
//     required this.shippingClass,
//     required this.shippingClassId,
//     required this.reviewsAllowed,
//     required this.averageRating,
//     required this.ratingCount,
//     required this.relatedIds,
//     required this.upsellIds,
//     required this.crossSellIds,
//     required this.parentId,
//     required this.purchaseNote,
//     required this.categories,
//     required this.tags,
//     required this.images,
//     required this.attributes,
//     required this.defaultAttributes,
//     required this.variations,
//     required this.groupedProducts,
//     required this.vendorId,
//     required this.menuOrder,
//     required this.metaData,
//   });
//
//   factory FeaturedProduct.fromJson(Map<String, dynamic> json) => FeaturedProduct(
//     id: json["id"],
//     name: json["name"],
//     slug: json["slug"],
//     permalink: json["permalink"],
//     dateCreated: DateTime.parse(json["date_created"]),
//     dateModified: DateTime.parse(json["date_modified"]),
//     type: json["type"],
//     status: statusValues.map[json["status"]]!,
//     featured: json["featured"],
//     catalogVisibility: catalogVisibilityValues.map[json["catalog_visibility"]]!,
//     description: json["description"],
//     shortDescription: json["short_description"],
//     sku: json["sku"],
//     price: json["price"],
//     regularPrice: json["regular_price"],
//     salePrice: json["sale_price"],
//     dateOnSaleFrom: json["date_on_sale_from"],
//     dateOnSaleTo: json["date_on_sale_to"],
//     priceHtml: json["price_html"],
//     onSale: json["on_sale"],
//     purchasable: json["purchasable"],
//     totalSales: json["total_sales"],
//     virtual: json["virtual"],
//     downloadable: json["downloadable"],
//     downloads: List<dynamic>.from(json["downloads"].map((x) => x)),
//     downloadLimit: json["download_limit"],
//     downloadExpiry: json["download_expiry"],
//     downloadType: downloadTypeValues.map[json["download_type"]]!,
//     externalUrl: json["external_url"],
//     buttonText: json["button_text"],
//     taxStatus: taxStatusValues.map[json["tax_status"]]!,
//     taxClass: json["tax_class"],
//     manageStock: json["manage_stock"],
//     stockQuantity: json["stock_quantity"],
//     inStock: json["in_stock"],
//     backorders: backordersValues.map[json["backorders"]]!,
//     backordersAllowed: json["backorders_allowed"],
//     backordered: json["backordered"],
//     soldIndividually: json["sold_individually"],
//     weight: json["weight"],
//     shippingRequired: json["shipping_required"],
//     shippingTaxable: json["shipping_taxable"],
//     shippingClass: json["shipping_class"],
//     shippingClassId: json["shipping_class_id"],
//     reviewsAllowed: json["reviews_allowed"],
//     averageRating: json["average_rating"],
//     ratingCount: json["rating_count"],
//     relatedIds: List<int>.from(json["related_ids"].map((x) => x)),
//     upsellIds: List<dynamic>.from(json["upsell_ids"].map((x) => x)),
//     crossSellIds: List<dynamic>.from(json["cross_sell_ids"].map((x) => x)),
//     parentId: json["parent_id"],
//     purchaseNote: json["purchase_note"],
//     categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
//     tags: List<dynamic>.from(json["tags"].map((x) => x)),
//     images: List<Images>.from(json["images"].map((x) => Images.fromJson(x))),
//     attributes: List<FeaturedProductAttribute>.from(json["attributes"].map((x) => FeaturedProductAttribute.fromJson(x))),
//     defaultAttributes: List<dynamic>.from(json["default_attributes"].map((x) => x)),
//     variations: List<FeaturedProductVariation>.from(json["variations"].map((x) => FeaturedProductVariation.fromJson(x))),
//     groupedProducts: List<dynamic>.from(json["grouped_products"].map((x) => x)),
//     vendorId: json["vendor_id"],
//     menuOrder: json["menu_order"],
//     metaData: List<MetaDatum>.from(json["meta_data"].map((x) => MetaDatum.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "slug": slug,
//     "permalink": permalink,
//     "date_created": dateCreated.toIso8601String(),
//     "date_modified": dateModified.toIso8601String(),
//     "type": type,
//     "status": statusValues.reverse[status],
//     "featured": featured,
//     "catalog_visibility": catalogVisibilityValues.reverse[catalogVisibility],
//     "description": description,
//     "short_description": shortDescription,
//     "sku": sku,
//     "price": price,
//     "regular_price": regularPrice,
//     "sale_price": salePrice,
//     "date_on_sale_from": dateOnSaleFrom,
//     "date_on_sale_to": dateOnSaleTo,
//     "price_html": priceHtml,
//     "on_sale": onSale,
//     "purchasable": purchasable,
//     "total_sales": totalSales,
//     "virtual": virtual,
//     "downloadable": downloadable,
//     "downloads": List<dynamic>.from(downloads.map((x) => x)),
//     "download_limit": downloadLimit,
//     "download_expiry": downloadExpiry,
//     "download_type": downloadTypeValues.reverse[downloadType],
//     "external_url": externalUrl,
//     "button_text": buttonText,
//     "tax_status": taxStatusValues.reverse[taxStatus],
//     "tax_class": taxClass,
//     "manage_stock": manageStock,
//     "stock_quantity": stockQuantity,
//     "in_stock": inStock,
//     "backorders": backordersValues.reverse[backorders],
//     "backorders_allowed": backordersAllowed,
//     "backordered": backordered,
//     "sold_individually": soldIndividually,
//     "weight": weight,
//     "shipping_required": shippingRequired,
//     "shipping_taxable": shippingTaxable,
//     "shipping_class": shippingClass,
//     "shipping_class_id": shippingClassId,
//     "reviews_allowed": reviewsAllowed,
//     "average_rating": averageRating,
//     "rating_count": ratingCount,
//     "related_ids": List<dynamic>.from(relatedIds.map((x) => x)),
//     "upsell_ids": List<dynamic>.from(upsellIds.map((x) => x)),
//     "cross_sell_ids": List<dynamic>.from(crossSellIds.map((x) => x)),
//     "parent_id": parentId,
//     "purchase_note": purchaseNote,
//     "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
//     "tags": List<dynamic>.from(tags.map((x) => x)),
//     "images": List<dynamic>.from(images.map((x) => x.toJson())),
//     "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
//     "default_attributes": List<dynamic>.from(defaultAttributes.map((x) => x)),
//     "variations": List<dynamic>.from(variations.map((x) => x.toJson())),
//     "grouped_products": List<dynamic>.from(groupedProducts.map((x) => x)),
//     "vendor_id": vendorId,
//     "menu_order": menuOrder,
//     "meta_data": List<dynamic>.from(metaData.map((x) => x.toJson())),
//   };
// }
//
// class FeaturedProductAttribute {
//   int id;
//   Name? name;
//   int position;
//   bool visible;
//   bool variation;
//   List<String> options;
//
//   FeaturedProductAttribute({
//     required this.id,
//     required this.name,
//     required this.position,
//     required this.visible,
//     required this.variation,
//     required this.options,
//   });
//
//   factory FeaturedProductAttribute.fromJson(Map<String, dynamic> json) => FeaturedProductAttribute(
//     id: json["id"],
//     name: nameValues.map[json["name"]],
//     position: json["position"],
//     visible: json["visible"],
//     variation: json["variation"],
//     options: List<String>.from(json["options"].map((x) => x)),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": nameValues.reverse[name],
//     "position": position,
//     "visible": visible,
//     "variation": variation,
//     "options": List<dynamic>.from(options.map((x) => x)),
//   };
// }
//
// enum Name { COLOR, SIZE }
//
// final nameValues = EnumValues({
//   "Color": Name.COLOR,
//   "Size": Name.SIZE
// });
//
// enum Backorders { NO }
//
// final backordersValues = EnumValues({
//   "no": Backorders.NO
// });
//
// enum CatalogVisibility { VISIBLE, HIDDEN }
//
// final catalogVisibilityValues = EnumValues({
//   "hidden": CatalogVisibility.HIDDEN,
//   "visible": CatalogVisibility.VISIBLE
// });
//
// enum DownloadType { STANDARD }
//
// final downloadTypeValues = EnumValues({
//   "standard": DownloadType.STANDARD
// });
//
// class Images {
//   int id;
//   DateTime dateCreated;
//   DateTime dateModified;
//   String src;
//   String name;
//   String alt;
//   int position;
//
//   Images({
//     required this.id,
//     required this.dateCreated,
//     required this.dateModified,
//     required this.src,
//     required this.name,
//     required this.alt,
//     required this.position,
//   });
//
//   factory Images.fromJson(Map<String, dynamic> json) => Images(
//     id: json["id"],
//     dateCreated: DateTime.parse(json["date_created"]),
//     dateModified: DateTime.parse(json["date_modified"]),
//     src: json["src"],
//     name: json["name"],
//     alt: json["alt"],
//     position: json["position"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "date_created": dateCreated.toIso8601String(),
//     "date_modified": dateModified.toIso8601String(),
//     "src": src,
//     "name": name,
//     "alt": alt,
//     "position": position,
//   };
// }
//
// class MetaDatum {
//   int id;
//   Key key;
//   String value;
//
//   MetaDatum({
//     required this.id,
//     required this.key,
//     required this.value,
//   });
//
//   factory MetaDatum.fromJson(Map<String, dynamic> json) => MetaDatum(
//     id: json["id"],
//     key: keyValues.map[json["key"]]!,
//     value: json["value"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "key": keyValues.reverse[key],
//     "value": value,
//   };
// }
//
// enum Key { WPCOM_IS_MARKDOWN }
//
// final keyValues = EnumValues({
//   "_wpcom_is_markdown": Key.WPCOM_IS_MARKDOWN
// });
//
// enum Status { PUBLISH }
//
// final statusValues = EnumValues({
//   "publish": Status.PUBLISH
// });
//
// enum TaxStatus { TAXABLE }
//
// final taxStatusValues = EnumValues({
//   "taxable": TaxStatus.TAXABLE
// });
//
// class FeaturedProductVariation {
//   int id;
//   DateTime dateCreated;
//   DateTime dateModified;
//   String permalink;
//   String sku;
//   String price;
//   String regularPrice;
//   String salePrice;
//   String dateOnSaleFrom;
//   String dateOnSaleTo;
//   bool onSale;
//   bool purchasable;
//   bool visible;
//   bool virtual;
//   bool downloadable;
//   List<dynamic> downloads;
//   int downloadLimit;
//   int downloadExpiry;
//   TaxStatus taxStatus;
//   String taxClass;
//   bool manageStock;
//   dynamic stockQuantity;
//   bool inStock;
//   Backorders backorders;
//   bool backordersAllowed;
//   bool backordered;
//   String weight;
//   Dimensions dimensions;
//   String shippingClass;
//   int shippingClassId;
//   List<Images> image;
//   List<PurpleAttribute> attributes;
//
//   FeaturedProductVariation({
//     required this.id,
//     required this.dateCreated,
//     required this.dateModified,
//     required this.permalink,
//     required this.sku,
//     required this.price,
//     required this.regularPrice,
//     required this.salePrice,
//     required this.dateOnSaleFrom,
//     required this.dateOnSaleTo,
//     required this.onSale,
//     required this.purchasable,
//     required this.visible,
//     required this.virtual,
//     required this.downloadable,
//     required this.downloads,
//     required this.downloadLimit,
//     required this.downloadExpiry,
//     required this.taxStatus,
//     required this.taxClass,
//     required this.manageStock,
//     this.stockQuantity,
//     required this.inStock,
//     required this.backorders,
//     required this.backordersAllowed,
//     required this.backordered,
//     required this.weight,
//     required this.dimensions,
//     required this.shippingClass,
//     required this.shippingClassId,
//     required this.image,
//     required this.attributes,
//   });
//
//   factory FeaturedProductVariation.fromJson(Map<String, dynamic> json) => FeaturedProductVariation(
//     id: json["id"],
//     dateCreated: DateTime.parse(json["date_created"]),
//     dateModified: DateTime.parse(json["date_modified"]),
//     permalink: json["permalink"],
//     sku: json["sku"],
//     price: json["price"],
//     regularPrice: json["regular_price"],
//     salePrice: json["sale_price"],
//     dateOnSaleFrom: json["date_on_sale_from"],
//     dateOnSaleTo: json["date_on_sale_to"],
//     onSale: json["on_sale"],
//     purchasable: json["purchasable"],
//     visible: json["visible"],
//     virtual: json["virtual"],
//     downloadable: json["downloadable"],
//     downloads: List<dynamic>.from(json["downloads"].map((x) => x)),
//     downloadLimit: json["download_limit"],
//     downloadExpiry: json["download_expiry"],
//     taxStatus: taxStatusValues.map[json["tax_status"]]!,
//     taxClass: json["tax_class"],
//     manageStock: json["manage_stock"],
//     stockQuantity: json["stock_quantity"],
//     inStock: json["in_stock"],
//     backorders: backordersValues.map[json["backorders"]]!,
//     backordersAllowed: json["backorders_allowed"],
//     backordered: json["backordered"],
//     weight: json["weight"],
//     dimensions: Dimensions.fromJson(json["dimensions"]),
//     shippingClass: json["shipping_class"],
//     shippingClassId: json["shipping_class_id"],
//     image: List<Images>.from(json["image"].map((x) => Images.fromJson(x))),
//     attributes: List<PurpleAttribute>.from(json["attributes"].map((x) => PurpleAttribute.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "date_created": dateCreated.toIso8601String(),
//     "date_modified": dateModified.toIso8601String(),
//     "permalink": permalink,
//     "sku": sku,
//     "price": price,
//     "regular_price": regularPrice,
//     "sale_price": salePrice,
//     "date_on_sale_from": dateOnSaleFrom,
//     "date_on_sale_to": dateOnSaleTo,
//     "on_sale": onSale,
//     "purchasable": purchasable,
//     "visible": visible,
//     "virtual": virtual,
//     "downloadable": downloadable,
//     "downloads": List<dynamic>.from(downloads.map((x) => x)),
//     "download_limit": downloadLimit,
//     "download_expiry": downloadExpiry,
//     "tax_status": taxStatusValues.reverse[taxStatus],
//     "tax_class": taxClass,
//     "manage_stock": manageStock,
//     "stock_quantity": stockQuantity,
//     "in_stock": inStock,
//     "backorders": backordersValues.reverse[backorders],
//     "backorders_allowed": backordersAllowed,
//     "backordered": backordered,
//     "weight": weight,
//     "dimensions": dimensions.toJson(),
//     "shipping_class": shippingClass,
//     "shipping_class_id": shippingClassId,
//     "image": List<dynamic>.from(image.map((x) => x.toJson())),
//     "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
//   };
// }
//
// class PurpleAttribute {
//   int id;
//   Name name;
//   String option;
//
//   PurpleAttribute({
//     required this.id,
//     required this.name,
//     required this.option,
//   });
//
//   factory PurpleAttribute.fromJson(Map<String, dynamic> json) => PurpleAttribute(
//     id: json["id"],
//     name: nameValues.map[json["name"]]!,
//     option: json["option"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": nameValues.reverse[name],
//     "option": option,
//   };
// }
//
// class Dimensions {
//   String length;
//   String width;
//   String height;
//
//   Dimensions({
//     required this.length,
//     required this.width,
//     required this.height,
//   });
//
//   factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
//     length: json["length"],
//     width: json["width"],
//     height: json["height"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "length": length,
//     "width": width,
//     "height": height,
//   };
// }
//
// class Product {
//   int id;
//   String name;
//   String slug;
//   String permalink;
//   DateTime dateCreated;
//   DateTime dateModified;
//   // Type type;
//   Status status;
//   bool featured;
//   CatalogVisibility catalogVisibility;
//   String description;
//   String shortDescription;
//   String sku;
//   String price;
//   String regularPrice;
//   String salePrice;
//   String dateOnSaleFrom;
//   String dateOnSaleTo;
//   String priceHtml;
//   bool onSale;
//   bool purchasable;
//   int totalSales;
//   bool virtual;
//   bool downloadable;
//   List<Download> downloads;
//   int downloadLimit;
//   int downloadExpiry;
//   DownloadType downloadType;
//   String externalUrl;
//   ButtonText buttonText;
//   TaxStatus taxStatus;
//   String taxClass;
//   bool manageStock;
//   dynamic stockQuantity;
//   bool inStock;
//   Backorders backorders;
//   bool backordersAllowed;
//   bool backordered;
//   bool soldIndividually;
//   String weight;
//   bool shippingRequired;
//   bool shippingTaxable;
//   String shippingClass;
//   int shippingClassId;
//   bool reviewsAllowed;
//   String averageRating;
//   int ratingCount;
//   List<int> relatedIds;
//   List<dynamic> upsellIds;
//   List<dynamic> crossSellIds;
//   int parentId;
//   String purchaseNote;
//   List<Category> categories;
//   List<dynamic> tags;
//   List<Images> images;
//   List<FeaturedProductAttribute> attributes;
//   List<dynamic> defaultAttributes;
//   List<ProductVariation> variations;
//   List<dynamic> groupedProducts;
//   String vendorId;
//   int menuOrder;
//   List<MetaDatum> metaData;
//
//   Product({
//     required this.id,
//     required this.name,
//     required this.slug,
//     required this.permalink,
//     required this.dateCreated,
//     required this.dateModified,
//     // required this.type,
//     required this.status,
//     required this.featured,
//     required this.catalogVisibility,
//     required this.description,
//     required this.shortDescription,
//     required this.sku,
//     required this.price,
//     required this.regularPrice,
//     required this.salePrice,
//     required this.dateOnSaleFrom,
//     required this.dateOnSaleTo,
//     required this.priceHtml,
//     required this.onSale,
//     required this.purchasable,
//     required this.totalSales,
//     required this.virtual,
//     required this.downloadable,
//     required this.downloads,
//     required this.downloadLimit,
//     required this.downloadExpiry,
//     required this.downloadType,
//     required this.externalUrl,
//     required this.buttonText,
//     required this.taxStatus,
//     required this.taxClass,
//     required this.manageStock,
//     this.stockQuantity,
//     required this.inStock,
//     required this.backorders,
//     required this.backordersAllowed,
//     required this.backordered,
//     required this.soldIndividually,
//     required this.weight,
//     required this.shippingRequired,
//     required this.shippingTaxable,
//     required this.shippingClass,
//     required this.shippingClassId,
//     required this.reviewsAllowed,
//     required this.averageRating,
//     required this.ratingCount,
//     required this.relatedIds,
//     required this.upsellIds,
//     required this.crossSellIds,
//     required this.parentId,
//     required this.purchaseNote,
//     required this.categories,
//     required this.tags,
//     required this.images,
//     required this.attributes,
//     required this.defaultAttributes,
//     required this.variations,
//     required this.groupedProducts,
//     required this.vendorId,
//     required this.menuOrder,
//     required this.metaData,
//   });
//
//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//     id: json["id"],
//     name: json["name"],
//     slug: json["slug"],
//     permalink: json["permalink"],
//     dateCreated: DateTime.parse(json["date_created"]),
//     dateModified: DateTime.parse(json["date_modified"]),
//     //type: typeValues.map[json["type"]]!,
//     status: statusValues.map[json["status"]]!,
//     featured: json["featured"],
//     catalogVisibility: catalogVisibilityValues.map[json["catalog_visibility"]]!,
//     description: json["description"],
//     shortDescription: json["short_description"],
//     sku: json["sku"],
//     price: json["price"],
//     regularPrice: json["regular_price"],
//     salePrice: json["sale_price"],
//     dateOnSaleFrom: json["date_on_sale_from"],
//     dateOnSaleTo: json["date_on_sale_to"],
//     priceHtml: json["price_html"],
//     onSale: json["on_sale"],
//     purchasable: json["purchasable"],
//     totalSales: json["total_sales"],
//     virtual: json["virtual"],
//     downloadable: json["downloadable"],
//     downloads: List<Download>.from(json["downloads"].map((x) => Download.fromJson(x))),
//     downloadLimit: json["download_limit"],
//     downloadExpiry: json["download_expiry"],
//     downloadType: downloadTypeValues.map[json["download_type"]]!,
//     externalUrl: json["external_url"],
//     buttonText: buttonTextValues.map[json["button_text"]]!,
//     taxStatus: taxStatusValues.map[json["tax_status"]]!,
//     taxClass: json["tax_class"],
//     manageStock: json["manage_stock"],
//     stockQuantity: json["stock_quantity"],
//     inStock: json["in_stock"],
//     backorders: backordersValues.map[json["backorders"]]!,
//     backordersAllowed: json["backorders_allowed"],
//     backordered: json["backordered"],
//     soldIndividually: json["sold_individually"],
//     weight: json["weight"],
//     shippingRequired: json["shipping_required"],
//     shippingTaxable: json["shipping_taxable"],
//     shippingClass: json["shipping_class"],
//     shippingClassId: json["shipping_class_id"],
//     reviewsAllowed: json["reviews_allowed"],
//     averageRating: json["average_rating"],
//     ratingCount: json["rating_count"],
//     relatedIds: List<int>.from(json["related_ids"].map((x) => x)),
//     upsellIds: List<dynamic>.from(json["upsell_ids"].map((x) => x)),
//     crossSellIds: List<dynamic>.from(json["cross_sell_ids"].map((x) => x)),
//     parentId: json["parent_id"],
//     purchaseNote: json["purchase_note"],
//     categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
//     tags: List<dynamic>.from(json["tags"].map((x) => x)),
//     images: List<Images>.from(json["images"].map((x) => Images.fromJson(x))),
//     attributes: List<FeaturedProductAttribute>.from(json["attributes"].map((x) => FeaturedProductAttribute.fromJson(x))),
//     defaultAttributes: List<dynamic>.from(json["default_attributes"].map((x) => x)),
//     variations: List<ProductVariation>.from(json["variations"].map((x) => ProductVariation.fromJson(x))),
//     groupedProducts: List<dynamic>.from(json["grouped_products"].map((x) => x)),
//     vendorId: json["vendor_id"],
//     menuOrder: json["menu_order"],
//     metaData: List<MetaDatum>.from(json["meta_data"].map((x) => MetaDatum.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "slug": slug,
//     "permalink": permalink,
//     "date_created": dateCreated.toIso8601String(),
//     "date_modified": dateModified.toIso8601String(),
//    // "type": typeValues.reverse[type],
//     "status": statusValues.reverse[status],
//     "featured": featured,
//     "catalog_visibility": catalogVisibilityValues.reverse[catalogVisibility],
//     "description": description,
//     "short_description": shortDescription,
//     "sku": sku,
//     "price": price,
//     "regular_price": regularPrice,
//     "sale_price": salePrice,
//     "date_on_sale_from": dateOnSaleFrom,
//     "date_on_sale_to": dateOnSaleTo,
//     "price_html": priceHtml,
//     "on_sale": onSale,
//     "purchasable": purchasable,
//     "total_sales": totalSales,
//     "virtual": virtual,
//     "downloadable": downloadable,
//     "downloads": List<dynamic>.from(downloads.map((x) => x.toJson())),
//     "download_limit": downloadLimit,
//     "download_expiry": downloadExpiry,
//     "download_type": downloadTypeValues.reverse[downloadType],
//     "external_url": externalUrl,
//     "button_text": buttonTextValues.reverse[buttonText],
//     "tax_status": taxStatusValues.reverse[taxStatus],
//     "tax_class": taxClass,
//     "manage_stock": manageStock,
//     "stock_quantity": stockQuantity,
//     "in_stock": inStock,
//     "backorders": backordersValues.reverse[backorders],
//     "backorders_allowed": backordersAllowed,
//     "backordered": backordered,
//     "sold_individually": soldIndividually,
//     "weight": weight,
//     "shipping_required": shippingRequired,
//     "shipping_taxable": shippingTaxable,
//     "shipping_class": shippingClass,
//     "shipping_class_id": shippingClassId,
//     "reviews_allowed": reviewsAllowed,
//     "average_rating": averageRating,
//     "rating_count": ratingCount,
//     "related_ids": List<dynamic>.from(relatedIds.map((x) => x)),
//     "upsell_ids": List<dynamic>.from(upsellIds.map((x) => x)),
//     "cross_sell_ids": List<dynamic>.from(crossSellIds.map((x) => x)),
//     "parent_id": parentId,
//     "purchase_note": purchaseNote,
//     "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
//     "tags": List<dynamic>.from(tags.map((x) => x)),
//     "images": List<dynamic>.from(images.map((x) => x.toJson())),
//     "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
//     "default_attributes": List<dynamic>.from(defaultAttributes.map((x) => x)),
//     "variations": List<dynamic>.from(variations.map((x) => x.toJson())),
//     "grouped_products": List<dynamic>.from(groupedProducts.map((x) => x)),
//     "vendor_id": vendorId,
//     "menu_order": menuOrder,
//     "meta_data": List<dynamic>.from(metaData.map((x) => x.toJson())),
//   };
// }
//
// enum ButtonText { BUY_ON_THE_WORD_PRESS_SWAG_STORE, EMPTY }
//
// final buttonTextValues = EnumValues({
//   "Buy on the WordPress swag store!": ButtonText.BUY_ON_THE_WORD_PRESS_SWAG_STORE,
//   "": ButtonText.EMPTY
// });
//
// class Download {
//   String id;
//   String name;
//   String file;
//
//   Download({
//     required this.id,
//     required this.name,
//     required this.file,
//   });
//
//   factory Download.fromJson(Map<String, dynamic> json) => Download(
//     id: json["id"],
//     name: json["name"],
//     file: json["file"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "file": file,
//   };
// }
//
// enum Type { EXTERNAL, GROUPED, SIMPLE }
//
// final typeValues = EnumValues({
//   "external": Type.EXTERNAL,
//   "grouped": Type.GROUPED,
//   "simple": Type.SIMPLE
// });
//
// class ProductVariation {
//   int id;
//   DateTime dateCreated;
//   DateTime dateModified;
//   String permalink;
//   String sku;
//   String price;
//   String regularPrice;
//   String salePrice;
//   String dateOnSaleFrom;
//   String dateOnSaleTo;
//   bool onSale;
//   bool purchasable;
//   bool visible;
//   bool virtual;
//   bool downloadable;
//   List<dynamic> downloads;
//   int downloadLimit;
//   int downloadExpiry;
//   TaxStatus taxStatus;
//   String taxClass;
//   bool manageStock;
//   dynamic stockQuantity;
//   bool inStock;
//   Backorders backorders;
//   bool backordersAllowed;
//   bool backordered;
//   String weight;
//   Dimensions dimensions;
//   String shippingClass;
//   int shippingClassId;
//   List<Images> image;
//   List<FeaturedProductAttribute> attributes;
//
//   ProductVariation({
//     required this.id,
//     required this.dateCreated,
//     required this.dateModified,
//     required this.permalink,
//     required this.sku,
//     required this.price,
//     required this.regularPrice,
//     required this.salePrice,
//     required this.dateOnSaleFrom,
//     required this.dateOnSaleTo,
//     required this.onSale,
//     required this.purchasable,
//     required this.visible,
//     required this.virtual,
//     required this.downloadable,
//     required this.downloads,
//     required this.downloadLimit,
//     required this.downloadExpiry,
//     required this.taxStatus,
//     required this.taxClass,
//     required this.manageStock,
//     this.stockQuantity,
//     required this.inStock,
//     required this.backorders,
//     required this.backordersAllowed,
//     required this.backordered,
//     required this.weight,
//     required this.dimensions,
//     required this.shippingClass,
//     required this.shippingClassId,
//     required this.image,
//     required this.attributes,
//   });
//
//   factory ProductVariation.fromJson(Map<String, dynamic> json) => ProductVariation(
//     id: json["id"],
//     dateCreated: DateTime.parse(json["date_created"]),
//     dateModified: DateTime.parse(json["date_modified"]),
//     permalink: json["permalink"],
//     sku: json["sku"],
//     price: json["price"],
//     regularPrice: json["regular_price"],
//     salePrice: json["sale_price"],
//     dateOnSaleFrom: json["date_on_sale_from"],
//     dateOnSaleTo: json["date_on_sale_to"],
//     onSale: json["on_sale"],
//     purchasable: json["purchasable"],
//     visible: json["visible"],
//     virtual: json["virtual"],
//     downloadable: json["downloadable"],
//     downloads: List<dynamic>.from(json["downloads"].map((x) => x)),
//     downloadLimit: json["download_limit"],
//     downloadExpiry: json["download_expiry"],
//     taxStatus: taxStatusValues.map[json["tax_status"]]!,
//     taxClass: json["tax_class"],
//     manageStock: json["manage_stock"],
//     stockQuantity: json["stock_quantity"],
//     inStock: json["in_stock"],
//     backorders: backordersValues.map[json["backorders"]]!,
//     backordersAllowed: json["backorders_allowed"],
//     backordered: json["backordered"],
//     weight: json["weight"],
//     dimensions: Dimensions.fromJson(json["dimensions"]),
//     shippingClass: json["shipping_class"],
//     shippingClassId: json["shipping_class_id"],
//     image: List<Images>.from(json["image"].map((x) => Images.fromJson(x))),
//     attributes: List<FeaturedProductAttribute>.from(json["attributes"].map((x) => FeaturedProductAttribute.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "date_created": dateCreated.toIso8601String(),
//     "date_modified": dateModified.toIso8601String(),
//     "permalink": permalink,
//     "sku": sku,
//     "price": price,
//     "regular_price": regularPrice,
//     "sale_price": salePrice,
//     "date_on_sale_from": dateOnSaleFrom,
//     "date_on_sale_to": dateOnSaleTo,
//     "on_sale": onSale,
//     "purchasable": purchasable,
//     "visible": visible,
//     "virtual": virtual,
//     "downloadable": downloadable,
//     "downloads": List<dynamic>.from(downloads.map((x) => x)),
//     "download_limit": downloadLimit,
//     "download_expiry": downloadExpiry,
//     "tax_status": taxStatusValues.reverse[taxStatus],
//     "tax_class": taxClass,
//     "manage_stock": manageStock,
//     "stock_quantity": stockQuantity,
//     "in_stock": inStock,
//     "backorders": backordersValues.reverse[backorders],
//     "backorders_allowed": backordersAllowed,
//     "backordered": backordered,
//     "weight": weight,
//     "dimensions": dimensions.toJson(),
//     "shipping_class": shippingClass,
//     "shipping_class_id": shippingClassId,
//     "image": List<dynamic>.from(image.map((x) => x.toJson())),
//     "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
//   };
// }
//
// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
