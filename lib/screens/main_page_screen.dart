import 'package:flutter/material.dart';

class MainPageScreen extends StatefulWidget {
  const MainPageScreen({super.key, required this.title});

  final String title;

  @override
  State<MainPageScreen> createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen> {
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
                          style: const TextStyle(fontFamily: "Vazirmatn"),
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
        child: const Icon(Icons.file_download_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
