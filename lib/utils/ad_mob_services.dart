import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  static String? get getAdMobAppId {
    return 'ca-app-pub-7040228706164271/6442382784';
  }

  static final BannerAdListener bannerListener = BannerAdListener(
    onAdLoaded: (ad) => debugPrint('Ad loaded: ${ad.adUnitId}'),
    onAdFailedToLoad: (ad, error) => ad.dispose(),
    onAdOpened: (ad) => debugPrint('Ad opened: ${ad.adUnitId}'),
    onAdClosed: (ad) => debugPrint('Ad closed: ${ad.adUnitId}'),
  );
}
