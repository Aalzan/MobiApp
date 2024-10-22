import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:travel_app/screens/splash_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Список товаров
  final List<Map<String, String>> products = [
    {
      "image": "assets/a1.png",
      "name": "Regular",
      "color": "A simple cactus will brighten up your space",
      "price": "\◊ 0,0027"
    },
    {
      "image": "assets/a2.png",
      "name": "Gentelman",
      "color": "A elegant cactus that will brighten up your day",
      "price": "\◊ 0,0027"
    },
    {
      "image": "assets/a3.png",
      "name": "Knight",
      "color": "A bold and vibrant design that show user valor",
      "price": "\◊ 0,0027"
    },
  ];

  // Переменные для выбранного продукта
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.account_balance_wallet_outlined, // Используем иконку кошелька
            color: Colors.white, // Делаем её белой
          ),
          onPressed: () {
            _showWalletDialog(context); // Показываем QR код при нажатии на иконку
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ColorFiltered(
                colorFilter: selectedIndex != -1 // Если элемент выбран, применяем тёмный фильтр
                    ? ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken)
                    : ColorFilter.mode(Colors.transparent, BlendMode.darken),
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(products[selectedIndex]['image']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Cactus",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      products[selectedIndex]['name']!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SplashScreen()),
                    );
                  },
                  backgroundColor: Color(0xFF669966),
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),

          // Список продуктов
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index; // Меняем выбранный продукт
                    });
                  },
                  child: ProductCard(
                    image: products[index]['image']!,
                    name: products[index]['name']!,
                    color: products[index]['color']!,
                    price: products[index]['price']!,
                    isSelected: index == selectedIndex,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Функция для отображения QR-кода для MetaMask
  void _showWalletDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Scan to Connect MetaMask'),
          content: SizedBox(  // Оборачиваем QrImage в SizedBox
            width: 200,
            height: 200,
            child: QrImageView(
              data: "ethereum:0xd648C0E1bb2e2E45684bC06cE2ceBaa5DEb03C92", // Укажи свой Ethereum-адрес
              size: 200.0,
            ),
          ),
          actions: [
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final String image;
  final String name;
  final String color;
  final String price;
  final bool isSelected;

  const ProductCard({
    required this.image,
    required this.name,
    required this.color,
    required this.price,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          // Изображение продукта
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
              border: isSelected
                  ? Border.all(color: Color(0xFF669966), width: 2)
                  : null, // Показать рамку для выбранного товара
            ),
          ),
          SizedBox(width: 16),
          // Детали продукта
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                color,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              Text(
                price,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Splash Screen'),
      ),
    );
  }
}
