import 'package:everest/utils/colors.dart';
import 'package:everest/utils/common_styles.dart';
import 'package:flutter/material.dart';

class ImagePickerSelectionWidget extends StatefulWidget {
  final VoidCallback? onCameraTap;
  final VoidCallback? onGalleryTap;
  final VoidCallback? onRemoveTap;
  const ImagePickerSelectionWidget({Key? key, this.onCameraTap, this.onGalleryTap, this.onRemoveTap}) : super(key: key);

  @override
  State<ImagePickerSelectionWidget> createState() => _HomeScreenAddPremiseWidgetState();
}

class _HomeScreenAddPremiseWidgetState extends State<ImagePickerSelectionWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        color: ColorUtils.whiteColor,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: FractionallySizedBox(
                  widthFactor: 0.23,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 15.0,
                    ),
                    child: Container(
                      height: 4.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: const BorderRadius.all(Radius.circular(50)),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  "Select Your Image",
                  style: size18(fontColor: ColorUtils.blackColor, fw: FW.bold),
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: widget.onCameraTap,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            height: screenSize.height * 0.10,
                            decoration: BoxDecoration(
                              color: const Color(0xff482EA0).withOpacity(0.20),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.camera_alt, size: 30, color: Color(0xff7447E8)),
                                const SizedBox(height: 10),
                                Text(
                                  'Camera',
                                  style: size16(
                                    fontColor: ColorUtils.blackColor,
                                    fw: FW.semiBold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: widget.onGalleryTap,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            height: screenSize.height * 0.10,
                            decoration: BoxDecoration(
                              color: const Color(0xff482EA0).withOpacity(0.20),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.photo_rounded, size: 30, color: Color(0xff7447E8)),
                                const SizedBox(height: 10),
                                Text(
                                  'Gallery',
                                  style: size16(
                                    fontColor: ColorUtils.blackColor,
                                    fw: FW.semiBold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: widget.onRemoveTap,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            height: screenSize.height * 0.10,
                            decoration: BoxDecoration(
                              color: const Color(0xff482EA0).withOpacity(0.20),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.remove_circle_rounded, size: 30, color: Color(0xff7447E8)),
                                const SizedBox(height: 10),
                                Text(
                                  'Remove',
                                  style: size16(
                                    fontColor: ColorUtils.blackColor,
                                    fw: FW.semiBold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
