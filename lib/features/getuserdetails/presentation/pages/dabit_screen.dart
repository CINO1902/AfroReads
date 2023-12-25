// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'package:afroreads/app/styles/fonts.dart';
import 'package:afroreads/app/view/widget/back_button.dart';
import 'package:afroreads/app/view/widget/busy_button.dart';
import 'package:afroreads/core/constants/app_assets.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class DebitCardScreen extends StatefulWidget {
  const DebitCardScreen({super.key});

  @override
  State<DebitCardScreen> createState() => _DebitCardScreenState();
}

class _DebitCardScreenState extends State<DebitCardScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDATEController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  bool isMaterCard = false;
  bool isverveCard = false;
  bool showLabel = false;
  bool expiryDateFocus = false;
  bool cvvFocus = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const AfroReadsBackButton(),
                    TextSemiBold(
                      'Payment Method',
                      fontSize: 18,
                      color: AfroReadsColors.darkBackground,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                const Gap(47),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextBody(
                          'Almost there',
                          color: AfroReadsColors.darkBackground,
                          fontSize: 32,
                        ),
                        const Gap(8),
                        TextBody(
                          'Add your debit card',
                          fontSize: 18,
                          color: AfroReadsColors.darkBackground,
                        ),
                        const Gap(20),
                        Container(
                            height: 52,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: AfroReadsColors.grey,)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: cardNumberController,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        CardNumberFormatter(),
                                      ],
                                      onTap: () {
                                        setState(() {
                                          showLabel = true;
                                        });
                                      },
                                      maxLength: 19,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: AfroReadsColors.darkBackground,
                                        fontWeight: FontWeight.w400,
                                        
                                      ),
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        setState(() {
                                          if (cardNumberController.text !=
                                                  null &&
                                              value[0] == '5') {
                                            isMaterCard = true;
                                          } else if (cardNumberController
                                                      .text !=
                                                  null &&
                                              value[0] == '4') {
                                            isverveCard = true;
                                            isMaterCard = false;
                                          } else {
                                            isMaterCard = false;
                                            isverveCard = false;
                                          }
                                        });
                                      },
                                      decoration: InputDecoration(
                                          label: TextBody(
                                            'Card Number',
                                            fontSize: showLabel ? 10 : 14,
                                            color: showLabel
                                                ? AfroReadsColors.primaryColor
                                                : AfroReadsColors.grey,
                                          ),
                                          border: InputBorder.none,
                                          counterText: '',
                                          hintText: 'Card Number',
                                          hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: AfroReadsColors.grey,
                                            
                                          )),
                                    ),
                                  ),
                                  const Gap(20),
                                  isMaterCard
                                      ? Image.asset(
                                          AppAssets.bookicon,
                                          height: 13,
                                          width: 22,
                                        )
                                      : isverveCard
                                          ? Image.asset(
                                              AppAssets.bookicon,
                                              height: 20,
                                              width: 22,
                                            )
                                          : SvgPicture.asset(
                                              AppAssets.bookicon)
                                ],
                              ),
                            )),
                        const Gap(24),
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                              height: 52,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AfroReadsColors.grey.withOpacity(0.2),
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  color: expiryDateFocus
                                      ? AfroReadsColors.background
                                      : AfroReadsColors.grey.withOpacity(0.05)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: TextFormField(
                                      controller: expiryDATEController,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(4),
                                        CardMonthInputFormatter()
                                      ],
                                      onTap: () {
                                        setState(() {
                                          expiryDateFocus = true;
                                        });
                                      },
                                      style: TextStyle(
                                          fontSize: 15,
                                         
                                          color: AfroReadsColors.darkBackground),
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        label: TextBody(
                                          'Expiry date',
                                          fontSize: expiryDateFocus ? 10 : 15,
                                          color: expiryDateFocus
                                              ? AfroReadsColors.primaryColor
                                              : AfroReadsColors.grey
                                          
                                        ),
                                      ),
                                    )),
                                    const Gap(20),
                                    SvgPicture.asset(AppAssets.bookicon)
                                  ],
                                ),
                              ),
                            )),
                            const Gap(22),
                            Expanded(
                                child: Container(
                              height: 52,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AfroReadsColors.grey.withOpacity(0.2),
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  color: cvvFocus
                                      ? AfroReadsColors.background
                                      : AfroReadsColors.grey.withOpacity(0.05)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: cvvController,
                                        maxLength: 3,
                                        onTap: () {
                                          setState(() {
                                            cvvFocus = true;
                                          });
                                        },
                                        style: TextStyle(
                                            fontSize: 15,
                                          
                                            color: AfroReadsColors.darkBackground,),
                                        decoration: InputDecoration(
                                          counterText: '',
                                          border: InputBorder.none,
                                          label: TextBody(
                                            'CVV',
                                            fontSize: cvvFocus ? 10 : 15,
                                            color: cvvFocus
                                                ? AfroReadsColors.primaryColor
                                                : AfroReadsColors.grey,
                                                   
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Gap(20),
                                    SvgPicture.asset(AppAssets.bookicon)
                                  ],
                                ),
                              ),
                            )),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                        BusyButton(
                          title: 'Next',
                          onTap: () {
                            
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue previousValue,
    TextEditingValue nextValue,
  ) {
    var inputText = nextValue.text;

    if (nextValue.selection.baseOffset == 0) {
      return nextValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return nextValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}

class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
