import 'package:afroreads/app/view/widget/busy_button.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:afroreads/core/usecases/customesnackbar.dart';

import 'package:afroreads/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../app/view/widget/app_loading_dialog.dart';
import '../provider/UserDetails.dart';
import 'package:group_button/group_button.dart';

class KidUnsuitableGenresModal extends StatefulWidget {
  final ThemeProvider themeProvider;
  String selectedvalue;
  bool restrict;

  KidUnsuitableGenresModal(
      {super.key,
      required this.themeProvider,
      required this.selectedvalue,
      required this.restrict});

  @override
  State<KidUnsuitableGenresModal> createState() =>
      _KidUnsuitableGenresModalState();
}

class _KidUnsuitableGenresModalState extends State<KidUnsuitableGenresModal> {
  List<String> selectedOptions = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedOptions = widget.selectedvalue.split(',');
    print(selectedOptions);
  }

  int? selectedValue;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.40,
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
                "Select unsuitable genres",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(20),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.20,
                child: ListView(
                  //  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CheckboxListTile(
                      activeColor: AfroReadsColors.primaryColor,
                      title: const Text('Violent'),
                      value: widget.selectedvalue.contains('Violent'),
                      onChanged: (value) {
                        setState(() {
                          updateSelectedOptions('Violent', value!);
                        });
                      },
                    ),
                    const Divider(),
                    CheckboxListTile(
                      activeColor: AfroReadsColors.primaryColor,
                      title: const Text('Horror'),
                      value: widget.selectedvalue.contains('Horror'),
                      onChanged: (value) {
                        setState(() {
                          updateSelectedOptions('Horror', value!);
                        });
                      },
                    ),
                    const Divider(),
                    CheckboxListTile(
                      activeColor: AfroReadsColors.primaryColor,
                      title: const Text('Sexual'),
                      value: widget.selectedvalue.contains('Sexual'),
                      onChanged: (value) {
                        setState(() {
                          updateSelectedOptions('Sexual', value!);
                        });
                      },
                    ),
                  ],
                ),
              ),
              const Gap(30),
              Consumer<userdetails>(builder: (context, value, child) {
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
                      await context.read<userdetails>().changeunsuitablegenres(
                          widget.restrict, selectedOptions);

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
              })
            ],
          ),
        ),
      ),
    );
  }

  void updateSelectedOptions(String option, bool selected) {
    if (selected) {
      selectedOptions.add(option);
      for (var i = 0; i < selectedOptions.length; i++) {
        widget.selectedvalue = widget.selectedvalue + ',' + selectedOptions[i];
      }
      print(selectedOptions);
    } else {
      List<String> words = widget.selectedvalue.split(',');
      words.removeWhere((word) => word == option);
      widget.selectedvalue = words.join(',');
      selectedOptions.remove(option);
      print(selectedOptions);
    }
  }
}
