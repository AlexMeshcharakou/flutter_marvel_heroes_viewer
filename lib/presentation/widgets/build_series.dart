import 'package:flutter/material.dart';
import 'package:marvel/presentation/view_data/view_data_series.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BuildSeries extends StatelessWidget {
  final List<ViewDataSeries> _series;

  const BuildSeries(this._series, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context)!.series,
          style: const TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 230,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _series.length,
            itemBuilder: (BuildContext context, int index) {
              final item = _series[index];
              return Column(
                children: [
                  Expanded(
                    flex: 9,
                    child: SizedBox(
                      width: 130,
                      child: Card(
                        color: Colors.blue[50],
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: (item.thumbnailUrl != null)
                              ? FadeInImage.assetNetwork(
                                  placeholder: "assets/images/placeholder.png",
                                  image: item.thumbnailUrl,
                                  fit: BoxFit.fitWidth,
                                  imageErrorBuilder: (_, __, ___) {
                                    return const Icon(Icons.broken_image);
                                  },
                                )
                              : Image.asset("assets/images/placeholder.png"),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Text(item.title),
                    width: 115,
                    height: 80,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
