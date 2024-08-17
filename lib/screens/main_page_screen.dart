import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:trip/controller/main_page_controller.dart';
import 'package:trip/models/independent_variable_data_model.dart';

class MainPageScreen extends StatefulWidget {
  const MainPageScreen({super.key, required this.title});

  final String title;

  @override
  State<MainPageScreen> createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen> {
  late final MainPageController _controller;

  final List<TextEditingController> _controllersVars = [];
  final TextEditingController _controllerBrt = TextEditingController();
  final TextEditingController _controllerMetro = TextEditingController();

  double _sideBarWidth = 500;
  String _place = "مرکزی";
  bool calcPlace = false;
  String? days = "کاری";
  List<IndependentVariableDataModel?>? depVars;
  String? groupName;

  // void _incrementCounter() {
  //   setState(() {
  //     // _counter++;
  //   });
  // }

  void _expandSidebar() {
    setState(() {
      _sideBarWidth = _sideBarWidth == 500 ? 40 : 500;
    });
  }

  String? _validateFields() {
    bool anyFieldNotEmpty =
        _controllersVars.any((controller) => controller.text.isNotEmpty);
    if (!anyFieldNotEmpty) {
      return 'حداقل یکی از فیلدها باید پر شود';
    }
    return null;
  }

  void progress() {
    _controller.setSelectedg(days!, groupName!);

    final Map<String, String> form = {};

    for (var i = 0; i < _controllersVars.length; i++) {
      if (depVars![i]!.independentVariableName != null &&
          depVars![i]!.independentVariableName != "Null" &&
          _controllersVars[i].text.trim().isNotEmpty) {}
      form[depVars![i]!.independentVariableName.toString()] =
          _controllersVars[i].text;
    }
    final zarib = _controller.calcZarib(calcPlace, _place,
        bus: double.tryParse(_controllerBrt.text) ?? 0,
        metro: double.tryParse(_controllerBrt.text) ?? 0);
    print(zarib);
    _controller.generalCalc(form, zarib);
  }

  @override
  void initState() {
    _controller = Get.put(MainPageController());
    // _controller.getListFormModels();

    super.initState();
    print(_controller.listGroupModel);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    for (var element in _controllersVars) {
      element.dispose();
    }
    _controllerBrt.dispose();
    _controllerMetro.dispose();
    super.dispose();
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
                          style: TextStyle(
                              fontFamily: "Vazirmatn", color: Colors.grey[800]),
                        ),
                        Image.asset(
                          "assets/images/tehran_uni.png",
                          scale: 4.5,
                        ),
                      ],
                    ),
                  ),
                  GetBuilder<MainPageController>(
                    builder: (controller) {
                      if (!_controller.banner) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(28.0),
                                child: Column(
                                  children: [
                                    DataTable(
                                      dataRowMaxHeight: 30,
                                      dataRowMinHeight: 20,
                                      headingRowHeight: 40,
                                      border: TableBorder.all(),
                                      headingRowColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => const Color.fromARGB(
                                                  255, 192, 218, 239)),
                                      columns: const [
                                        DataColumn(
                                            label: Center(
                                          child: Text(
                                            "نام متغییر",
                                            style: TextStyle(fontSize: 12),
                                            textAlign: TextAlign.center,
                                          ),
                                        )),
                                        DataColumn(
                                            label: Text(
                                          " تعداد سفر ایجاد شده در ساعت اوج(نفر)",
                                          style: TextStyle(fontSize: 12),
                                          textAlign: TextAlign.center,
                                        )),
                                        DataColumn(
                                            label: Center(
                                          child: Text(
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 12),
                                              "اوج تقاضای پارکینگ"),
                                        ))
                                      ],
                                      rows: _controller.result
                                          .map((e) => DataRow(
                                              cells: e
                                                  .map((e) => DataCell(Center(
                                                        child: Text(
                                                          e.toString(),
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 12),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      )))
                                                  .toList()))
                                          .toList(),
                                    ),
                                    const SizedBox(
                                      height: 28,
                                    ),
                                    DataTable(
                                        dataRowMaxHeight: 50,
                                        dataRowMinHeight: 40,
                                        headingRowHeight: 40,
                                        border: TableBorder.all(),
                                        headingRowColor:
                                            MaterialStateColor.resolveWith(
                                                (states) =>
                                                    const Color.fromARGB(
                                                        255, 192, 218, 239)),
                                        columns: _controller.genResult.keys
                                            .map(
                                              (e) => DataColumn(
                                                  label: Center(
                                                child: Text(
                                                  e,
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                  textAlign: TextAlign.center,
                                                ),
                                              )),
                                            )
                                            .toList(),
                                        rows: [
                                          DataRow(
                                              cells: _controller
                                                  .genResult.values
                                                  .map((e) => DataCell(Center(
                                                        child: Text(
                                                          e.toString(),
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 12),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      )))
                                                  .toList())
                                        ]),
                                    const SizedBox(
                                      height: 28,
                                    ),
                                    DataTable(
                                        dataRowMaxHeight: 50,
                                        dataRowMinHeight: 40,
                                        headingRowHeight: 40,
                                        border: TableBorder.all(),
                                        headingRowColor:
                                            MaterialStateColor.resolveWith(
                                                (states) =>
                                                    const Color.fromARGB(
                                                        255, 192, 218, 239)),
                                        columns: _controller.zResalt.keys
                                            .map(
                                              (e) => DataColumn(
                                                  label: Center(
                                                child: Text(
                                                  e,
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                  textAlign: TextAlign.center,
                                                ),
                                              )),
                                            )
                                            .toList(),
                                        rows: [
                                          DataRow(
                                              cells: _controller.zResalt.values
                                                  .map((e) => DataCell(Center(
                                                        child: Text(
                                                          e!.round().toString(),
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 12),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      )))
                                                  .toList())
                                        ]),
                                    const SizedBox(
                                      height: 28,
                                    ),
                                    if (_controller.comment.isNotEmpty)
                                      Text(
                                          "توضیحات: ${_controller.comment["توضیحات"]}")
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const Expanded(
                          child: Center(
                            child: Text(
                              ".برای محاسبه سفرسازی لطفا ابتدا فرم را تکمیل کنید",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                          ),
                        );
                      }
                    },
                  )

                  ///table
                ],
              ),
            ),
          ),
          AnimatedContainer(
            height: double.infinity,
            width: _sideBarWidth,
            duration: const Duration(milliseconds: 150),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
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
                  SizedBox(
                    width: 460,
                    child: Stack(
                      children: [
                        if (_controller.listGroupModel != null)
                          Container(
                            height: double.infinity,
                            color: Colors.blue[50],
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      DropdownMenu<String>(
                                          width: 410,
                                          onSelected: (value) {
                                            setState(() {
                                              _controllersVars.clear();
                                              final temp = _controller
                                                  .listGroupModel
                                                  ?.where((element) =>
                                                      element.groupName ==
                                                      value)
                                                  .toList();
                                              groupName = temp?.first.groupName;
                                              _controller.getDays(groupName!);
                                              days = _controller.te.first;
                                              // if (temp!.independentVariableData.any(
                                              //     (element) =>
                                              //         element == "null")) {
                                              //   vars = null;
                                              // } else {
                                              depVars = temp?.first.groupDayData
                                                  .where((element) =>
                                                      element.days == days)
                                                  .toList()
                                                  .first
                                                  .independentVariableData;

                                              for (var i = 0;
                                                  i < depVars!.length;
                                                  i++) {
                                                _controllersVars.add(
                                                    TextEditingController());
                                              }

                                              // }
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
                                              .listGroupModel!
                                              .map((e) => e.groupName)
                                              .toList()
                                              .map((e) => DropdownMenuEntry<
                                                      String>(
                                                  style: MenuItemButton.styleFrom(
                                                      textStyle:
                                                          const TextStyle(
                                                              fontFamily:
                                                                  "Vazirmatn")),
                                                  value: e,
                                                  label: e))
                                              .toList()),
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
                                                fillColor: MaterialStateProperty
                                                    .resolveWith<Color>(
                                                        (Set<MaterialState>
                                                            states) {
                                                  if (states.contains(
                                                      MaterialState.disabled)) {
                                                    return Colors.blue
                                                        .withOpacity(.32);
                                                  }
                                                  return Colors.blue;
                                                }),
                                                value: "کاری",
                                                groupValue: days,
                                                onChanged: _controller.te
                                                        .contains("کاری")
                                                    ? (String? value) {
                                                        setState(() {
                                                          days = value;
                                                        });
                                                      }
                                                    : null,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 4.0),
                                                child: InkWell(
                                                    onTap: _controller.te
                                                            .contains("کاری")
                                                        ? () => setState(() {
                                                              days = "کاری";
                                                            })
                                                        : null,
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
                                                fillColor: MaterialStateProperty
                                                    .resolveWith<Color>(
                                                        (Set<MaterialState>
                                                            states) {
                                                  if (states.contains(
                                                      MaterialState.disabled)) {
                                                    return Colors.blue
                                                        .withOpacity(.32);
                                                  }
                                                  return Colors.blue;
                                                }),
                                                value: "پنج‌شنبه",
                                                groupValue: days,
                                                onChanged: _controller.te
                                                        .contains("پنج‌شنبه")
                                                    ? (String? value) {
                                                        setState(() {
                                                          days = value;
                                                        });
                                                      }
                                                    : null,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 4.0),
                                                child: InkWell(
                                                    onTap: _controller.te
                                                            .contains(
                                                                "پنج‌شنبه")
                                                        ? () => setState(() {
                                                              days = "پنج‌شنبه";
                                                            })
                                                        : null,
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
                                      if (depVars != null)
                                        Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 16),
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Colors.white),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "یک یا چند متغییر مستقل را تکمیل کنید:",
                                                ),
                                                ...depVars!.indexed
                                                    .map((e) => Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 8),
                                                          child: TextFormField(
                                                            controller:
                                                                _controllersVars[
                                                                    e.$1],
                                                            textDirection:
                                                                TextDirection
                                                                    .ltr,
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter
                                                                  .digitsOnly
                                                            ],
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            decoration: InputDecoration(
                                                                hintStyle: const TextStyle(
                                                                    color: Colors
                                                                        .green,
                                                                    fontSize:
                                                                        13),
                                                                hintText:
                                                                    "برای محاسبه دقیق‌تر در بازه ${e.$2?.minVariable} - ${e.$2?.maxVariable} وارد کنید",
                                                                border:
                                                                    const OutlineInputBorder(),
                                                                label: Text(e.$2
                                                                        ?.independentVariableName
                                                                    as String)),
                                                          ),
                                                        ))
                                                    .toList(),
                                              ]),
                                        ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Checkbox(
                                            value: calcPlace,
                                            onChanged: (value) => setState(() {
                                              calcPlace = !calcPlace;
                                            }),
                                          ),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () => setState(() {
                                                calcPlace = !calcPlace;
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
                                      if (calcPlace)
                                        Column(children: [
                                          const SizedBox(
                                            height: 20,
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
                                                style:
                                                    SegmentedButton.styleFrom(
                                                        selectedBackgroundColor:
                                                            Colors.blue[200]),
                                                segments: [
                                                  {
                                                    "مرکزی",
                                                    Icons.circle_outlined
                                                  },
                                                  {"جنوبی", Icons.south},
                                                  {"شمالی", Icons.north}
                                                ]
                                                    .map((e) =>
                                                        ButtonSegment<String>(
                                                          value:
                                                              e.first as String,
                                                          icon: Icon(e.last
                                                              as IconData),
                                                          label: Text(
                                                            e.first as String,
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    "VazirMatn"),
                                                          ),
                                                        ))
                                                    .toList(),
                                                selected: {_place},
                                                onSelectionChanged: (p0) {
                                                  setState(() {
                                                    _place = p0.first;
                                                  });
                                                },
                                              )
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
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0),
                                                  child: TextFormField(
                                                    controller: _controllerBrt,
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
                                                      border:
                                                          OutlineInputBorder(),
                                                      labelText:
                                                          'فاصله از ایستگاه اتوبوس تندر(متر)',
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0),
                                                  child: TextFormField(
                                                    controller:
                                                        _controllerMetro,
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
                                                      border:
                                                          OutlineInputBorder(),
                                                      labelText:
                                                          'فاصله از ایستگاه مترو (متر)',
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ]),
                                      const SizedBox(
                                        height: 60,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            color: Colors.blue[50],
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GetBuilder<MainPageController>(
                                  builder: (controller) => Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                    child: IconButton(
                                        color: Colors.green,
                                        tooltip: "ذخیره سازی",
                                        onPressed: !_controller.banner
                                            ? () => _controller.saveAsSheet()
                                            : null,
                                        icon: const Icon(
                                          Icons.download,
                                        )),
                                  ),
                                ),
                                // Container(
                                //   decoration: BoxDecoration(
                                //       shape: BoxShape.circle,
                                //       color: Colors.red[400]),
                                //   child: IconButton(
                                //       padding: const EdgeInsets.all(8),
                                //       color: Colors.white,
                                //       onPressed: () {},
                                //       icon: const Icon(
                                //         Icons.delete_forever_outlined,
                                //         size: 20,
                                //       )),
                                // ),

                                const SizedBox(
                                  width: 16,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        fixedSize: const Size(260, 38)),
                                    onPressed: () {
                                      if (_validateFields() == null) {
                                        if (calcPlace) {
                                          if (_controllerBrt.text.isNotEmpty &&
                                              _controllerMetro
                                                  .text.isNotEmpty) {
                                            progress();
                                            print("object");

                                            ///Good
                                          } else {
                                            Get.snackbar(
                                              "خطا",
                                              "لطفا فیلد‌های مربوط به دسترسی به حمل و نقل عمومی را تکمیل کنید",
                                              margin: const EdgeInsets.all(8),
                                              titleText: const Text(
                                                "خطا",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textDirection:
                                                    TextDirection.rtl,
                                              ),
                                              messageText: const Text(
                                                "لطفا فیلد‌های مربوط به دسترسی به حمل و نقل عمومی را تکمیل کنید",
                                                textDirection:
                                                    TextDirection.rtl,
                                              ),
                                              icon: const Icon(
                                                Icons.error,
                                                textDirection:
                                                    TextDirection.rtl,
                                              ),
                                              backgroundColor:
                                                  Colors.red.withOpacity(0.5),
                                            );
                                          }
                                        } else {
                                          ///Good
                                          progress();
                                        }
                                      } else {
                                        Get.snackbar(
                                          "خطا",
                                          "لطفا فیلد‌های مربوط به دسترسی به حمل و نقل عمومی را تکمیل کنید",
                                          margin: const EdgeInsets.all(8),
                                          titleText: const Text(
                                            "خطا",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                            textDirection: TextDirection.rtl,
                                          ),
                                          messageText: const Text(
                                            "لطفا حداقل یکی فیلد‌های مربوط به متغییر‌های مستقل را تکمیل کنید",
                                            textDirection: TextDirection.rtl,
                                          ),
                                          icon: const Icon(
                                            Icons.error,
                                            textDirection: TextDirection.rtl,
                                          ),
                                          backgroundColor:
                                              Colors.red.withOpacity(0.5),
                                        );
                                      }
                                    },
                                    child: const Text(
                                      "محاسبه",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: "Vazirmatn"),
                                    )),
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
          ),
        ],
      ),
    );
  }
}
