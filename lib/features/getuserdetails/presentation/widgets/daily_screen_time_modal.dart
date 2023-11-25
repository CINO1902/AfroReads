import 'package:afroreads/app/view/widget/busy_button.dart';
import 'package:afroreads/core/constants/app_colors.dart';

import 'package:afroreads/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DailyScreenTimeModal extends StatefulWidget {
  final ThemeProvider themeProvider;

  const DailyScreenTimeModal({super.key, required this.themeProvider});

  @override
  State<DailyScreenTimeModal> createState() => _DailyScreenTimeModalState();
}

class _DailyScreenTimeModalState extends State<DailyScreenTimeModal> {
 
  bool isSwitched = false;
  bool isCustomSwitched = false;
  int? selectedValue = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.52,
      width: double.infinity,
      decoration: BoxDecoration(
        color: widget.themeProvider.themeData.primaryColor,
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
                                        label: '2h',
                                        options: const ['1h', '2h', '3h', '4h', '5h', '6h'],
                                        onChanged: (value) {},
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
                                        label: '2h',
                                        options: const ['1h', '2h', '3h', '4h', '5h', '6h'],
                                        onChanged: (value) {},
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
                                        label: '2h',
                                        options: const ['1h', '2h', '3h', '4h', '5h', '6h'],
                                        onChanged: (value) {},
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
                                        label: '2h',
                                        options: const ['1h', '2h', '3h', '4h', '5h', '6h'],
                                        onChanged: (value) {},
                                      ),
                                ],
                              ),
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Thursady"),
                              Row(
                                children: [
                                   MyPopupMenuButton(
                                        label: '2h',
                                        options: const ['1h', '2h', '3h', '4h', '5h', '6h'],
                                        onChanged: (value) {},
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
                                        label: '2h',
                                        options: const ['1h', '2h', '3h', '4h', '5h', '6h'],
                                        onChanged: (value) {},
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
                                        label: '2h',
                                        options: const ['1h', '2h', '3h', '4h', '5h', '6h'],
                                        onChanged: (value) {},
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
                                        label: '2h',
                                        options: const ['1h', '2h', '3h', '4h', '5h', '6h'],
                                        onChanged: (value) {},
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
              child: BusyButton(
                  title: "Done",
                  onTap: () {
                    Navigator.of(context).pop();
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
