import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdInfo {
  BannerAd? bannerAd;
  bool isReady = false;

  BannerAdInfo() {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      listener: BannerAdListener(onAdLoaded: (_) {
        isReady = true;
      }, onAdFailedToLoad: (ad, err) {
        isReady = false;

        ad.dispose();
      }),
    );
  }
  load() => bannerAd?.load();

  dispose() => bannerAd?.dispose();
}

class AdHelper {
  static BannerAdInfo? bannerAd;
  static BannerAdInfo? mainMenuBannerAd;
  static List<BannerAdInfo> bannerList = [];
  static InterstitialAd? interstitialAd;
  static bool interstitialAdReady = false;
  static String get bannerAdUnitId {
    //return 'ca-app-pub-3940256099942544/6300978111';
    //TEST
    return 'ca-app-pub-6091645546775983/9623967670';
  }

  static String get interstitialAdUnitId {
    //TEST
    //return 'ca-app-pub-3940256099942544/1033173712';
    return 'ca-app-pub-6091645546775983/9887460048';
  }

  static void init() {
    bannerAd = BannerAdInfo();
    mainMenuBannerAd = BannerAdInfo();
  }

  static void startBannerAd() {
    //bannerAd?.dispose();
    bannerAd?.load();
    mainMenuBannerAd?.load();
  }

  static void startInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
        interstitialAd = ad;

        ad.fullScreenContentCallback =
            FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {});
        interstitialAdReady = true;
      }, onAdFailedToLoad: (err) {
        interstitialAdReady = false;
      }),
    );
  }
}
