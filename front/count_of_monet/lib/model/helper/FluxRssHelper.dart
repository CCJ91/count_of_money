import 'package:count_of_monet/model/core/RssFeed.dart';
import 'package:count_of_monet/model/service/FluxRssService.dart';

class FluxRssHelper {
  FluxRssService fluxRssService = FluxRssService();
  Future<List<RssFeed>> getFluxRss({String? coinName}) async {
    List<RssFeed> listRssFeed =
        await fluxRssService.getFluxRss(coinName: coinName);
    return listRssFeed;
  }
}
