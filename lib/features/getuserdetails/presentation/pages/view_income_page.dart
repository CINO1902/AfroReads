import 'package:afroreads/app/styles/fonts.dart';
import 'package:afroreads/app/view/widget/back_button.dart';
import 'package:afroreads/app/view/widget/busy_button.dart';
import 'package:afroreads/core/constants/app_assets.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:afroreads/features/getuserdetails/presentation/widgets/bank_modal.dart';
import 'package:afroreads/features/getuserdetails/presentation/widgets/debit_card_modal.dart';
import 'package:afroreads/features/getuserdetails/presentation/widgets/wallet_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class ViewIncomePage extends StatefulWidget {
  const ViewIncomePage({super.key});

  @override
  State<ViewIncomePage> createState() => _ViewIncomePageState();
}

class _ViewIncomePageState extends State<ViewIncomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AfroReadsColors.background,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AfroReadsBackButton(),
                // TextSemiBold(
                //   'Payment Method',
                //   fontSize: 18,
                //   color: AfroReadsColors.textColor,
                // ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            const Gap(30),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextBody(
                      "Select a payment \nmethod",
                      fontSize: 32,
                    ),
                    const Gap(48),
                    PaymentMethodItem(
                      icons: AppAssets.bookicon,
                      title: 'Debit Card',
                      onTap: () {
                       showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                )),
                                context: context,
                                builder: (context) => const DebitCardModal());
                      },
                    ),
                   
                    const Gap(24),
                    PaymentMethodItem(
                      icons: AppAssets.bookicon,
                      title: 'Bank Transfer',
                      onTap: () {
                        showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            )),
                            context: context,
                            builder: (context) {
                              return const BankModal();
                            });
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    BusyButton(
                      title: 'Continue',
                      onTap: () {},
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

class PaymentMethodItem extends StatelessWidget {
  const PaymentMethodItem({
    super.key,
    required this.icons,
    required this.title,
    required this.onTap,
  });
  final String icons;
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 58,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AfroReadsColors.white,
            border: Border.all(
              color: AfroReadsColors.primaryColor,
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Center(
            child: ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: SvgPicture.asset(icons, color: AfroReadsColors.primaryColor,),
              title: TextSemiBold(
                title,
                color: AfroReadsColors.darkBackground,
                fontSize: 15,
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: AfroReadsColors.darkBackground,
                size: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
