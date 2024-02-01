import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            AnimatedLoginButton(),
          ],
        ),
      ),
    );
  }
}

class AnimatedLoginButton extends StatefulWidget {
  const AnimatedLoginButton({Key? key}) : super(key: key);

  @override
  _AnimatedLoginButtonState createState() => _AnimatedLoginButtonState();
}

class _AnimatedLoginButtonState extends State<AnimatedLoginButton> {
  bool _progressBarVisibility = false;
  bool _textVisibility = true;
  final bool _successTextVisibility = false;
  double? _maxWidth, _maxHeight;
  double _width = 60;
  double _height = 60;
  double _opacity = 0;
  double _posX=0;
  double _posY=20;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(30);
  final Color _color = Colors.deepOrangeAccent;

  Future<void> _manageTextVisibility() async {
    await Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        if (_width == 60) {
          _textVisibility = false;
        }
      });
    });
  }

  Future<void> _manageProgressBarVisibility() async {
    await Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        if (_width == 60) {
          _progressBarVisibility = true;
        } else {
          _progressBarVisibility = false;
        }
      });
    });
  }

  Future<void> _manageContainerExpansion() async {
    await Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        if (_width == 60) {
          _progressBarVisibility = false;
          _borderRadius = BorderRadius.circular(0);
          _width = _maxWidth!;
          _height = _maxHeight!;
          _posY=0;
        }
      });
    });
  }

  Future<void> _manageSuccessTextVisibility() async {
    await Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        Navigator.pushNamed(context, '/signUp');
       // _successTextVisibility = true;
      });
    });
  }

  Future<void> _manageSuccessTextOpacity() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _opacity = 1;
      });
    });
  }

  void _test(){
    setState(() {
      _posX=-1;
      _posY=-1;
    });
  }

  @override
  Widget build(BuildContext context) {
    _maxWidth = MediaQuery.of(context).size.width;
    _maxHeight = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Center(
          child: GestureDetector(
            child: AnimatedContainer(
              width: _width,
              height: _height,
              duration: const Duration(
                milliseconds: 200,
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [

                    ],
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                    )
                  ],
                  borderRadius: _borderRadius,
                ),
                child: Center(
                  child: Stack(
                    children: [
                      Visibility(
                        visible: _textVisibility,
                        child: const Icon(
                    Icons.arrow_forward,
                    size: 40.0,
                    color: Colors.white,
                  ),
                      ),
                      Visibility(
                        visible: _progressBarVisibility,
                        child: const CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          strokeWidth: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            onTap: () {
              setState(() {
                if (_width == 60) {
                  _width = 60;
                }
                _manageTextVisibility();
                _manageProgressBarVisibility();
                _manageContainerExpansion();
               // _manageSuccessTextVisibility();
                //_manageSuccessTextOpacity();
              });
            },
          ),
        ),
       SizedBox(width: _posY,)
      ],
    );
  }
}