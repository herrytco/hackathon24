import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon24/component/drawer_item.dart';
import 'package:hackathon24/constants/theme_data.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppBar(
          backgroundColor: kelagGreen,
          flexibleSpace: LayoutBuilder(
            builder: (context, constraints) {
              return Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 50),
                    height: constraints.maxHeight,
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      "assets/logo_invers.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "WattUp!",
                        style: GoogleFonts.lato().copyWith(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      drawer: Drawer(
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
      ),
    );
  }
}
