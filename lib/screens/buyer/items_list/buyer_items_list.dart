import 'package:ecommerceapp/models/cartList.dart';
import 'package:ecommerceapp/models/cartItem.dart';
import 'package:ecommerceapp/models/item.dart';
import 'package:ecommerceapp/models/category.dart';
import 'dart:convert';
import 'package:ecommerceapp/utils/network_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../models/auth.dart';
import '../../../models/user.dart';
import '../../login.dart';

class BuyerItemsList extends StatefulWidget {
  const BuyerItemsList({Key? key}) : super(key: key);

  @override
  _BuyerItemsListState createState() => _BuyerItemsListState();
}

class _BuyerItemsListState extends State<BuyerItemsList> {
  int currentPage = 0;
  bool isLoading = false;
  bool _isFetchingMore = false;

  List<ItemCategory> _categories = [];

  final PagingController<int, Item> _pagingController =
      PagingController(firstPageKey: 0);

  Future<List<ItemCategory>> fetchCategories(http.Client client) async {
    final response =
        await client.get(Uri.parse(NetworkConfig.API_BASE_URL + 'category/'));

    return compute(parseCategories, response.body);
  }

  Future<List<ItemCategory>> parseCategories(String responseBody) async {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<ItemCategory> items = parsed
        .map<ItemCategory>((json) => ItemCategory.fromJson(json))
        .toList();

    return items;
  }

  Future<List<Item>> fetchItems(http.Client client) async {
    final response =
        await client.get(Uri.parse(NetworkConfig.API_BASE_URL + 'item/'));

    return compute(parseItems, response.body);
  }

  Future<List<Item>> fetchItemsByCategory(
      http.Client client, int categoryId) async {
    final response = await client.get(Uri.parse(
        NetworkConfig.API_BASE_URL + 'item/category/' + categoryId.toString()));

    return compute(parseItems, response.body);
  }

  Future<List<Item>> parseItems(String responseBody) async {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<Item> items = parsed.map<Item>((json) => Item.fromJson(json)).toList();

    return items;
  }

  @override
  void initState() {
    super.initState();
  }

  Future _loadData(int pageKey) async {
    if (!_isFetchingMore) {
      if (kDebugMode) {
        print("_loadData");
      }
      _isFetchingMore = true;
      fetchItems(http.Client()).then((itmes) {
        final nextPageKey = pageKey + itmes.length;
        _pagingController.appendPage(itmes, nextPageKey.toInt());
        _isFetchingMore = false;
      });
    }
  }

  void showItemDetail(BuildContext context, Item item, CartList cartList) {
    var alertStyle = const AlertStyle(
      animationType: AnimationType.grow,
      isCloseButton: false,
    );

    Alert(
            context: context,
            content:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: item.image,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 10),
                child: Text(item.name,
                    style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 5),
                child: Text(item.desc,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.normal)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
                child: Row(
                  children: [
                    Text("\$${item.price}",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 239, 83, 80),
                            fontSize: 17,
                            fontWeight: FontWeight.bold)),
                    const Spacer(),
                    IconButton(
                        key: Key("item_detail_add_to_cart_button_${item.id}"),
                        onPressed: () {
                          // if (user == null) {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const MyLoginPage()),
                          //   ).then((value) {});
                          //   return;
                          // }
                          cartList.add(CartItem(
                            id: item.id.toString(),
                            name: item.name,
                            itemPrice: item.price.toDouble(),
                            image: item.image,
                            quantity: 1,
                          ));
                          Fluttertoast.showToast(
                              msg: 'Added to cart successfully');
                        },
                        icon: const Icon(Icons.add_shopping_cart))
                  ],
                ),
              )
            ]),
            style: alertStyle)
        .show();
  }

  @override
  Widget build(BuildContext context) {
    // User? user = Provider.of<AuthModel>(context).getCurrentUser();

    final category =
        ModalRoute.of(context)!.settings.arguments as ItemCategory?;

    if (category != null) {
      // category page
      fetchItemsByCategory(http.Client(), category.id)
          .then((items) => _pagingController.appendLastPage(items));
    } else {
      if (_categories.isEmpty) {
        fetchCategories(http.Client()).then((categories) {
          setState(() {
            _categories = categories;
          });
        });
        _pagingController.addPageRequestListener((pageKey) {
          _loadData(pageKey);
        });
        fetchItems(http.Client())
            .then((items) => _pagingController.appendPage(items, 0));
      }
    }
    var screenSize = MediaQuery.of(context).size;

    return Consumer<CartList>(builder: (context, cartList, _) {
      return Scaffold(
          appBar: category != null
              ? AppBar(
                  title: const Text(
                    'Category',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white)
              : null,
          body: Center(
              child: Container(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                    key: const Key('buyer_items_list'),
                    delegate: SliverChildListDelegate([
                      SizedBox(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                category != null
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, top: 30),
                                        child: Text(category.name,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.left),
                                      )
                                    : const Padding(
                                        padding:
                                            EdgeInsets.only(left: 15, top: 30),
                                        child: Text('Categories',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.left),
                                      ),
                                category != null
                                    ? const SizedBox(height: 0)
                                    : SizedBox(
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          padding: const EdgeInsets.only(
                                              left: 25, top: 25, right: 25),
                                          itemCount: _categories.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: (() {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const BuyerItemsList(),
                                                    settings: RouteSettings(
                                                      arguments:
                                                          _categories[index],
                                                    ),
                                                  ),
                                                );
                                              }),
                                              child: Padding(
                                                padding: index ==
                                                        _categories.length - 1
                                                    ? EdgeInsets.zero
                                                    : const EdgeInsets.only(
                                                        right: 40),
                                                child: Column(children: [
                                                  Image.network(
                                                      _categories[index].icon,
                                                      width: 30,
                                                      height: 30),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: Text(
                                                        _categories[index].name,
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                        textAlign:
                                                            TextAlign.center),
                                                  )
                                                ]),
                                              ),
                                            );
                                          },
                                        ),
                                        height: 90,
                                      )
                              ]),
                          height: category != null ? 90 : 180)
                    ])),
                PagedSliverGrid(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<Item>(
                      itemBuilder: (context, item, index) {
                        if (index % 2 == 0) {
                          return GestureDetector(
                            onTap: (() {
                              showItemDetail(context, item, cartList);
                            }),
                            child: Card(
                              margin:
                                  const EdgeInsets.only(left: 15, right: 7.5),
                              color: Colors.white,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FadeInImage.memoryNetwork(
                                      placeholder: kTransparentImage,
                                      image: item.image,
                                      width: (screenSize.width - 45) / 2,
                                      fit: BoxFit.cover,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, top: 10),
                                      child: Text(item.name,
                                          style: const TextStyle(
                                              color: Colors.black87,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, top: 5),
                                      child: Text(item.desc,
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, top: 10, right: 15),
                                      child: Row(
                                        children: [
                                          Text("\$${item.price}",
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 239, 83, 80),
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold)),
                                          const Spacer(),
                                          IconButton(
                                              key: Key(
                                                  "home_add_to_cart_button_${item.id}"),
                                              onPressed: () {
                                                // if (user == null) {
                                                //   Navigator.push(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //         builder: (context) =>
                                                //             const MyLoginPage()),
                                                //   ).then((value) {});
                                                //   return;
                                                // }
                                                cartList.add(CartItem(
                                                  id: item.id.toString(),
                                                  name: item.name,
                                                  itemPrice:
                                                      item.price.toDouble(),
                                                  image: item.image,
                                                  quantity: 1,
                                                ));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: const Text(
                                                        'Added to cart successfully'),
                                                    action: SnackBarAction(
                                                      label: '',
                                                      onPressed: () {
                                                        // Code to execute.
                                                      },
                                                    ),
                                                  ),
                                                );
                                              },
                                              icon: const Icon(
                                                  Icons.add_shopping_cart))
                                        ],
                                      ),
                                    )
                                  ]),
                            ),
                          );
                        } else {
                          return GestureDetector(
                            onTap: (() {
                              showItemDetail(context, item, cartList);
                            }),
                            child: Card(
                              margin:
                                  const EdgeInsets.only(left: 7.5, right: 15),
                              color: Colors.white,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FadeInImage.memoryNetwork(
                                      placeholder: kTransparentImage,
                                      image: item.image,
                                      width: (screenSize.width - 45) / 2,
                                      fit: BoxFit.cover,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, top: 10),
                                      child: Text(item.name,
                                          style: const TextStyle(
                                              color: Colors.black87,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, top: 5),
                                      child: Text(item.desc,
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, top: 10, right: 15),
                                      child: Row(
                                        children: [
                                          Text("\$${item.price}",
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 239, 83, 80),
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold)),
                                          const Spacer(),
                                          IconButton(
                                              onPressed: () {
                                                // if (user == null) {
                                                //   Navigator.push(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //         builder: (context) =>
                                                //             const MyLoginPage()),
                                                //   ).then((value) {});
                                                //   return;
                                                // }
                                                cartList.add(CartItem(
                                                  id: item.id.toString(),
                                                  name: item.name,
                                                  itemPrice:
                                                      item.price.toDouble(),
                                                  image: item.image,
                                                  quantity: 1,
                                                ));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: const Text(
                                                        'Added to cart successfully'),
                                                    action: SnackBarAction(
                                                      label: '',
                                                      onPressed: () {
                                                        // Code to execute.
                                                      },
                                                    ),
                                                  ),
                                                );
                                              },
                                              icon: const Icon(
                                                  Icons.add_shopping_cart))
                                        ],
                                      ),
                                    )
                                  ]),
                            ),
                          );
                        }
                      },
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 15,
                            childAspectRatio: 0.63))
              ],
            ),
          )));
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
