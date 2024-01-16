import 'dart:async';

class DashboardBloc{

  final getDashboardStreamController = StreamController<bool>.broadcast();
  StreamSink<bool> get getDashboard_sink => getDashboardStreamController.sink;
  Stream<bool> get getDashboard_counter => getDashboardStreamController.stream;

  refreshDashboards(bool isFetched){
    getDashboard_sink.add(isFetched);
  }
}

final DashboardBloc dashboardBloc=new DashboardBloc();