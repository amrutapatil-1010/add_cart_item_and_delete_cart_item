class GetProductModel {
  List<ProductData>? data;

  GetProductModel({this.data});

  GetProductModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ProductData>[];
      json['data'].forEach((v) {
        data!.add(ProductData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductData {
  String? sId;
  String? subHeading;
  int? productPrice;
  String? type;
  String? fabric;
  String? printOrPattern;
  String? border;
  String? sizeFit;
  String? description;
  int? productNo;
  String? productsName;
  String? sellerName;
  bool? approve;
  String? reason;
  List<String>? productImage;
  int? iV;
  int? productCount = 0;
  ProductData(
      {this.sId,
      this.subHeading,
      this.productPrice,
      this.type,
      this.fabric,
      this.printOrPattern,
      this.border,
      this.sizeFit,
      this.description,
      this.productNo,
      this.productsName,
      this.sellerName,
      this.approve,
      this.reason,
      this.productImage,
      this.iV,
      this.productCount = 0});

  ProductData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    subHeading = json['subHeading'];
    productPrice = json['productPrice'];
    type = json['type'];
    fabric = json['fabric'];
    printOrPattern = json['printOrPattern'];
    border = json['border'];
    sizeFit = json['sizeFit'];
    description = json['description'];
    productNo = json['product_no'];
    productsName = json['productsName'];
    sellerName = json['sellerName'];
    approve = json['approve'];
    reason = json['reason'];
    productImage = json['productImage'].cast<String>();
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['subHeading'] = this.subHeading;
    data['productPrice'] = this.productPrice;
    data['type'] = this.type;
    data['fabric'] = this.fabric;
    data['printOrPattern'] = this.printOrPattern;
    data['border'] = this.border;
    data['sizeFit'] = this.sizeFit;
    data['description'] = this.description;
    data['product_no'] = this.productNo;
    data['productsName'] = this.productsName;
    data['sellerName'] = this.sellerName;
    data['approve'] = this.approve;
    data['reason'] = this.reason;
    data['productImage'] = this.productImage;
    data['__v'] = this.iV;
    return data;
  }
}
