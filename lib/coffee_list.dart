import 'package:coffee_shop/coffee.dart';
import 'package:flutter/material.dart';

class CoffeList extends StatefulWidget {
  const CoffeList({super.key});

  @override
  State<CoffeList> createState() => _CoffeListState();
}

class _CoffeListState extends State<CoffeList> {
  final pageCoffeCtrl = PageController(viewportFraction: 0.35, initialPage: 0);
  final pageTextCtrl = PageController(initialPage: 0);
  double currentPage = 0.0;
  double textPage = 0.0;
  final duration = const Duration(milliseconds: 500);

  void _coffeScrollListener() {
    setState(() {
      currentPage = pageCoffeCtrl.page as double;
    });
  }

  void _textScrollListener() {
    textPage = currentPage;
  }

  @override
  void initState() {
    pageCoffeCtrl.addListener(_coffeScrollListener);
    pageTextCtrl.addListener(_textScrollListener);
    super.initState();
  }

  @override
  void dispose() {
    pageCoffeCtrl.removeListener(_coffeScrollListener);
    pageCoffeCtrl.dispose();
    pageTextCtrl.removeListener(_textScrollListener);
    pageTextCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeMediaQ = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(
          color: Colors.brown,
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            left: 20,
            right: 20,
            bottom: -sizeMediaQ.height * 0.15,
            height: sizeMediaQ.width * 0.3,
            child: const DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Colors.brown,
                      blurRadius: 90.0,
                      offset: Offset.zero,
                      spreadRadius: 45),
                ],
              ),
            ),
          ),

          Transform.scale(
            scale: 1.5,
            alignment: Alignment.bottomCenter,
            child: PageView.builder(
              scrollDirection: Axis.vertical,
              controller: pageCoffeCtrl,
              itemCount: coffees.length,
              onPageChanged: (value) {
                if (value < coffees.length - 1) {
                  pageTextCtrl.animateToPage(value,
                      duration: duration, curve: Curves.easeOut);
                }
              },
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const SizedBox.shrink();
                }
                final imgCoffee = coffees[index - 1];
                final result = currentPage - index + 1;
                final value = -0.4 * result + 1;
                final opacity = value.clamp(0.0, 1.0);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: Transform(
                    alignment: Alignment.bottomCenter,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..translate(
                          0.0, sizeMediaQ.height / 2.6 * (1 - value).abs())
                      ..scale(value),
                    child: Opacity(
                      opacity: opacity,
                      child:
                          Image.asset(imgCoffee.image, fit: BoxFit.fitHeight),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            height: 100,
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: pageTextCtrl,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: coffees.length,
                    itemBuilder: (context, index) {
                      final opacity =
                          (1 - (index - textPage).abs()).clamp(0.0, 1.0);
                      return Opacity(
                        opacity: opacity,
                        child: Text(
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          coffees[currentPage.toInt()].name,
                          style: const TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 15.0),
                AnimatedSwitcher(
                  duration: duration,
                  key: Key(coffees[currentPage.toInt()].name),
                  child: Text(
                    '\$ ${coffees[currentPage.toInt()].price}',
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
