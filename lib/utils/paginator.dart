import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../model/dashboard/getDashboard.dart';
import '../provider/dashboard_provider.dart';
import '../screen/splash_screen.dart';
import 'dashBoardBloc.dart';

int dashboard_page=1;
bool isLoad = false;

Future<void> loadNewDashboardData({required BuildContext context}) async {
  final dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
  GetDashboard? value= await dashboardProvider.getDashboard(dashboard_page, context);

  if (value != null) {
    refreshNewDashboardData(value);
    dashboardBloc.refreshDashboards(true);
  }
}

refreshNewDashboardData(GetDashboard _dashboard){
  isLoad= true;
  // ignore: unnecessary_null_comparison
  if(totalProducts==null) {
    totalProducts=[];
  }
  if(totalCategories==null)
    totalCategories=[];

  currencyCode=_dashboard.currency_code;
  featured_products=_dashboard.featured_products;
  top_selling_products=_dashboard.top_selling_products;

  _dashboard.products.forEach((item) {
    var alreadyExistItem= totalProducts.firstWhereOrNull((element) => element.id==item.id );
    if (alreadyExistItem==null)
      totalProducts.add(item);

  });
  _dashboard.categories.forEach((item) {
    var alreadyExistItem= totalCategories!.firstWhereOrNull((element) => element.id==item.id );
    if (alreadyExistItem==null)
      totalCategories!.add(item);
  });
  isLoad= false;
  dashboardBloc.refreshDashboards(true);
}

