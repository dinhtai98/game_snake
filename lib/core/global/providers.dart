import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:snake/core/viewmodels/implements/home_viewmodel.dart';
import 'package:snake/core/viewmodels/interfaces/ihome_viewmodel.dart';

List<SingleChildWidget> viewModelProviders = [
  ChangeNotifierProvider<IHomeScreenViewModel>(
    create: (_) => HomeScreenViewModel(),
  ),
];
