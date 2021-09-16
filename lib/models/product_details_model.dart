class ProductModel {
  bool? status;
  Data? data;
  ProductModel({this.status, this.data});
  ProductModel.fromJson(Map<String, dynamic> jsonData) {
    status = jsonData['status'];
    data = jsonData['data'] != null ? Data.fromJson(jsonData['data']) : null;
  }
}

class Data {
  int? id;
  String? image;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? name;
  String? description;
  bool? inFavorites;
  bool? inCart;
  List<String>? images;
  Data({
    this.id,
    this.image,
    this.price,
    this.oldPrice,
    this.discount,
    this.name,
    this.description,
    this.inFavorites,
    this.inCart,
    this.images,
  });
  Data.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    image = jsonData['image'];
    price = jsonData['price'];
    oldPrice = jsonData['oldPrice'];
    discount = jsonData['discount'];
    name = jsonData['name'];
    description = jsonData['description'];
    inFavorites = jsonData['inFavorites'];
    inCart = jsonData['inCart'];
    inCart = jsonData['inCart'];
    images = List.castFrom<dynamic, String>(jsonData['images']);
    // images = (jsonData['images'] != null)
    //     ? jsonData['images'].forEach((element) {
    //         images!.add(jsonData['images']);
    //       })
    //     : null;
  }

  // data = jsonData['data'] != null ? Data.fromJson(jsonData['data']) : null;
}
// class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
//   int _current = 0;
//   final CarouselController _controller = CarouselController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Carousel with indicator controller demo')),
//       body: Column(children: [
//         Expanded(
//           child: CarouselSlider(
//             items: imageSliders,
//             carouselController: _controller,
//             options: CarouselOptions(
//                 autoPlay: true,
//                 enlargeCenterPage: true,
//                 aspectRatio: 2.0,
//                 onPageChanged: (index, reason) {
//                   setState(() {
//                     _current = index;
//                   });
//                 }),
//           ),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: imgList.asMap().entries.map((entry) {
//             return GestureDetector(
//               onTap: () => _controller.animateToPage(entry.key),
//               child: Container(
//                 width: 12.0,
//                 height: 12.0,
//                 margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
//                 decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: (Theme.of(context).brightness == Brightness.dark
//                             ? Colors.white
//                             : Colors.black)
//                         .withOpacity(_current == entry.key ? 0.9 : 0.4)),
//               ),
//             );
//           }).toList(),
//         ),
//       ]),
//     );
//   }
// }
