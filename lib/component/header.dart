import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon24/constants/theme_data.dart';

class KelagAppHeader extends StatefulWidget {
  const KelagAppHeader({super.key});

  static PreferredSize get header => const PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: KelagAppHeader(),
      );

  @override
  State<KelagAppHeader> createState() => _KelagAppHeaderState();
}

class _KelagAppHeaderState extends State<KelagAppHeader> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
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
    );
  }
}
