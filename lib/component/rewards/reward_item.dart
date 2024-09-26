import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hackathon24/services/activated_service.dart';

class RewardItem extends StatelessWidget {
  const RewardItem({
    super.key,
    required this.title,
    required this.id,
    required this.imgUrl,
    required this.kelaxCost,
    required this.reduceKelaxBalance,
  });

  final Function reduceKelaxBalance;
  final String id;
  final String title;
  final String imgUrl;
  final int kelaxCost;

  bool isActivated() {
    return GetIt.I.get<ActivatedService>().isActivated(id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Card(
        elevation: 20.0,
        child: InkWell(
          onTap: () => reduceKelaxBalance(kelaxCost, id),
          child: Container(
            padding: const EdgeInsets.all(8),
            height: 200,
            width: double.infinity,
            child: Stack(
              children: [
                Builder(builder: (context) {
                  return Positioned.fill(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: FittedBox(
                            fit: BoxFit.cover,
                            clipBehavior: Clip.hardEdge,
                            child: Image.asset(imgUrl),
                          ),
                        ),
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            height: 0.6,
                          ),
                        ),
                        Text(
                          isActivated()
                              ? "Aktiviert"
                              : "Kosten: ${kelaxCost}k's",
                          style: const TextStyle(height: 0.3),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
