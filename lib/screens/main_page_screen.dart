import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:trip/controller/main_page_controller.dart';

class MainPageScreen extends StatefulWidget {
  const MainPageScreen({super.key, required this.title});

  final String title;

  @override
  State<MainPageScreen> createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen> {
  late final MainPageController _controller;
  late final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _counter = 0;
  double _sideBarWidth = 500;
  String _value = "مرکزی";
  bool light1 = false;
  String? days = "کاری";
  List<String?>? vars;

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
  void initState() {
    _controller = Get.put(MainPageController());
    _controller.getListFormModels();

    super.initState();
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

                  ///table
                  DataTable(
                      border: TableBorder.all(),
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => const Color.fromARGB(255, 176, 213, 244)),
                      columns: const [
                        DataColumn(label: Text("test")),
                        DataColumn(label: Text("test")),
                        DataColumn(label: Text("test"))
                      ],
                      rows: const [
                        DataRow(cells: [
                          DataCell(Text("data")),
                          DataCell(Text("data")),
                          DataCell(Text("data"))
                        ]),
                        DataRow(cells: [
                          DataCell(Text("data")),
                          DataCell(Text("data")),
                          DataCell(Text("data"))
                        ])
                      ])
                ],
              ),
            ),
          ),
          AnimatedContainer(
            height: double.infinity,
            width: _sideBarWidth,
            duration: const Duration(milliseconds: 500),
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
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        height: double.infinity,
                        color: Colors.blue[50],
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      DropdownMenu<String>(
                                          onSelected: (value) {
                                            setState(() {
                                              final temp = _controller
                                                  .listFormModel
                                                  ?.singleWhere((element) =>
                                                      element.groupName ==
                                                      value);
                                              if (temp!.independentVariable.any(
                                                  (element) =>
                                                      element == "null")) {
                                                vars = null;
                                              } else {
                                                vars = temp.independentVariable;
                                              }
                                            });
                                          },
                                          // enableFilter: true,
                                          requestFocusOnTap: true,
                                          menuHeight: 300,
                                          enableSearch: true,
                                          label: const Text(
                                            "نوع کاربری",
                                            style: TextStyle(
                                                fontFamily: "VazirMatn"),
                                          ),
                                          // initialSelection: "اداری",
                                          dropdownMenuEntries: _controller
                                              .listFormModel!
                                              .map((e) => e.groupName)
                                              .toList()
                                              .map((e) => DropdownMenuEntry<
                                                      String>(
                                                  style: MenuItemButton.styleFrom(
                                                      textStyle:
                                                          const TextStyle(
                                                              fontFamily:
                                                                  "VazirMatn")),
                                                  value: e,
                                                  label: e))
                                              .toList()),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      if (vars != null)
                                        Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 16),
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Colors.white),
                                          child: Column(
                                            children: vars!
                                                .map((e) => Container(
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 8),
                                                      child: TextFormField(
                                                        textDirection:
                                                            TextDirection.ltr,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .digitsOnly
                                                        ],
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        decoration: InputDecoration(
                                                            border:
                                                                const OutlineInputBorder(),
                                                            label: Text(
                                                                e as String)),
                                                      ),
                                                    ))
                                                .toList(),
                                          ),
                                        ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          const Text(
                                            style: TextStyle(
                                                fontFamily: "VazirMatn"),
                                            'پهنه جغرافیایی:',
                                          ),
                                          SegmentedButton<String>(
                                            segments: [
                                              "مرکزی",
                                              "جنوبی",
                                              "شمالی"
                                            ]
                                                .map((e) =>
                                                    ButtonSegment<String>(
                                                      value: e,
                                                      icon: const Icon(
                                                          Icons.north),
                                                      label: Text(
                                                        e,
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                "VazirMatn"),
                                                      ),
                                                    ))
                                                .toList(),
                                            selected: {_value},
                                            onSelectionChanged: (p0) {
                                              setState(() {
                                                _value = p0.first;
                                              });
                                            },
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          const Text("نوع روز:"),
                                          const SizedBox(
                                            width: 90,
                                          ),
                                          Row(
                                            children: [
                                              Radio<String>(
                                                value: "کاری",
                                                groupValue: days,
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    days = value;
                                                  });
                                                },
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 4.0),
                                                child: InkWell(
                                                    onTap: () => setState(() {
                                                          days = "کاری";
                                                        }),
                                                    child: const Text("کاری")),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Radio<String>(
                                                value: "پنج‌شنبه",
                                                groupValue: days,
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    days = value;
                                                  });
                                                },
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 4.0),
                                                child: InkWell(
                                                    onTap: () => setState(() {
                                                          days = "پنج‌شنبه";
                                                        }),
                                                    child:
                                                        const Text("پنج‌شنبه")),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Checkbox(
                                            value: light1,
                                            onChanged: (value) => setState(() {
                                              light1 = !light1;
                                            }),
                                          ),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () => setState(() {
                                                light1 = !light1;
                                              }),
                                              child: const Padding(
                                                padding:
                                                    EdgeInsets.only(right: 8.0),
                                                child: Text(
                                                  overflow: TextOverflow.fade,
                                                  // softWrap: true,
                                                  "اعمال ضریب اصلاحی موقعیت جغرافیایی و دسترسی به حمل و نقل همگانی",
                                                  maxLines: 2,
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Switch(
                                          //   thumbIcon: MaterialStateProperty
                                          //       .resolveWith<Icon?>(
                                          //     (Set<MaterialState> states) {
                                          //       if (states.contains(
                                          //           MaterialState.selected)) {
                                          //         return const Icon(Icons.check);
                                          //       }
                                          //       return const Icon(Icons.close);
                                          //     },
                                          //   ),
                                          //   value: light1,
                                          //   onChanged: (bool value) {
                                          //     setState(() {
                                          //       light1 = value;
                                          //     });
                                          //   },
                                          // ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        width: double.infinity,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "دسترسی به حمل و نقل همگانی انبوه بر اساس:",
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                              child: TextFormField(
                                                textDirection:
                                                    TextDirection.ltr,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration:
                                                    const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText:
                                                      'فاصله از ایستگاه اتوبوس تندر(متر)',
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                              child: TextFormField(
                                                textDirection:
                                                    TextDirection.ltr,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration:
                                                    const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText:
                                                      'فاصله از ایستگاه مترو (متر)',
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 60,
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          color: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                child: IconButton(
                                    padding: const EdgeInsets.all(8),
                                    color: Colors.red,
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.delete_forever_outlined,
                                      // color: Colors.red,
                                    )),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      fixedSize: const Size(260, 38)),
                                  onPressed: () {},
                                  child: const Text("محاسبه")),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(_controller.listFormModel);
        },
        tooltip: 'خروجی گرفتن',
        child: const Icon(Icons.file_download_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
