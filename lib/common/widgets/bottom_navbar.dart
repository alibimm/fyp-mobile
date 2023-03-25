import 'package:flutter/material.dart';
import 'package:fyp_mobile/common/utils/app_color.dart';
import 'package:fyp_mobile/common/utils/extensions.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({
    super.key,
    required this.onSelect,
    required this.selectedIndex,
    required this.icons,
    this.addMidSpace = false,
  });
  final int selectedIndex;
  final List<IconData> icons;
  final bool addMidSpace;
  final Function(int) onSelect;

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final middle = widget.icons.length ~/ 2;
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int i = 0; i < middle; i++)
            CustomBottomNavItem(
              icon: widget.icons[i],
              color: widget.selectedIndex == i ? AppColor.darkPrimaryColor : AppColor.mainTextColor,
              onTap: () => widget.onSelect(i),
            ),
          if (widget.addMidSpace) 38.0.hSpace,
          for (int i = middle; i < widget.icons.length; i++)
            CustomBottomNavItem(
              icon: widget.icons[i],
              color: widget.selectedIndex == i ? AppColor.darkPrimaryColor : AppColor.mainTextColor,
              onTap: () => widget.onSelect(i),
            ),
        ],
      ),
    );
  }
}

class CustomBottomNavItem extends StatelessWidget {
  const CustomBottomNavItem({super.key, required this.icon, required this.onTap, required this.color});
  final IconData icon;
  final Color color;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Icon(
          icon,
          color: color,
        ),
      ),
    );
  }
}
