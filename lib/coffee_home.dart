import 'package:coffee_shop/coffee.dart';
import 'package:coffee_shop/coffee_list.dart';
import 'package:flutter/material.dart';

class CoffeeHome extends StatelessWidget {
  const CoffeeHome({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeMediaQ = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.primaryDelta! < -20) {
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 300),
                pageBuilder: (context, animation, _) {
                  return FadeTransition(
                    opacity: animation,
                    child: const CoffeList(),
                  );
                },
              ),
            );
          }
        },
        child: Stack(
          children: [
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFA89276),
                      Color(0xFFE0E0E0),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              height: sizeMediaQ.height * 0.4,
              left: 0,
              right: 0,
              top: sizeMediaQ.height * 0.15,
              child: Hero(
                tag: '7',
                child: Image.asset(coffees[6].image),
              ),
            ),
            Positioned(
              height: sizeMediaQ.height * 0.7,
              left: 0,
              right: 0,
              bottom: 0,
              child: Hero(
                tag: '8',
                child: Image.asset(coffees[7].image, fit: BoxFit.cover),
              ),
            ),
            Positioned(
              height: sizeMediaQ.height,
              left: 0,
              right: 0,
              bottom: -sizeMediaQ.height * 0.8,
              child: Hero(
                tag: '9',
                child: Image.asset(coffees[0].image, fit: BoxFit.cover),
              ),
            ),
            Positioned(
              height: 140,
              left: 0,
              right: 0,
              bottom: sizeMediaQ.height * 0.25,
              child: Image.asset('assets/logo.png'),
            ),
          ],
        ),
      ),
    );
  }
}
