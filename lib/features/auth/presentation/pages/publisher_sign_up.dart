// ignore_for_file: unnecessary_string_interpolations
import 'package:afroreads/app/styles/fonts.dart';
import 'package:afroreads/app/view/widget/app_loading_dialog.dart';
import 'package:afroreads/app/view/widget/back_button.dart';
import 'package:afroreads/app/view/widget/busy_button.dart';
import 'package:afroreads/app/view/widget/input_input.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:afroreads/core/navigators/route_name.dart';
import 'package:afroreads/features/auth/presentation/provider/authPro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class PublisherSignUpPage extends StatefulWidget {
  const PublisherSignUpPage({Key? key}) : super(key: key);

  @override
  State<PublisherSignUpPage> createState() => _PublisherSignUpPageeState();
}

class _PublisherSignUpPageeState extends State<PublisherSignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();
  final TextEditingController _securityController = TextEditingController();

  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateOfBirthController.text =
            _selectedDate!.toLocal().toString().split(' ')[0];
      });
    }
  }

  void handlerequest(AuthPro value) async {
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

      await context.read<AuthPro>().publishercreateaccount(
          _firstnameController.text,
          _emailController.text,
          _passwordController.text,
          _dateOfBirthController.text,
          selectedOption,
          _answerController.text);
      Navigator.pop(context);
      if (value.status != '1') {
        SmartDialog.showToast(value.msg);
      } else {
        SmartDialog.showToast(value.msg);
        Navigator.pushNamed(context, RouteName.signUpVerificationPage);
      }
    }
  }

  String? selectedOption;

  // List of options for the dropdown
  List<String> options = [
    'What is the name of your first pet?',
    'What is your favorite book?',
    'What is your favorite food?',
    'In which city were you born?',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AfroReadsColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(20),
                  const AfroReadsBackButton(),
                  const Gap(23),
                  TextBody(
                    'Create Publisher Account',
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                  const Gap(5),
                  TextBody(
                    'We are thrilled to have you here! ',
                    fontSize: 15,
                  ),
                  const Gap(25),
                  TextBody('Full Name', color: AfroReadsColors.textColor),
                  const Gap(8),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(7)),
                    child: TextFormField(
                      controller: _firstnameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This Field is required';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          labelText: 'Obe David Ibidapo',
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
                  TextBody('Email Address', color: AfroReadsColors.textColor),
                  const Gap(8),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(7)),
                    child: TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          labelText: 'Ibidapodavid10@gmail.com',
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
                  TextBody('Password', color: AfroReadsColors.textColor),
                  const Gap(8),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(7)),
                    child: TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This Field is required';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          labelText: '6+ characters',
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
                  TextBody('Confirm Password',
                      color: AfroReadsColors.textColor),
                  const Gap(8),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(7)),
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        if (value == null || value.isEmpty) {
                          return 'This Field is required';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          labelText: '6+ characters',
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
                  TextBody('Date of Birth', color: AfroReadsColors.textColor),
                  const Gap(8),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(7)),
                    child: TextFormField(
                      readOnly: true,
                      controller: _dateOfBirthController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This Field is required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () => _selectDate(context),
                            child: const Icon(
                              Icons.date_range,
                              color: Colors.black,
                            ),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          hintText: 'Select date using the button',
                          labelText: 'DD-MM-YYYY',
                          labelStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400),
                          border: InputBorder.none,
                          fillColor: Colors.black54,
                          focusColor: Colors.black54),
                    ),
                  ),
                  const Gap(16),
                  TextBody('Security Question',
                      color: AfroReadsColors.textColor),
                  const Gap(8),
                  PopupMenuButton<String>(
                    color: AfroReadsColors.white,
                    onSelected: (value) {
                      setState(() {
                        selectedOption = value;
                      });
                    },
                    itemBuilder: (BuildContext context) {
                      return options.map((String option) {
                        return PopupMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList();
                    },
                    child: IgnorePointer(
                      child: InputField(
                        controller: _securityController,
                        placeholder: '${selectedOption ?? "My pet name"}',
                        suffix: const Icon(Icons.keyboard_arrow_down),
                      ),
                    ),
                  ),
                  const Gap(16),
                  TextBody('Answer', color: AfroReadsColors.textColor),
                  const Gap(8),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(7)),
                    child: TextFormField(
                      controller: _answerController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This Field is required';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          labelText: 'Cino',
                          labelStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400),
                          border: InputBorder.none,
                          fillColor: Colors.black54,
                          focusColor: Colors.black54),
                    ),
                  ),
                  const Gap(48),
                  Consumer<AuthPro>(builder: (context, value, child) {
                    return BusyButton(
                      title: 'Create an Account',
                      onTap: () => handlerequest(value),
                    );
                  }),
                  const Gap(30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
