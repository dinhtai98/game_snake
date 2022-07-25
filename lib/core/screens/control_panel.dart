import 'package:flutter/material.dart';
import 'package:snake/core/utils/enum.dart';
import 'package:snake/core/viewmodels/interfaces/ihome_viewmodel.dart';
import 'package:provider/provider.dart';

class ControlPanel extends StatelessWidget {
  const ControlPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _viewModel = context.read<IHomeScreenViewModel>();
    return Container(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Consumer<IHomeScreenViewModel>(builder: (_, __, ___) {
            return _viewModel.gameIsStarded
                ? _DirectionButton(
                    function: () {
                      _viewModel.gameIsStarded = false;
                      _viewModel.pauseGame();
                    },
                    iconData: Icons.pause,
                  )
                : SizedBox(width: 50);
          }),
          _DirectionButton(
            function: () {
              if (_viewModel.direction != Direction.right)
                _viewModel.direction = Direction.left;
            },
            iconData: Icons.arrow_left,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _DirectionButton(
                function: () {
                  if (_viewModel.direction != Direction.down)
                    _viewModel.direction = Direction.up;
                },
                iconData: Icons.arrow_drop_up,
              ),
              _DirectionButton(
                function: () {
                  if (_viewModel.direction != Direction.up)
                    _viewModel.direction = Direction.down;
                },
                iconData: Icons.arrow_drop_down,
              ),
            ],
          ),
          _DirectionButton(
            function: () {
              if (_viewModel.direction != Direction.left)
                _viewModel.direction = Direction.right;
            },
            iconData: Icons.arrow_right,
          ),
          Consumer<IHomeScreenViewModel>(builder: (_, __, ___) {
            return _viewModel.gameIsStarded
                ? SizedBox(width: 50)
                : _DirectionButton(
                    function: () {
                      _viewModel.startGame();
                    },
                    iconData: Icons.play_arrow,
                  );
          }),
        ],
      ),
    );
  }
}

class _DirectionButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback function;
  const _DirectionButton({
    Key? key,
    required this.function,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.green[50],
          shape: BoxShape.circle,
        ),
        child: Icon(
          iconData,
          size: 40,
        ),
      ),
    );
  }
}
