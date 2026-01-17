import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class CustomActorCard extends StatefulWidget {
  const CustomActorCard({super.key});

  @override
  State<CustomActorCard> createState() => _CustomActorCardState();
}

class _CustomActorCardState extends State<CustomActorCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey),
      ),
      child: Row(
        children: [
          /// FAVORITE ICON
          GestureDetector(
            onTap: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? AppColors.primary : AppColors.grey,
              size: 22,
            ),
          ),

          SizedBox(width: 10),

          /// IMAGE
          Container(
            width: 55,
            height: 55,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: Image.asset("assets/my.jpg", fit: BoxFit.cover),
          ),

          SizedBox(width: 12),

          /// TEXT SECTION
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ralph Edwards",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),

                SizedBox(height: 4),

                Text(
                  "02-10-2001",
                  style: TextStyle(fontSize: 12, color: AppColors.grey),
                ),

                SizedBox(height: 4),

                Row(
                  children: [
                    Text(
                      "Birthday ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      "(287 Days)",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          /// ACTIONS
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        _showReminderMenu(context);
                      },
                      icon: const Icon(Icons.more_vert),
                    ),
                    
                  ],
                ),
        ],
      ),
      
    );
  }
}

void _showReminderMenu(BuildContext context) async {
  final RenderBox button = context.findRenderObject() as RenderBox;
  final RenderBox overlay =
      Overlay.of(context).context.findRenderObject() as RenderBox;

  final RelativeRect position = RelativeRect.fromRect(
    Rect.fromPoints(
      button.localToGlobal(Offset.zero, ancestor: overlay),
      button.localToGlobal(
        button.size.bottomRight(Offset.zero),
        ancestor: overlay,
      ),
    ),
    Offset.zero & overlay.size,
  );

  await showMenu(
    context: context,
    position: position,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    items: [
      PopupMenuItem(
        child:  Text("Muhammad Hassan", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      
      PopupMenuItem(
        value: 'edit',
        child: Row(
          children: [
            Icon(Icons.edit, color: AppColors.primary, size: 18),
            SizedBox(width: 10),
            Text("Edit Reminder"),
          ],
        ),
      ),
      PopupMenuItem(
        value: 'delete',
        child: Row(
          children: [
            Icon(Icons.delete, color: AppColors.primary, size: 18),
            SizedBox(width: 10),
            Text("Delete Reminder"),
          ],
        ),
      ),
      PopupMenuItem(
        value: 'preview',
        onTap: () {
          Get.toNamed(AppRoutesName.celebrityPreview);
        },
        child: Row(
          children: [
            Icon(Icons.remove_red_eye, color: AppColors.primary, size: 18),
            SizedBox(width: 10),
            Text("Celebrity Preview"),
          ],
        ),
      ),
    ],
  ).then((value) {
    if (value == 'edit') {
      // edit logic
    } else if (value == 'delete') {
      // delete logic
    } else if (value == 'preview') {
      // preview logic
    }
  });
}
