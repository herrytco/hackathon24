import 'package:flutter/material.dart';
import 'package:hackathon24/component/drawer_item.dart';

class WelcomeDrawer extends StatelessWidget {
  const WelcomeDrawer({
    super.key,
    required this.selectedDrawer,
    required this.selectDrawer,
  });

  final int selectedDrawer;
  final ValueSetter<int> selectDrawer;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerItem(
            label: "Home",
            icon: Icons.home,
            isSelected: selectedDrawer == 0,
            setIsSelected: () => selectDrawer(0),
          ),
          DrawerItem(
            label: "Letzte Ladevorgänge",
            icon: Icons.history,
            isSelected: selectedDrawer == 1,
            setIsSelected: () => selectDrawer(1),
          ),
          DrawerItem(
            label: "Ladestationen",
            icon: Icons.battery_4_bar_rounded,
            isSelected: selectedDrawer == 2,
            setIsSelected: () => selectDrawer(2),
          ),
          DrawerItem(
            label: "Punktestand",
            icon: Icons.attach_money_sharp,
            isSelected: selectedDrawer == 3,
            setIsSelected: () => selectDrawer(3),
          ),
        ],
      ),
    );
  }
}
