class CartModel {
  bool? status;
  Data? data;
  CartModel(this.data, this.status);

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<CartItem>? cartItem;
  int? subTotal;
  int? total;
  Data(this.cartItem, this.subTotal, this.total);

  Data.fromJson(Map<String, dynamic> json) {
    subTotal = json['sub_total'];
    total = json['total'];
    var list = json['cart_items'] as List;
    List<CartItem> cartList =
        list.map((val) => CartItem.fromJson(val)).toList();
    cartItem = cartList;
    // for (var x in json['cart_item']) {
    //   CartItem d = CartItem.fromJson(x);
    //   cartItem.add(d);
    // }
  }
}

class CartItem {
  int? id;
  int? quantity;
  Product? product;
  CartItem(this.id, this.quantity, this.product);
  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }
}

class Product {
  int? id;
  int? price;
  int? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;
  List<String> images = [];
  Product(this.id, this.price, this.oldPrice, this.discount, this.image,
      this.name, this.images, this.description);

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = List.castFrom<dynamic, String>(json['images']);
  }
}
