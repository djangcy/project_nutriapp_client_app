import 'package:flutter/material.dart';

class TabData {
  const TabData({
    required this.title,
    this.selectedBorderColor,
    this.unselectedBorderColor,
    this.selectedTextColor,
    this.unselectedTextColor,
    this.onTap,
  });

  final String title;

  final Color? selectedTextColor;
  final Color? unselectedTextColor;
  final Color? selectedBorderColor;
  final Color? unselectedBorderColor;

  final void Function()? onTap;
}

class TabWidget extends StatelessWidget {
  const TabWidget({
    super.key,
    required this.tabData,
    required this.isSelected,
  });

  final TabData tabData;
  final bool isSelected;

  Color buildBorderColor() {
    if (isSelected) {
      return tabData.selectedBorderColor ?? Colors.black87;
    } else {
      return tabData.unselectedBorderColor ?? Colors.transparent;
    }
  }

  Color buildTextColor() {
    if (isSelected) {
      return tabData.selectedTextColor ?? Colors.black87;
    } else {
      return tabData.unselectedTextColor ?? Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      width: 120,
      height: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: buildBorderColor(),
            width: 2,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            tabData.title,
            style: TextStyle(
              color: buildTextColor(),
            ),
          ),
        ],
      ),
    );
  }
}

class TabPickerWidget extends StatelessWidget {
  const TabPickerWidget({
    super.key,
    required this.tabs,
    this.selectedIndex = 0,
    this.onChanged,
  }) : assert(
          selectedIndex < tabs.length && selectedIndex >= 0,
          'Index out of bounds',
        );

  final List<TabData> tabs;
  final int selectedIndex;
  final void Function(int)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: tabs.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () => onChanged?.call(index),
            child: TabWidget(
              tabData: tabs[index],
              isSelected: selectedIndex == index,
            ),
          );
        },
      ),
    );
  }
}
