import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAds extends StatefulWidget {
  @override
  _BannerAdExampleState createState() => _BannerAdExampleState();
}

class _BannerAdExampleState extends State<BannerAds> {
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          print('BannerAd failed to load: $error');
        },
        onAdOpened: (Ad ad) => print('BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('BannerAd onAdClosed.'),
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Banner Ad Example'),
      ),
      body: Center(
        child: _isAdLoaded
            ? Container(
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd!),
              )
            : Text('Ad is loading...'),
      ),
    );
  }
}
