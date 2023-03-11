import 'dart:math';

double doubleInRange(Random source, num start, num end) =>
    source.nextDouble() * (end - start) + start;
final random = Random();
final coffees = List.generate(
  names.length,
  (index) => Coffee(
    name: names[index],
    image: 'assets/${index + 1}.png',
    price: doubleInRange(random, 1, 10).toStringAsFixed(2),
  ),
);

class Coffee {
  final String name;
  final String image;
  final String price;

  Coffee({required this.name, required this.image, required this.price});
}

final names = [
  'Caramel Macchiato',
  'Caramel Cold Drink',
  'Iced Coffe Mocha',
  'Caramelized Pecan Latte',
  'Toffee Nut Latte',
  'Capuchino',
  'Toffee Nut Iced Latte',
  'Americano',
  'Vietnamesee Iced Coffee',
  'Black Tea Latte',
  'Classic Irish Coffee',
  'Toffee Nut Crunch Latte',
];
