import 'package:ecommerce_demo/models/product_model.dart';
import 'package:ecommerce_demo/providers/addtocart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final Products dproduct;

  ProductDetailScreen({super.key, required this.dproduct});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.dproduct.title}'),
      ),
      body: Column(
        children: [
          Expanded(
            // Allow the content to take up available space
            child: SingleChildScrollView(
              // Make the content scrollable
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 300,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: widget.dproduct.images!.length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            widget.dproduct.images![index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(widget.dproduct.images!.length,
                          (index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentPage == index ? 12 : 5,
                          height: _currentPage == index ? 12 : 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPage == index
                                ? Colors.blueAccent
                                : Colors.grey,
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.dproduct.title!,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '\$${widget.dproduct.price.toString()}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.dproduct.description!,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Reviews',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: widget.dproduct.reviews!.map((reviews) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                children: List.generate(5, (index) {
                                  return Icon(
                                    Icons.star,
                                    color: index < reviews.rating!
                                        ? Colors.green
                                        : Colors.grey,
                                  );
                                }),
                              ),
                            );
                          }).toList(),
                        ),
                        Text(
                          '${widget.dproduct.rating.toString()}',
                          style: TextStyle(
                              fontSize: 42,
                              color: widget.dproduct.rating! >= 3.5
                                  ? Colors.green
                                  : Colors.red),
                        ),
                      ],
                    ),
                    SizedBox(height: 20), // Add spacing before the button

                    Center(
                      child: TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    height: double.infinity,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 10,),
                                        Text(
                                          'Reviews',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                    SizedBox(height: 10),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount:
                                        widget.dproduct.reviews!.length,
                                        itemBuilder: (context, index) {
                                          final review =
                                          widget.dproduct.reviews![index];
                                          return ListTile(
                                            leading: Text((index + 1).toString()),
                                            title: Text(review.comment!),
                                            subtitle: Text(review.reviewerName!),
                                          );
                                        },
                                      ),
                                    ),
                                      ],
                                    )
                                  );
                                });
                          },
                          child: Text(
                            'Click here to see Reviews',
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.transparent),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  final cartProvider = Provider.of<AddToCartProvider>(context, listen: false);

                  cartProvider.addToCart(widget.dproduct);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Product added to cart')),
                  );

                },
                child:
                    Text('Add To Cart', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.blueAccent),
                  ),
                  backgroundColor: Colors.blueAccent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
