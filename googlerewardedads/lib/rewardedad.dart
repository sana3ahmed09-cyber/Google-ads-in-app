import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class RewardedAds extends StatefulWidget {
  @override
  _RewardedAdExampleState createState() => _RewardedAdExampleState();
}

class _RewardedAdExampleState extends State<RewardedAds> {
  RewardedAd? _rewardedAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadRewardedAd();
  }

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/5224354917',
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          setState(() {
            _rewardedAd = ad;
            _isAdLoaded = true;
          });
          _setAdCallbacks(ad);
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('RewardedAd failed to load: $error');
        },
      ),
    );
  }

  void _setAdCallbacks(RewardedAd ad) {
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (Ad ad) =>
          print('RewardedAd onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (Ad ad) {
        print('RewardedAd onAdDismissedFullScreenContent.');
        ad.dispose();
        _loadRewardedAd(); // Load a new ad
      },
      onAdFailedToShowFullScreenContent: (Ad ad, AdError error) {
        print('RewardedAd onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _loadRewardedAd(); // Load a new ad
      },
    );
  }

  void _showRewardedAd() {
    if (_isAdLoaded && _rewardedAd != null) {
      _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          print('User earned reward: ${reward.amount} ${reward.type}');
        },
      );
    } else {
      print('RewardedAd is not yet loaded.');
    }
  }

  @override
  void dispose() {
    _rewardedAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RewardedAds Ad Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _showRewardedAd,
          child: Text('Show RewardedAds Ad'),
        ),
      ),
    );
  }
}
