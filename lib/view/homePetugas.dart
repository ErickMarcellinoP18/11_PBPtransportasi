import 'package:flutter/material.dart';
import 'package:transportasi_11/constant/app_constant.dart';

class HomePagePetugas extends StatelessWidget {
  const HomePagePetugas({super.key});

  navigateTo(BuildContext context, String routeName) =>
      Navigator.pushNamed(context, routeName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LabelTextConstant.homePageAppBarTitle),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                onPressed: () =>
                    navigateTo(context, RouteConstant.routeToQrScanPage),
                child: const Text(ButtonTextConstant.qrScanning)),
          ],
        ),
      ),
    );
  }
}
