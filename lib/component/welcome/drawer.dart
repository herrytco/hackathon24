import 'package:flutter/material.dart';
import 'package:hackathon24/component/drawer_item.dart';

class WelcomeDrawer extends StatelessWidget {
  const WelcomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const [
          DrawerItem(
            label: "Home",
            icon: Icons.home,
            isSelected: true,
          ),
          DrawerItem(
            label: "Letzte Ladevorgänge",
            icon: Icons.history,
            isSelected: false,
          ),
          DrawerItem(
            label: "Ladestationen",
            icon: Icons.battery_4_bar_rounded,
            isSelected: false,
          ),
          DrawerItem(
            label: "Punktestand",
            icon: Icons.attach_money_sharp,
            isSelected: false,
          ),
        ],
      ),
    );
  }
}
