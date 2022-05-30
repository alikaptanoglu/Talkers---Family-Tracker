import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class DemoPag extends StatefulWidget {
  const DemoPag({ Key? key }) : super(key: key);

  @override
  State<DemoPag> createState() => _DemoPagState();
}

class _DemoPagState extends State<DemoPag> {

  /// API KEY FOR REGİSTERİNG REVENUE CAT SERVİCES.
  static const String REVENUE_CAT_API_KEY = 'appl_yRUfhCipEFhmWdewvvhCPWSQVVb';

  /// ALL INFORMATİON REGARDING THE PURCHASER.
  PurchaserInfo? _purchaserInfo;

  /// ALL THE OFFERINGS CONFIGURED IN REVENUECAT DASHBOARD.
  Offerings? _offerings;

  @override
  void initState() {
    _load();
    super.initState();
  }

  Future<void> _load() async {
    /// ENABLE/DISABLE DEBUGS LOGS.
    await Purchases.setDebugLogsEnabled(true);

    /// SET API KEY.
    await Purchases.setup(REVENUE_CAT_API_KEY);

    /// FETCH THE PURCHASER INFO.
    PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();

    /// FETCH THE OFFERINGS INFO.
    Offerings offerings = await Purchases.getOfferings();

    /// IF THE WIDGET WAS REMOVED FROM THE TREE WHILE THE ASYNCHRONOUS PLATFORM
    /// MESSAGE WAS IN FLIGHT, WE WANT TO DISCARD TO REPLY RATHER THEN CALLING
    /// SETSTATE TO UPDATE OUR NON-EXISTENT APPEARENCE.
    if(!mounted) return;

    setState(() {
      _purchaserInfo = purchaserInfo;
      _offerings = offerings;
    });
  }

  Future<void> _purchasePackage ({required Package package}) async{
    try{
      /// PURCHASE THE PACKAGE.
      await Purchases.purchasePackage(package);

      /// REBUILD PAGE
      setState(() {});
    } on PlatformException catch (e){
      /// FETCH THE ERROR CODE FROM THE EXCEPTION
      PurchasesErrorCode errorCode = PurchasesErrorHelper.getErrorCode(e);
      if(errorCode != PurchasesErrorCode.purchaseCancelledError){
        debugPrint(e.message);
      }
    }
  }

  bool _entitlementActive({required PurchaserInfo purchaserInfo}){
    return purchaserInfo.entitlements.active.containsKey('Premium');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('In-APP-Purchases')),
      body: _purchaserInfo == null
      ? const Center(child: const CircularProgressIndicator(),)
      : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(_entitlementActive(purchaserInfo: _purchaserInfo!))...[
            const Center(child: const Text('Premium Plan'),)
          ],
          if(!_entitlementActive(purchaserInfo: _purchaserInfo!))...[
            Center(child: TextButton(onPressed: () async {
              /// FETCH THE OFFERING ENTITLED PREMIUM PLAN 
              Offering? offering = _offerings!.getOffering('premiumaccessallproducts');

              if(offering != null){
                /// FETCH THE PACKAGE FOR THIS OFFERING ENTITLED WEEKLY
                Package? package = offering.getPackage('\$rc_annual');
                if(package != null){
                  _purchasePackage(package: package);
                }
              }

            }, child: const Text('Subscribe'),),)
          ]

        ],
      )

      
    );
  }
}