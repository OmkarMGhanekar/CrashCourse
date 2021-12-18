import 'package:demo/Pages/home_detail_page.dart';
import 'package:demo/model/cart.dart';
import 'package:demo/model/catelog.dart';
import 'package:demo/widget/home_widget/catalog_image.dart';
import 'package:demo/widget/theme.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CatalogList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: CatalogModel.items.length,
      itemBuilder: (context, index) {
        final catalog = CatalogModel.items[index];
        return InkWell(
            onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeDetailPage(catalog: catalog),
                  ),
                ),
            child: CatalogItem(catalog: catalog));
      },
    );
  }
}

class CatalogItem extends StatelessWidget {
  final Item catalog;
  const CatalogItem({Key? key, required this.catalog})
      : assert(catalog != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return VxBox(
      child: Row(
        children: [
          Hero(
            tag: Key(catalog.id.toString()),
            child: CatalogImage(image: catalog.image),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              catalog.name.text.lg.color(context.accentColor).bold.make(),
              5.heightBox,
              catalog.desc.text
                  .color(MyTheme.darkBluishColor)
                  .caption(context)
                  .make(),
              5.heightBox,
              ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                buttonPadding: EdgeInsets.zero,
                children: [
                  "\$${catalog.price}"
                      .text
                      .bold
                      .color(MyTheme.darkBluishColor)
                      .xl
                      .make(),
                  _AddtoCart(catalog: catalog),
                ],
              ).pOnly(right: 8.0),
            ],
          ))
        ],
      ),
    ).color(context.cardColor).rounded.square(170).make().py8();
  }
}

class _AddtoCart extends StatefulWidget {
  final Item catalog;
  const _AddtoCart({
    Key? key,
    required this.catalog,
  }) : super(key: key);

  @override
  __AddtoCartState createState() => __AddtoCartState();
}

class __AddtoCartState extends State<_AddtoCart> {
  final _cart = CartModel();

  @override
  Widget build(BuildContext context) {
      bool isInCart = _cart.items.contains(widget.catalog)fase;
    return ElevatedButton(
      onPressed: () {
        isInCart = isInCart.toggle();
        final _catalog = CatalogModel();
        _cart.catalog = _catalog;
        _cart.add(widget.catalog);
        setState(() {});
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(context.theme.buttonColor),
          shape: MaterialStateProperty.all(StadiumBorder())),
      child: isInCart ? Icon(Icons.done) : "Add to cart".text.make(),
    );
  }
}
