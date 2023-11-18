import 'package:afroreads/app/view/widget/busy_button.dart';
import 'package:afroreads/core/constants/app_assets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../core/usecases/customesnackbar.dart';
import '../../../getuserdetails/presentation/widgets/help_support_modal.dart';
import '../widgets/viewimage.dart';

class createbook extends StatefulWidget {
  const createbook({super.key});

  @override
  State<createbook> createState() => _createbookState();
}

class _createbookState extends State<createbook> {
  PlatformFile? _imagepicked;
  Future<void> _pickimage() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (result == null) {
        return;
      }
      setState(() {
        _imagepicked = result.files.first;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: CustomeSnackbar(
          topic: 'Oh Snap!',
          msg: e.toString(),
          color1: Color.fromARGB(255, 171, 51, 42),
          color2: Color.fromARGB(255, 127, 39, 33),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
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
        child: Column(children: [
          InkWell(
            onTap: () {
              _imagepicked == null
                  ? _pickimage()
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
                          image: _imagepicked,
                        );
                      });
              ;
            },
            child: UseCaseUpload(
              title: _imagepicked == null ? 'Add Image' : 'View Image',
              icon: AppAssets.imagelook,
              iconcolor: Colors.green,
            ),
          ),
          Gap(30),
          UseCaseUpload(
            title: 'Add Book',
            icon: AppAssets.filelook,
            iconcolor: Colors.red,
          ),
          Gap(30),
          BusyButton(title: 'Upload', onTap: () {})
        ]),
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
  });
  final String title;
  final String icon;
  final Color iconcolor;

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
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox()
          ],
        ),
      ),
    );
  }
}
