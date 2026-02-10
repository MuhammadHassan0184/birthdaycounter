// // ignore_for_file: library_private_types_in_public_api, file_names, must_be_immutable, deprecated_member_use

// import 'package:birthdaycounter/config/Colors/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';

// class CustomSecondryField extends StatefulWidget {
//   final String label;
//   final IconData? icon;
//   final String? prefixImage;
//   final IconData? suicon;
//   final VoidCallback? onTap;
//   final String? Function(String?)? validation;
//   final TextEditingController? controller;

//   // 🔹 NEW (optional)
//   final bool isDropdown;
//   final List<String>? items;
//   final Function(String)? onChanged;

//   final TextInputType? keyboardType;
// final List<TextInputFormatter>? inputFormatters;

//   CustomSecondryField({
//     super.key,
//     required this.label,
//     this.icon,
//     this.prefixImage,
//     this.suicon,
//     this.onTap,
//     this.validation,
//     this.controller,
//     this.items,
//     this.isDropdown = false,
//     this.onChanged,

//     this.keyboardType,
//   this.inputFormatters,

//   }) : assert(
//          icon != null || prefixImage != null,
//          'Either icon or prefixImage must be provided',
//        );

//   @override
//   _CustomSecondryFieldState createState() => _CustomSecondryFieldState();
// }

// class _CustomSecondryFieldState extends State<CustomSecondryField> {
//   bool showpass = false;

//   @override
//   Widget build(BuildContext context) {
//     if (widget.isDropdown) {
//       return DropdownButtonFormField<String>(
//         value: widget.controller!.text.isEmpty ? null : widget.controller!.text,
//         items: widget.items!
//             .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//             .toList(),
//         onChanged: (val) {
//           widget.controller!.text = val!;
//           widget.onChanged?.call(val);
//         },
//         decoration: _decoration(),
//         validator: widget.validation,
//       );
//     }

//     // 🔹 ORIGINAL TEXT FIELD (UNCHANGED BEHAVIOR)
//     return TextFormField(
//       controller: widget.controller,
//       validator: widget.validation,
//       obscureText: widget.suicon != null ? !showpass : false,
//       textAlignVertical: TextAlignVertical.center,
//       onTap: widget.onTap,
//       onChanged: widget.onChanged,
//       decoration: _decoration(),
//     );
//   }

//   InputDecoration _decoration() {
//     return InputDecoration(
//       prefixIcon: widget.prefixImage != null
//           ? Padding(
//               padding: const EdgeInsets.all(12),
//               child: SvgPicture.asset(
//                 widget.prefixImage!,
//                 width: 24,
//                 height: 24,
//                 colorFilter: ColorFilter.mode(
//                   AppColors.primary,
//                   BlendMode.srcIn,
//                 ),
//               ),
//             )
//           : Icon(widget.icon, color: AppColors.primary, size: 20),
//       suffixIcon: widget.suicon != null
//           ? IconButton(
//               onPressed: () {
//                 setState(() => showpass = !showpass);
//               },
//               icon: Icon(
//                 showpass ? Icons.visibility : Icons.visibility_off,
//                 color: AppColors.grey,
//                 size: 20,
//               ),
//             )
//           : null,
//       hintText: widget.label,
//       hintStyle: TextStyle(color: AppColors.grey, fontSize: 14),
//       contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide(
//           color: AppColors.black.withOpacity(0.2),
//           width: 0.9,
//         ),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide(
//           color: AppColors.black.withOpacity(0.2),
//           width: 0.9,
//         ),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide(
//           color: AppColors.black.withOpacity(0.25),
//           width: 0.6,
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: library_private_types_in_public_api, file_names, must_be_immutable, deprecated_member_use

import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class CustomSecondryField extends StatefulWidget {
  final String label;
  final IconData? icon;
  final String? prefixImage;
  final IconData? suicon;
  final VoidCallback? onTap;
  final String? Function(String?)? validation;
  final TextEditingController? controller;
  final bool isDropdown;
  final List<String>? items;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const CustomSecondryField({
    super.key,
    required this.label,
    this.icon,
    this.prefixImage,
    this.suicon,
    this.onTap,
    this.validation,
    this.controller,
    this.items,
    this.isDropdown = false,
    this.onChanged,
    this.keyboardType,
    this.inputFormatters,
  }) : assert(
         icon != null || prefixImage != null,
         'Either icon or prefixImage must be provided',
       );

  @override
  _CustomSecondryFieldState createState() => _CustomSecondryFieldState();
}

class _CustomSecondryFieldState extends State<CustomSecondryField> {
  bool showpass = false;

  @override
  Widget build(BuildContext context) {
    if (widget.isDropdown) {
      return DropdownButtonFormField<String>(
        value: widget.controller!.text.isEmpty ? null : widget.controller!.text,
        items: widget.items!
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (val) {
          widget.controller!.text = val!;
          widget.onChanged?.call(val);
        },
        decoration: _decoration(),
        validator: widget.validation,
      );
    }

    // ✅ Fixed: pass keyboardType & inputFormatters
    return TextFormField(
      controller: widget.controller,
      validator: widget.validation,
      keyboardType: widget.keyboardType, // 🔹 add this
      inputFormatters: widget.inputFormatters, // 🔹 add this
      obscureText: widget.suicon != null ? !showpass : false,
      textAlignVertical: TextAlignVertical.center,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      decoration: _decoration(),
    );
  }

  InputDecoration _decoration() {
    return InputDecoration(
      prefixIcon: widget.prefixImage != null
          ? Padding(
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset(
                widget.prefixImage!,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
            )
          : Icon(widget.icon, color: AppColors.primary, size: 20),
      suffixIcon: widget.suicon != null
          ? IconButton(
              onPressed: () {
                setState(() => showpass = !showpass);
              },
              icon: Icon(
                showpass ? Icons.visibility : Icons.visibility_off,
                color: AppColors.grey,
                size: 20,
              ),
            )
          : null,
      hintText: widget.label,
      hintStyle: TextStyle(color: AppColors.grey, fontSize: 14),
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: AppColors.black.withOpacity(0.2),
          width: 0.9,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: AppColors.black.withOpacity(0.2),
          width: 0.9,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: AppColors.black.withOpacity(0.25),
          width: 0.6,
        ),
      ),
    );
  }
}
