import 'package:demo/model/catelog.dart';

class CartModel {
  static final cartModel = CartModel._internal();

  CartModel._internal();

  factory CartModel() => cartModel; 

  //catalog field
  late CatalogModel _catalog;

  // collection of ids - store ids of each items
  final List<int> _itemIds = [];

  // get catalog
  CatalogModel get catalog => _catalog;

  set catalog(CatalogModel newCatalog) {
    assert(newCatalog != null);
    _catalog = newCatalog;
  }

  //get item in the cart
  List<Item> get items => _itemIds.map((id) => _catalog.getById(id)).toList();

  //get total price
  num get totalPrice =>
      items.fold(0, (total, current) => total + current.price);

  //Add Item

  void add(Item item) {
    _itemIds.add(item.id);
  }
  //Remove Item

  void remove(Item item) {
    _itemIds.remove(item.id);
  }
}
