class GetAddToCartItems {
  List<AddToCarts>? addToCarts;
  int? amount;

  GetAddToCartItems({this.addToCarts, this.amount});

  GetAddToCartItems.fromJson(Map<String, dynamic> json) {
    if (json['addToCarts'] != null) {
      addToCarts = <AddToCarts>[];
      json['addToCarts'].forEach((v) {
        addToCarts!.add(new AddToCarts.fromJson(v));
      });
    }
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addToCarts != null) {
      data['addToCarts'] = this.addToCarts!.map((v) => v.toJson()).toList();
    }
    data['amount'] = this.amount;
    return data;
  }
}

class AddToCarts {
  String? sId;
  String? userId;
  String? productId;
  int? quantity;
  String? productsName;
  String? subHeading;
  int? productPrice;
  String? type;
  String? fabric;
  String? printOrPattern;
  String? border;
  String? sizeFit;
  String? description;
  int? productNo;
  List<String>? productImage;
  int? iV;
  int? countOfTheProduct = 0;

  AddToCarts(
      {this.sId,
      this.userId,
      this.productId,
      this.quantity,
      this.productsName,
      this.subHeading,
      this.productPrice,
      this.type,
      this.fabric,
      this.printOrPattern,
      this.border,
      this.sizeFit,
      this.description,
      this.productNo,
      this.productImage,
      this.iV,
      this.countOfTheProduct});

  AddToCarts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    productId = json['product_id'];
    quantity = json['quantity'];
    productsName = json['productsName'];
    subHeading = json['subHeading'];
    productPrice = json['productPrice'];
    type = json['type'];
    fabric = json['fabric'];
    printOrPattern = json['printOrPattern'];
    border = json['border'];
    sizeFit = json['sizeFit'];
    description = json['description'];
    productNo = json['product_no'];
    productImage = json['productImage'].cast<String>();
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['productsName'] = this.productsName;
    data['subHeading'] = this.subHeading;
    data['productPrice'] = this.productPrice;
    data['type'] = this.type;
    data['fabric'] = this.fabric;
    data['printOrPattern'] = this.printOrPattern;
    data['border'] = this.border;
    data['sizeFit'] = this.sizeFit;
    data['description'] = this.description;
    data['product_no'] = this.productNo;
    data['productImage'] = this.productImage;
    data['__v'] = this.iV;
    return data;
  }

  void updateQuantity(int newQuantity) {
    countOfTheProduct =  newQuantity;
  }
}
