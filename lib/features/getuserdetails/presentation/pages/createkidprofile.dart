import 'package:afroreads/features/getuserdetails/presentation/provider/UserDetails.dart';
import 'package:afroreads/features/getuserdetails/presentation/widgets/successkidcreate.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../../app/styles/fonts.dart';
import '../../../../app/view/widget/app_loading_dialog.dart';
import '../../../../app/view/widget/back_button.dart';
import '../../../../app/view/widget/busy_button.dart';
import '../../../../core/constants/app_colors.dart';

class Createkidprofile extends StatefulWidget {
  const Createkidprofile({super.key});

  @override
  State<Createkidprofile> createState() => _CreatekidprofileState();
}

class _CreatekidprofileState extends State<Createkidprofile> {
  bool isChecked = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernamecontroller = TextEditingController();
  final TextEditingController _fullnamecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userdetail = context.watch<userdetails>();
    TextEditingController dateController = TextEditingController(
        text:
            '${userdetail.childmonth.toString()} - ${userdetail.childdate.toString()} - ${userdetail.childyear.toString()}');
    print(dateController.text);
    void handlerequest(userdetails value) async {
      if (_formKey.currentState!.validate()) {
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
        await context.read<userdetails>().createkidprofile(
              _fullnamecontroller.text,
              _usernamecontroller.text,
              dateController.text,
            );
        Navigator.pop(context);
        if (value.profilecreated == false) {
          SmartDialog.showToast(value.msg);
        } else {
          // SmartDialog.showToast(value.msg);
          AwesomeDialog(
            context: context,
            headerAnimationLoop: false,
            animType: AnimType.BOTTOMSLIDE,
            dialogType: DialogType.NO_HEADER,
            body: const SuccessKidProfile(),
          ).show();
        }
      }
    }

    return Scaffold(
      backgroundColor: AfroReadsColors.background,
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(20),
                      const AfroReadsBackButton(),
                      const Gap(13),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextBold(
                              "Create Child Profile",
                              fontSize: 20,
                              color: AfroReadsColors.textColor,
                            ),
                          ],
                        ),
                      ),
                      const Gap(30),
                      TextBody('Child Name', color: AfroReadsColors.textColor),
                      const Gap(8),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(7)),
                        child: TextFormField(
                          // controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This Field is required';
                            }
                            return null;
                          },
                          controller: _fullnamecontroller,
                          decoration: const InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              labelText: 'Caleb Oruta',
                              labelStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400),
                              border: InputBorder.none,
                              fillColor: Colors.black54,
                              focusColor: Colors.black54),
                        ),
                      ),
                      const Gap(16),
                      TextBody('User Name', color: AfroReadsColors.textColor),
                      const Gap(8),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(7)),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) {
                            context.read<userdetails>().validateusername(value);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This Field is required';
                            }
                            return null;
                          },
                          controller: _usernamecontroller,
                          decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              labelText: 'CINO',
                              suffixIcon: userdetail.loading == true
                                  ? const Align(
                                      widthFactor: 2,
                                      child: SizedBox(
                                          height: 15,
                                          width: 15,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: AfroReadsColors.primaryColor,
                                          )),
                                    )
                                  : const SizedBox(),
                              labelStyle: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400),
                              border: InputBorder.none,
                              fillColor: Colors.black54,
                              focusColor: Colors.black54),
                        ),
                      ),
                      _usernamecontroller.text.isEmpty
                          ? SizedBox()
                          : userdetail.validated
                              ? Text(
                                  '${_usernamecontroller.text} ${userdetail.msg}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: userdetail.validated
                                          ? Colors.green
                                          : Colors.red),
                                )
                              : userdetail.noterror
                                  ? Text(
                                      '${_usernamecontroller.text} ${userdetail.msg}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: userdetail.validated
                                              ? Colors.green
                                              : Colors.red),
                                    )
                                  : Text(
                                      ' ${userdetail.msg}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: userdetail.validated
                                              ? Colors.green
                                              : Colors.red),
                                    ),
                      const Gap(8),
                      const Gap(16),
                      TextBody('Age', color: AfroReadsColors.textColor),
                      const Gap(8),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(7)),
                        child: InkWell(
                          onTap: () {},
                          child: TextFormField(
                            onTap: () {
                              showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) => CupertinoActionSheet(
                                        title: const Text(
                                          'Select Date Of Birth',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        cancelButton:
                                            CupertinoActionSheetAction(
                                                child: Text(
                                                  'Done',
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColorDark),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);

                                                  dateController.text =
                                                      '${userdetail.childmonth.toString()} - ${userdetail.childdate.toString()} - ${userdetail.childyear.toString()} ';
                                                }),
                                        actions: [
                                          buildpicker2(),
                                        ],
                                      ));
                            },
                            readOnly: true,
                            controller: dateController,
                            decoration: const InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                labelStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400),
                                border: InputBorder.none,
                                fillColor: Colors.black54,
                                focusColor: Colors.black54),
                          ),
                        ),
                      ),
                      const Gap(50),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Consumer<userdetails>(
                              builder: (context, value, child) {
                            return BusyButton(
                                title: "Create Profile",
                                onTap: () async {
                                  handlerequest(value);
                                });
                          })),
                      const Gap(10),
                    ],
                  ),
                ),
              ))),
    );
  }

  SizedBox buildpicker2() {
    return SizedBox(
      height: 200,
      child: CupertinoDatePicker(
        initialDateTime: DateTime(2005, 01, 01),
        mode: CupertinoDatePickerMode.date,
        //initialDateTime: dateTime,
        onDateTimeChanged: (dateTime) {
          context.read<userdetails>().getdate(dateTime);
        },
      ),
    );
  }
}
