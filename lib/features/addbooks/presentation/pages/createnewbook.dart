import 'dart:io';

import 'package:afroreads/app/view/widget/busy_button.dart';
import 'package:afroreads/core/constants/app_assets.dart';
import 'package:afroreads/core/navigators/route_name.dart';
import 'package:afroreads/features/addbooks/presentation/pages/viewbook.dart';
import 'package:afroreads/features/addbooks/presentation/provider/uploadimageprovider.dart';
import 'package:afroreads/features/addbooks/presentation/widgets/select_age.dart';
import 'package:afroreads/features/getbooks/presentation/provider/GetbooksPro.dart';
import 'package:afroreads/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../../app/styles/fonts.dart';
import '../../../../app/view/widget/app_loading_dialog.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/usecases/customesnackbar.dart';
import '../widgets/viewimage.dart';

class createbook extends StatefulWidget {
  const createbook({super.key});

  @override
  State<createbook> createState() => _createbookState();
}

class _createbookState extends State<createbook> {
  List items = ['Fiction', 'Non-Fiction', 'History', 'Folktales', 'Lifestyle'];
  List age = ['Below age 8', 'Age 9-13', 'Age 14 -16'];
  final TextEditingController booktitlecontroller = TextEditingController();
  final TextEditingController authorcontroller = TextEditingController();
  final TextEditingController descriptioncontroller = TextEditingController();
  final TextEditingController addedbycontroller = TextEditingController();
  List selecteditems = [];
  String selectedGenre = '';
  int? selectedValue;
  late StateSetter _setState;
  late StateSetter _setState1;
  void updateSelectedOptions(String option, bool selected) {
    if (selected) {
      selecteditems.add(option);
      for (var i = 0; i < selecteditems.length; i++) {
        selectedGenre = selectedGenre + ',' + selecteditems[i];
      }
      print(selecteditems);
    } else {
      List<String> words = selectedGenre.split(',');
      words.removeWhere((word) => word == option);
      selectedGenre = words.join(',');
      selecteditems.remove(option);
      print(selecteditems);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final uploadprovider = context.watch<uploadimageprovider>();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Upload Image and Book',
          style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: 30, horizontal: MediaQuery.of(context).size.width * .1),
        child: ListView(children: [
          TextBody('Book Title', color: AfroReadsColors.textColor),
          const Gap(8),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(7)),
            child: TextFormField(
              controller: booktitlecontroller,
              // validator: (value) {
              //   if (value != _passwordController.text) {
              //     return 'Passwords do not match';
              //   }
              //   if (value == null || value.isEmpty) {
              //     return 'This Field is required';
              //   }
              //   return null;
              // },
              decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: 'Things Fall Apart',
                  labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400),
                  border: InputBorder.none,
                  fillColor: Colors.black54,
                  focusColor: Colors.black54),
            ),
          ),
          Gap(20),
          TextBody('Author', color: AfroReadsColors.textColor),
          const Gap(8),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(7)),
            child: TextFormField(
              controller: authorcontroller,
              // validator: (value) {
              //   if (value != _passwordController.text) {
              //     return 'Passwords do not match';
              //   }
              //   if (value == null || value.isEmpty) {
              //     return 'This Field is required';
              //   }
              //   return null;
              // },
              decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: 'Chinua Achuebe',
                  labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400),
                  border: InputBorder.none,
                  fillColor: Colors.black54,
                  focusColor: Colors.black54),
            ),
          ),
          Gap(20),
          TextBody('Description', color: AfroReadsColors.textColor),
          const Gap(8),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 160,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(7)),
            child: TextFormField(
              controller: descriptioncontroller,
              maxLines: 10,
              decoration: const InputDecoration(

                  // isDense: true,
                  // contentPadding: EdgeInsets.fromLTRB(10, 50, 10, 10),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: 'Write  short description of your book here',
                  labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400),
                  border: InputBorder.none,
                  fillColor: Colors.black54,
                  focusColor: Colors.black54),
            ),
          ),
          Gap(20),
          TextBody('Genre', color: AfroReadsColors.textColor),
          const Gap(8),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                isDismissible: false,
                context: context,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                builder: (context) {
                  return StatefulBuilder(
                      builder: (context, StateSetter setstate) {
                    _setState1 = setstate;
                    return SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Select genres",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Gap(20),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.20,
                                child: ListView(
                                  //  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CheckboxListTile(
                                      activeColor: AfroReadsColors.primaryColor,
                                      title: const Text('Violent'),
                                      value: selecteditems.contains('Violent'),
                                      onChanged: (value) {
                                        setState(() {
                                          updateSelectedOptions(
                                              'Violent', value!);
                                        });
                                        _setState1(
                                          () {},
                                        );
                                      },
                                    ),
                                    const Divider(),
                                    CheckboxListTile(
                                      activeColor: AfroReadsColors.primaryColor,
                                      title: const Text('Horror'),
                                      value: selecteditems.contains('Horror'),
                                      onChanged: (value) {
                                        setState(() {
                                          updateSelectedOptions(
                                              'Horror', value!);
                                        });
                                        _setState1(
                                          () {},
                                        );
                                      },
                                    ),
                                    const Divider(),
                                    CheckboxListTile(
                                      activeColor: AfroReadsColors.primaryColor,
                                      title: const Text('Sexual'),
                                      value: selecteditems.contains('Sexual'),
                                      onChanged: (value) {
                                        setState(() {
                                          updateSelectedOptions(
                                              'Sexual', value!);
                                        });
                                        _setState1(
                                          () {},
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const Gap(30),
                              BusyButton(
                                  title: "Done",
                                  onTap: () async {
                                    Navigator.of(context).pop();
                                  })
                            ],
                          ),
                        ),
                      ),
                    );
                  });
                },
              );
            },
            child: Container(
                height: 60,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: Color.fromARGB(255, 219, 219, 219)),
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      items[context.watch<uploadimageprovider>().group],
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                )),
          ),
          Gap(20),
          TextBody('Book Appropraite Age', color: AfroReadsColors.textColor),
          const Gap(8),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                        builder: (context, StateSetter setstate) {
                      _setState = setstate;
                      return SingleChildScrollView(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.45,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Select Appropraite age For this book",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Gap(20),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.21,
                                  child: ListView(
                                    //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text("Below age 8"),
                                          Radio(
                                              activeColor:
                                                  AfroReadsColors.primaryColor,
                                              value: 1,
                                              groupValue: selectedValue,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedValue = value;
                                                });
                                                _setState(() {});
                                              }),
                                        ],
                                      ),
                                      const Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text("Age  9 - 13"),
                                          Radio(
                                              activeColor:
                                                  AfroReadsColors.primaryColor,
                                              value: 2,
                                              groupValue: selectedValue,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedValue = value;
                                                });
                                                _setState(() {});
                                              }),
                                        ],
                                      ),
                                      const Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text("Age 13 - 16"),
                                          Radio(
                                              activeColor:
                                                  AfroReadsColors.primaryColor,
                                              value: 3,
                                              groupValue: selectedValue,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedValue = value;
                                                });
                                                _setState(() {});
                                              }),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Gap(30),
                                SafeArea(
                                  child: BusyButton(
                                      title: "Done",
                                      onTap: () {
                                        context
                                            .read<uploadimageprovider>()
                                            .collectbookage(selectedValue);
                                        Navigator.of(context).pop();
                                      }),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
                  });
            },
            child: Container(
                height: 60,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: Color.fromARGB(255, 219, 219, 219)),
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      context.watch<uploadimageprovider>().bookage,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                )),
          ),
          Gap(20),
          InkWell(
            onTap: () {
              uploadprovider.image == null
                  ? uploadprovider.pickimage()
                  : showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      context: context,
                      builder: (context) {
                        return ViewImage(
                          image: uploadprovider.image!,
                        );
                      });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: UseCaseUpload(
                title:
                    uploadprovider.image == null ? 'Add Image' : 'View Image',
                icon: AppAssets.imagelook,
                iconcolor: Colors.green,
                file: uploadprovider.image,
              ),
            ),
          ),
          Gap(30),
          InkWell(
            // onTap: () {
            //   uploadprovider.book == null
            //       ? uploadprovider.pickfile()
            //       : Navigator.push(context, MaterialPageRoute(
            //           builder: (context) {
            //             return ViewBook(path: uploadprovider.book!);
            //           },
            //         ));
            //   if (uploadprovider.errorbook == true) {
            //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //       content: CustomeSnackbar(
            //         topic: 'Oh Snap!',
            //         msg: uploadprovider.es,
            //         color1: Color.fromARGB(255, 171, 51, 42),
            //         color2: Color.fromARGB(255, 127, 39, 33),
            //       ),
            //       behavior: SnackBarBehavior.floating,
            //       backgroundColor: Colors.transparent,
            //       elevation: 0,
            //     ));
            //   }
            // },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: UseCaseUpload(
                title: uploadprovider.book == null ? 'Add Book' : 'View Book',
                icon: AppAssets.filelook,
                iconcolor: Colors.red,
                file: uploadprovider.book,
              ),
            ),
          ),
          Gap(30),
          Consumer<uploadimageprovider>(builder: (context, value, child) {
            return BusyButton(
                title: 'Upload',
                onTap: () async {
                  if (value.loading == true) {
                    return;
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          final uploadmatrix = Provider.of<uploadimageprovider>(
                              context,
                              listen: true);
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: AppLoadingDialog(
                              text: uploadmatrix.uploadingimage
                                  ? 'Uploading Image...'
                                  : uploadmatrix.uploadingbook
                                      ? 'Uploading Book...'
                                      : 'Sending to database...',
                            ),
                          );
                        });
                    await context.read<uploadimageprovider>().sendrequest(
                        booktitlecontroller.text,
                        authorcontroller.text,
                        descriptioncontroller.text,
                        selecteditems,
                        addedbycontroller.text);
                    Navigator.pop(context);
                    if (value.uploaderror == true) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
                    } else {
                      context.read<GetbookPro>().getbook();
                      Navigator.pushNamedAndRemoveUntil(context,
                          RouteName.indexPage, (Route<dynamic> route) => false);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
                    }
                  }
                });
          })
        ]),
      ),
    );
  }

  Container picknetwork(BuildContext context, int index) {
    final isSeleted = this.context.watch<uploadimageprovider>().index == index;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: isSeleted
              ? Border.all(color: Color.fromARGB(255, 219, 219, 219), width: 1)
              : Border.all(
                  color: Color.fromARGB(255, 219, 219, 219),
                )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${items[index]}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Radio(
            value: index,
            activeColor: Theme.of(context).primaryColorDark,
            groupValue: context.watch<uploadimageprovider>().group,
            onChanged: (value) {
              context.read<uploadimageprovider>().showindex(value);
            },
          ),
        ],
      ),
    );
  }
}

class UseCaseUpload extends StatelessWidget {
  const UseCaseUpload({
    super.key,
    required this.title,
    required this.icon,
    required this.iconcolor,
    required this.file,
  });
  final String title;
  final String icon;
  final Color iconcolor;
  final File? file;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      height: 55,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              icon,
              color: iconcolor,
            ),
            Text(
              title,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            file == null
                ? SizedBox()
                : InkWell(
                    onTap: () {
                      title.contains('Book')
                          ? context.read<uploadimageprovider>().deletebook()
                          : context.read<uploadimageprovider>().deleteimage();
                    },
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
