import 'package:flutter/material.dart';

class ItemPlaces extends StatelessWidget {
  const ItemPlaces({
    super.key,
    required this.title,
    required this.address,
    required this.path,
    required this.onPressed,
    this.type = '',
    this.num_mesas = '',
  });

  final String title;
  final String address;
  final String type;
  final String num_mesas;
  final dynamic path;
  final VoidCallback onPressed;

  ImageProvider<Object> _buildImage(String path) {
    return _isUrl(path)
        ? NetworkImage(path)
        : AssetImage(path) as ImageProvider<Object>;
  }

  bool _isUrl(String path) {
    return Uri.tryParse(path)?.hasAbsolutePath ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent,
        ),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                image: DecorationImage(
                  image: _buildImage(path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        address,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ),
                    type == 'desk'
                        ? Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              num_mesas + ' disponível',
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                          )
                        : SizedBox()
                  ],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
