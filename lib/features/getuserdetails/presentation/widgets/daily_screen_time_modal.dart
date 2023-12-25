import 'package:afroreads/app/view/widget/busy_button.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:afroreads/core/usecases/customesnackbar.dart';
import 'package:afroreads/features/getuserdetails/presentation/provider/UserDetails.dart';

import 'package:afroreads/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../app/view/widget/app_loading_dialog.dart';
import '../../domain/entities/parentkidmodel.dart';

class DailyScreenTimeModal extends StatefulWidget {
  final ThemeProvider themeProvider;
  bool customTime;
  List<Time> Weektime;
  int gentime;

  DailyScreenTimeModal(
      {super.key,
      required this.themeProvider,
      required this.customTime,
      required this.Weektime,
      required this.gentime});

  @override
  State<DailyScreenTimeModal> createState() => _DailyScreenTimeModalState();
}

class _DailyScreenTimeModalState extends State<DailyScreenTimeModal> {
  bool isSwitched = false;
  bool isCustomSwitched = false;
  int? selectedValue = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      selectedValue = widget.customTime ? 2 : 1;
      isCustomSwitched = widget.customTime ? true : false;
      isSwitched = widget.customTime ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.52,
      width: double.infinity,
      decoration: BoxDecoration(
        color: widget.themeProvider.themeData.colorScheme.primaryContainer,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Set Caleb’s daily time",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(20),
            SizedBox(
              // height: MediaQuery.of(context).size.height * 0.21,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Set the same limit every day"),
                      Radio(
                          activeColor: AfroReadsColors.primaryColor,
                          value: 1,
                          groupValue: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              isSwitched = false;
                              isCustomSwitched = false;
                              selectedValue = value;
                            });
                          }),
                    ],
                  ),
                  const Divider(),
                  if (!isSwitched)
                    SizedBox(
                      child: Visibility(
                        visible: !isSwitched,
                        maintainSize: false,
                        maintainAnimation: false,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Time"),
                                GestureDetector(
                                  child: Row(
                                    children: [
                                      MyPopupMenuButton(
                                        label: '${widget.gentime}h',
                                        options: const [
                                          '1h',
                                          '2h',
                                          '3h',
                                          '4h',
                                          '5h',
                                          '6h'
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            widget.gentime =
                                                int.parse(value.split('')[0]);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                          ],
                        ),
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Set a custom time limit"),
                      Radio(
                          activeColor: AfroReadsColors.primaryColor,
                          value: 2,
                          groupValue: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              isCustomSwitched = true;
                              isSwitched = true;
                              selectedValue = value;
                            });
                          }),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Visibility(
                visible: isCustomSwitched,
                child: SizedBox(
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          const Divider(),
                          const SizedBox(
                            height: 3,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Monday"),
                              Row(
                                children: [
                                  MyPopupMenuButton(
                                    label: widget.Weektime.isNotEmpty
                                        ? ' ${widget.Weektime[0].monday.toString()}h'
                                        : '2h',
                                    options: const [
                                      '1h',
                                      '2h',
                                      '3h',
                                      '4h',
                                      '5h',
                                      '6h'
                                    ],
                                    onChanged: (value) {
                                      context
                                          .read<userdetails>()
                                          .changeweeklyhours(
                                              0, 'Monday', value);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 3,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Tuesday"),
                              Row(
                                children: [
                                  MyPopupMenuButton(
                                    label: widget.Weektime.isNotEmpty
                                        ? '${widget.Weektime[1].tuesday.toString()}h'
                                        : '2h',
                                    options: const [
                                      '1h',
                                      '2h',
                                      '3h',
                                      '4h',
                                      '5h',
                                      '6h'
                                    ],
                                    onChanged: (value) {
                                      context
                                          .read<userdetails>()
                                          .changeweeklyhours(
                                              1, 'Tuesday', value);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 3,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Wednesday"),
                              Row(
                                children: [
                                  MyPopupMenuButton(
                                    label: widget.Weektime.isNotEmpty
                                        ? '${widget.Weektime[2].wednesday.toString()}h'
                                        : '2h',
                                    options: const [
                                      '1h',
                                      '2h',
                                      '3h',
                                      '4h',
                                      '5h',
                                      '6h'
                                    ],
                                    onChanged: (value) {
                                      context
                                          .read<userdetails>()
                                          .changeweeklyhours(
                                              2, 'Wednesday', value);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Thursday"),
                              Row(
                                children: [
                                  MyPopupMenuButton(
                                    label: widget.Weektime.isNotEmpty
                                        ? '${widget.Weektime[3].thursday.toString()}h'
                                        : '2h',
                                    options: const [
                                      '1h',
                                      '2h',
                                      '3h',
                                      '4h',
                                      '5h',
                                      '6h'
                                    ],
                                    onChanged: (value) {
                                      context
                                          .read<userdetails>()
                                          .changeweeklyhours(
                                              3, 'Thursday', value);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 3,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Friday"),
                              Row(
                                children: [
                                  MyPopupMenuButton(
                                    label: widget.Weektime.isNotEmpty
                                        ? '${widget.Weektime[4].friday.toString()}h'
                                        : '2h',
                                    options: const [
                                      '1h',
                                      '2h',
                                      '3h',
                                      '4h',
                                      '5h',
                                      '6h'
                                    ],
                                    onChanged: (value) {
                                      context
                                          .read<userdetails>()
                                          .changeweeklyhours(
                                              4, 'Friday', value);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 3,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Saturday"),
                              Row(
                                children: [
                                  MyPopupMenuButton(
                                    label: widget.Weektime.isNotEmpty
                                        ? '${widget.Weektime[5].saturday.toString()}h'
                                        : '2h',
                                    options: const [
                                      '1h',
                                      '2h',
                                      '3h',
                                      '4h',
                                      '5h',
                                      '6h'
                                    ],
                                    onChanged: (value) {
                                      context
                                          .read<userdetails>()
                                          .changeweeklyhours(
                                              5, 'Saturday', value);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 3,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Sunday"),
                              Row(
                                children: [
                                  MyPopupMenuButton(
                                    label: widget.Weektime.isNotEmpty
                                        ? '${widget.Weektime[6].sunday.toString()}h'
                                        : '2h',
                                    options: const [
                                      '1h',
                                      '2h',
                                      '3h',
                                      '4h',
                                      '5h',
                                      '6h'
                                    ],
                                    onChanged: (value) {
                                      context
                                          .read<userdetails>()
                                          .changeweeklyhours(
                                              6, 'Sunday', value);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Consumer<userdetails>(builder: (context, value, child) {
                return BusyButton(
                    title: "Done",
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const AppLoadingDialog(
                                text: 'Loading...',
                              ),
                            );
                          });
                      await context
                          .read<userdetails>()
                          .changeCustomTime(isCustomSwitched, widget.gentime);

                      if (value.restricterror == true) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          dismissDirection: DismissDirection.up,
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height - 200),
                          content: CustomeSnackbar(
                            topic: 'Oh Snap!',
                            msg: value.msg,
                            color1: Color.fromARGB(255, 171, 51, 42),
                            color2: Color.fromARGB(255, 127, 39, 33),
                          ),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ));
                      } else if (value.restricterror == false) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          dismissDirection: DismissDirection.up,
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height - 200),
                          content: CustomeSnackbar(
                            topic: 'Great!',
                            msg: value.msg,
                            color1: Color.fromARGB(255, 25, 107, 52),
                            color2: Color.fromARGB(255, 19, 95, 40),
                          ),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ));

                        // ignore: use_build_context_synchronously
                      }
                      Navigator.of(context).pop();
                    });
              }),
            )
          ],
        ),
      ),
    );
  }
}

class MyPopupMenuButton extends StatefulWidget {
  final String label;
  final List<String> options;
  final void Function(String) onChanged;

  MyPopupMenuButton({
    required this.label,
    required this.options,
    required this.onChanged,
  });

  @override
  _MyPopupMenuButtonState createState() => _MyPopupMenuButtonState();
}

class _MyPopupMenuButtonState extends State<MyPopupMenuButton> {
  String selectedOption = '';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(selectedOption.isEmpty ? widget.label : ''),
        Text(selectedOption),
        PopupMenuButton<String>(
          icon: const Icon(
            Icons.keyboard_arrow_right,
            color: Colors.grey,
          ),
          onSelected: (value) {
            setState(() {
              selectedOption = value;
            });
            widget.onChanged(value);
          },
          itemBuilder: (BuildContext context) {
            return widget.options.map((String item) {
              return PopupMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList();
          },
        ),
      ],
    );
  }
}
