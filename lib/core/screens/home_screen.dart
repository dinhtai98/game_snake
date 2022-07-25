import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake/core/screens/control_panel.dart';
import 'package:snake/core/viewmodels/interfaces/ihome_viewmodel.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({Key? key}) : super(key: key);

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  late final IHomeScreenViewModel _viewModel;
  late Size size;
  @override
  void initState() {
    super.initState();
    _viewModel = context.read<IHomeScreenViewModel>();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _viewModel.initData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.orange[400],
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 20),
                  itemCount: _viewModel.numberOfSquares,
                  itemBuilder: (BuildContext context, int index) {
                    return _SquareItem(index: index);
                  }),
            ),
          ),
          ControlPanel(),
        ],
      ),
    );
  }
}

class _SquareItem extends StatelessWidget {
  final int index;
  const _SquareItem({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(2),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Consumer<IHomeScreenViewModel>(builder: (_, _viewModel, ___) {
            if (_viewModel.food == index) {
              return _BuildFood();
            } else if (_viewModel.snakePositions.contains(index)) {
              return Container(
                color: Colors.red,
              );
            } else {
              return Container(
                color: Colors.transparent,
              );
            }
          }),
        ),
      ),
    );
  }
}

class _BuildFood extends StatefulWidget {
  const _BuildFood({Key? key}) : super(key: key);

  @override
  State<_BuildFood> createState() => _BuildFoodState();
}

class _BuildFoodState extends State<_BuildFood>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: controller,
      child: Container(
        color: Colors.green,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
