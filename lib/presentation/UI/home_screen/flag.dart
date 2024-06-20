part of 'home_screen.dart';

class Flag extends StatelessWidget {
  const Flag({
    super.key,
    required this.label,
    required this.imgAddress,
  });

  final String label;
  final String imgAddress;

  @override
  Widget build(BuildContext context) {
    print('img address $imgAddress');
    return Container(
      width: 100,
      height: 25,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            imgAddress,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
              fontSize: 10, color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

String imgType(String importance) {
  switch (importance) {
    case 'low':
      return 'assets/icons/low.png';
    case 'medium':
      return 'assets/icons/medium.png';
    case 'high':
      return 'assets/icons/important.png';
  }
  return '';
}
