import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hackathon24/constants/labels.dart';
import 'package:hackathon24/constants/theme_data.dart';
import 'package:hackathon24/model/ngo.dart';
import 'package:hackathon24/services/backend_service.dart';
import 'package:hackathon24/services/balance_service.dart';

class DonationDialog extends StatefulWidget {
  const DonationDialog({super.key, required this.onComplete});

  final void Function() onComplete;

  @override
  State<DonationDialog> createState() => _DonationDialogState();
}

class _DonationDialogState extends State<DonationDialog> {
  Ngo? _selectedNgo;

  void _onDonate(BuildContext context) async {
    if (_selectedNgo == null) return;
    await GetIt.I.get<BalanceService>().removeBalance(100);
    widget.onComplete();

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Spende deine $coinNameShort für den guten Zweck!"),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        child: ListView(
          shrinkWrap: true,
          children: ngos
              .map(
                (e) => InkWell(
                  onTap: () {
                    setState(() {
                      _selectedNgo = e;
                    });
                  },
                  child: Card(
                    color:
                        _selectedNgo == e ? kelagGreen.withOpacity(.1) : null,
                    child: SizedBox(
                        height: 169,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  minRadius: 40,
                                  maxRadius: 40,
                                  backgroundImage: AssetImage(
                                    "assets/ngo/${e.asset}",
                                  ),
                                ),
                              ),
                            ),

                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: const EdgeInsets.only(left: 100),
                                child: Column(
                                  children: [
                                    Text(
                                      e.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!,
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          e.message,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Container(
                            //   width: 100,
                            //   height: 100,
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(50),
                            //     color: Colors.red,
                            //   ),
                            //   // child:

                            //   // Image.asset(
                            //   //   "assets/ngo/${e.asset}",
                            //   //   fit: BoxFit.cover,
                            //   // ),
                            // ),
                          ],
                        )),
                  ),
                ),
              )
              .toList(),
        ),
      ),
      actions: [
        if (_selectedNgo != null)
          ElevatedButton(
            onPressed: () => _onDonate(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
            child: Text("Spende 100 $coinNameShort"),
          ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          child: Text("Abbrechen"),
        ),
      ],
    );
  }
}
