import '../config/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:icofont_flutter/icofont_flutter.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget(
      {Key? key,
      required this.imagePath,
      required this.onClicked,
      required this.editIcon})
      : super(key: key);
  final bool editIcon;
  final String imagePath;
  final VoidCallback onClicked;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Center(
        child: Stack(
          children: [
            _buildImage(),
            Positioned(
              bottom: 25.0,
              right: 25.0,
              child: editIcon == true ? _buildEditIcon() : _buildUploadIcon(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    final image = AssetImage(imagePath);
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          width: 200.0,
          height: 200.0,
          fit: BoxFit.cover,
          child: editIcon == true
              ? InkWell(onTap: onClicked)
              : Container(
                  width: 0,
                ),
        ),
      ),
    );
  }

  Widget _buildEditIcon() {
    return _buildCircle(
      color: Colors.white,
      all: 3,
      child: _buildCircle(
        all: 5,
        color: AppColor.orange,
        child: const Icon(
          IcoFontIcons.editAlt,
          color: Colors.white,
          size: 20.0,
        ),
      ),
    );
  }

  Widget _buildUploadIcon() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(2),
      width: 40,
      height: 40,
      child: _buildCircle(
        color: Colors.white,
        all: 3,
        child: _buildCircle(
          all: 0,
          color: AppColor.orange,
          child: IconButton(
            icon: const Icon(
              IcoFontIcons.camera,
              color: Colors.white,
              size: 20.0,
            ),
            onPressed: onClicked,
          ),
        ),
      ),
    );
  }

  Widget _buildCircle(
      {required Color color, required Widget child, required double all}) {
    return ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );
  }
}
