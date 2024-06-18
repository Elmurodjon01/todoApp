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
      width: 85,
      height: 45,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.grey,
        image: DecorationImage(
          image: AssetImage(
            'assets/icons/low.png',
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
