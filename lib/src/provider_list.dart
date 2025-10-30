import 'package:mingly/src/screens/auth/auth_provider.dart';
import 'package:mingly/src/screens/protected/event_list_screen/events_provider.dart';
import 'package:mingly/src/screens/protected/home_screen/home_proivder.dart';
import 'package:mingly/src/screens/protected/my_bottles/bottle_provider.dart';
import 'package:mingly/src/screens/protected/profile_screen/profile_provider.dart';
import 'package:mingly/src/screens/protected/venue_list_screen/venue_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ProviderList {
  static List<SingleChildWidget> get providers => [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(
      create: (_) => VenueProvider()
        ..getVenuesList()
        ..getFeaturedVenuesList(),
    ),
    ChangeNotifierProvider(
      create: (_) => EventsProvider()
        ..getEventList()
        ..getPopularEventList()
        ..getRecomendedEventList(),
    ),
    ChangeNotifierProvider(create: (_) => BottleProvider()..getBottleList()),
    ChangeNotifierProvider(
      create: (_) => ProfileProvider()
        ..getOrderHistory()
        ..getProfile()
        ..getPointHistory()
        ..getVoucherList()
        ..getPromoCodeList(),
    ),
    ChangeNotifierProvider(
      create: (_) => HomeProivder()
        ..getCurrentLocationName()
        ..getLeaderBoardlist()
        ..getAdsImagelist()
        ..getPackagelist(),
    ),
  ];
}
