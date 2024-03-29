
import '../product/getProductsParent.dart';


// List<CategoryByProductModel> categoryByProductModelFromJson(String str) => List<CategoryByProductModel>.from(json.decode(str).map((x) => CategoryByProductModel.fromJson(x)));
//
// String categoryByProductModelToJson(List<CategoryByProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryByProductModel extends GetProductsParent{

  CategoryByProductModel(int id, String title, String status, bool featured,
      String description, String short_description, String price, String regular_price,
      String sale_price, bool on_sale, bool in_stock, int total_sales, String average_rating,
      int rating_count, List<int>  related_ids, String categories, String tags, List<Images> images,
      List<ProductAttributes> attributes, List<Variations> variations): super.withData(
      id,
      title,
      status,
      featured,
      description,
      short_description,
      price,
      regular_price,
      sale_price,
      on_sale,
      in_stock,
      total_sales,
      average_rating,
      rating_count,
      related_ids,
      images,
      attributes,
      variations
  );



  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'title': title,
        'status': status,
        'featured': featured,
        'description': description,
        'short_description': short_description,
        'price': price,
        'regular_price': regular_price,
        'sale_price': sale_price,
        'on_sale': on_sale,
        'in_stock': in_stock,
        'total_sales': total_sales,
        'average_rating': average_rating,
        'rating_count': rating_count,
        'related_ids': related_ids,
        'images': images,
        'attributes': attributes,
        'variations': variations,

      };
}

class Tag{
  late int id;
  late String name;
  late String slug;


  Tag(this.id, this.name, this.slug );

  Tag.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,
        'slug': slug,
      };
}