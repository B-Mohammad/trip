import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'محاسبه سفرسازی کاربرهای شهر تهران'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  double _sideBarWidth = 500;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _expandSidebar() {
    setState(() {
      _sideBarWidth = _sideBarWidth == 500 ? 40 : 500;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: Center(
              child: Column(
                children: <Widget>[
                  AppBar(
                    toolbarHeight: 60,
                    backgroundColor: Colors.blue[200],
                    // Theme.of(context).colorScheme.inversePrimary,
                    centerTitle: true,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/images/tehran_shahrdari.png",
                          scale: 4.5,
                        ),
                        Text(
                          widget.title,
                          style: TextStyle(fontFamily: "Vazirmatn"),
                        ),
                        Image.asset(
                          "assets/images/tehran_uni.png",
                          scale: 4.5,
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
          ),
          AnimatedContainer(
            height: double.infinity,
            width: _sideBarWidth,
            duration: const Duration(milliseconds: 80),
            child: Row(
              children: [
                InkWell(
                  onTap: _expandSidebar,
                  child: Container(
                    width: 40,
                    color: Colors.blue[200],
                    height: double.infinity,
                    child: Icon(
                      _sideBarWidth == 40
                          ? Icons.keyboard_arrow_left_rounded
                          : Icons.keyboard_arrow_right_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'خروجی گرفتن',
        child: const Icon(Icons.share),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
