import 'package:flutter/material.dart';
import 'package:snipit/core/constants/app_colors.dart';

class BottomSheetOptions extends StatelessWidget {
  final VoidCallback selectImageFromCamera;
  final VoidCallback selectImageFromGallery;
  const BottomSheetOptions(
      {Key? key,
      required this.selectImageFromCamera,
      required this.selectImageFromGallery})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: 150,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: AppColors.primary,
            child: Row(
              children: [
                const Text(
                  "Choose Image From",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildChooseImageMedium(onTap: selectImageFromCamera, context: context, text: "Camera"),
                const SizedBox(
                  height: 4,
                ),
                const Divider(
                  thickness: 2,
                ),
                const SizedBox(
                  height: 4,
                ),
                _buildChooseImageMedium(onTap: selectImageFromGallery, context: context, text: "Gallery"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildChooseImageMedium({required VoidCallback onTap,required BuildContext context,required String text}){
    return GestureDetector(
        onTap:onTap,
        child: SizedBox(
            width: MediaQuery.of(
                context)
                .size
                .width,
            height: 25,
            child:
            Text(
              text,
              style: TextStyle(
                  fontSize:
                  18,
                  fontWeight:
                  FontWeight.w500),
            )));
  }
}
