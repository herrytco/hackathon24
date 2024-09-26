import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hackathon24/constants/theme_data.dart';
import 'package:hackathon24/services/activated_service.dart';

class RewardItem extends StatelessWidget {
  const RewardItem({
    super.key,
    required this.title,
    required this.id,
    required this.imgUrl,
    required this.kelaxCost,
    required this.reduceKelaxBalance,
    required this.tag,
  });

  final Function reduceKelaxBalance;
  final String id;
  final String title;
  final String imgUrl;
  final int kelaxCost;
  final String tag;

  final double cardSize = 160;
  final double imageSize = 100;

  bool isActivated() {
    return GetIt.I.get<ActivatedService>().isActivated(id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Card(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 20.0,
        child: InkWell(
          onTap: () => reduceKelaxBalance(kelaxCost, id),
          child: SizedBox(
            height: cardSize,
            width: double.infinity,
            child: Stack(
              children: [
                Builder(builder: (context) {
                  return Positioned.fill(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: imageSize,
                          width: double.infinity,
                          child: FittedBox(
                            fit: BoxFit.cover,
                            clipBehavior: Clip.hardEdge,
                            child: Image.asset(imgUrl),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 8),
                          height: cardSize - imageSize,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            title,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                Align(
                  alignment: const Alignment(
                    0.9,
                    0.3,
                  ),
                  child: FloatingActionButton(
                    onPressed: null,
                    foregroundColor: Colors.white,
                    backgroundColor: kelagGreen,
                    heroTag: tag,
                    child: isActivated()
                        ? const Icon(Icons.check)
                        : Text("${kelaxCost}k's"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
