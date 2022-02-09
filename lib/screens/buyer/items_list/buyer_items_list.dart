import 'package:ecommerceapp/models/category.dart';
import 'package:ecommerceapp/models/item.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:transparent_image/transparent_image.dart';

class BuyerItemsList extends StatefulWidget {
  const BuyerItemsList({Key? key}) : super(key: key);

  @override
  _BuyerItemsListState createState() => _BuyerItemsListState();
}

class _BuyerItemsListState extends State<BuyerItemsList> {
  int currentPage = 0;
  bool isLoading = false;

  final List<Category> categories = [
    Category('Men', 'https://i.postimg.cc/NfRGJDDv/7534386-cardigan-knitwear-women-fashion-clothing-icon.png'), 
    Category('Women', 'https://i.postimg.cc/cLsWDS6f/7534390-women-shirt-tops-fashion-clothing-icon.png'), 
    Category('Kids', 'https://i.postimg.cc/zvbZgzt1/7534391-women-shirt-tops-fashion-clothing-icon.png'), 
    Category('Home', 'https://i.postimg.cc/NjpcSzrS/7534405-makeup-beauty-women-fashion-female-icon.png'),
    Category('Men', 'https://i.postimg.cc/NfRGJDDv/7534386-cardigan-knitwear-women-fashion-clothing-icon.png'), 
    Category('Women', 'https://i.postimg.cc/cLsWDS6f/7534390-women-shirt-tops-fashion-clothing-icon.png'), 
    Category('Kids', 'https://i.postimg.cc/zvbZgzt1/7534391-women-shirt-tops-fashion-clothing-icon.png'), 
    Category('Home', 'https://i.postimg.cc/NjpcSzrS/7534405-makeup-beauty-women-fashion-female-icon.png'),
  ];
  final PagingController<int, Item> _pagingController = PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _loadData(pageKey);
    });
    super.initState();
  }

  Future _loadData(int pageKey) async {
    final newItems = [
      Item('Men Cloth', 'Men cloth desc', 100, 'https://i.postimg.cc/Pr0ZZSxG/1641969100f69da7264d8688d9c11e7ce8cd3597b0-thumbnail-900x.jpg'), 
      Item('Women Cloth', 'Men cloth desc', 50, 'https://i.postimg.cc/2yMqQ5Cd/1624937261e1565ed7bb7611d917ff2e6a9ffe580a-thumbnail-900x.jpg'),
      Item('Kids Cloth', 'Men cloth desc', 80, 'https://i.postimg.cc/d10DgC1m/16172552205a1794e7dc17db68856850f0c26eeb53-thumbnail-900x.jpg'), 
      Item('Home products', 'Home products desc', 120, 'https://i.postimg.cc/j5kCTjnV/16340030929e7b3bd5c75857d1c040c639acc70476-thumbnail-900x.jpg'),
    ];
    await Future.delayed(const Duration(seconds: 2));

    final nextPageKey = pageKey + newItems.length;
    _pagingController.appendPage(newItems, nextPageKey.toInt());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(delegate: SliverChildListDelegate(
            [
              SizedBox(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 15, top: 30),
                    child: Text('Categories', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.left),
                  ),
                  SizedBox(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 25, top: 25, right: 25),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: index == categories.length-1 ? EdgeInsets.zero : const EdgeInsets.only(right: 40),
                          child: Column(children: [
                            Image.network(categories[index].icon, width: 30, height: 30),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(categories[index].name, style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500), textAlign: TextAlign.center),
                            )
                          ]),
                        );
                      },
                    ),
                    height: 90,
                  )
                ]), 
                height: 180
              )
            ]
          )),
          PagedSliverGrid(
            pagingController: _pagingController, 
            builderDelegate: PagedChildBuilderDelegate<Item>(
              itemBuilder: (context, item, index) {
                if (index % 2 == 0) {
                  return Card(
                    margin: const EdgeInsets.only(left: 15, right: 7.5),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: item.image,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 10),
                          child: Text(item.name, style: const TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 5),
                          child: Text(item.desc, style: const TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.normal)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 10),
                          child: Text("\$${item.price}", style: const TextStyle(color: Color.fromARGB(255, 239, 83, 80), fontSize: 17, fontWeight: FontWeight.bold)),
                        )
                      ]
                    ),
                  );
                } else {
                  return Card(
                    margin: const EdgeInsets.only(left: 7.5, right: 15),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: item.image,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 10),
                          child: Text(item.name, style: const TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 5),
                          child: Text(item.desc, style: const TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.normal)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 10),
                          child: Text("\$${item.price}", style: const TextStyle(color: Color.fromARGB(255, 239, 83, 80), fontSize: 17, fontWeight: FontWeight.bold)),
                        )
                      ]
                    ),
                  );
                }
              },
            ), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 0,
              mainAxisSpacing: 15,
              childAspectRatio: 0.63
            ))
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}