part of 'home_screen.dart';

class Cards extends StatelessWidget {
  const Cards({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
      if (state is TodoLoading) {
        return const CircularProgressIndicator.adaptive();
      } else if (state is TodoFailure) {
        return Text(state.error);
      } else if (state is TodoLoaded) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomBox(
                  height: height,
                  width: width,
                  backColor: const Color(0xFFB4C4FF),
                  imgUrl: 'assets/icons/speakericon.svg',
                  title: 'Daily Task',
                  count: todoCount(state.todos, 'dailytask'),
                ),
                CustomBox(
                  height: height,
                  width: width,
                  backColor: const Color(0xFFCFF3E9),
                  imgUrl: 'assets/icons/caricon.svg',
                  title: 'Work',
                  count: todoCount(state.todos, 'work'),
                ),
              ],
            ),
            const Gap(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomBox(
                  height: height,
                  width: width,
                  backColor: const Color(0xFF9747FF),
                  imgUrl: 'assets/icons/gymicon.svg',
                  title: 'Projects',
                  count: todoCount(state.todos, 'project'),
                ),
                CustomBox(
                  height: height,
                  width: width,
                  backColor: const Color(0xFFEDBE7D),
                  imgUrl: 'assets/icons/bagIcon.svg',
                  title: 'Groceries',
                  count: todoCount(state.todos, "groceries"),
                ),
              ],
            ),
          ],
        );
      } else if (state is TodoFiltered) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomBox(
                  height: height,
                  width: width,
                  backColor: const Color(0xFFB4C4FF),
                  imgUrl: 'assets/icons/speakericon.svg',
                  title: 'Daily Task',
                  count: todoCount(state.filteredTodos, 'dailytask'),
                ),
                CustomBox(
                  height: height,
                  width: width,
                  backColor: const Color(0xFFCFF3E9),
                  imgUrl: 'assets/icons/caricon.svg',
                  title: 'Work',
                  count: todoCount(state.filteredTodos, 'work'),
                ),
              ],
            ),
            const Gap(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomBox(
                  height: height,
                  width: width,
                  backColor: const Color(0xFF9747FF),
                  imgUrl: 'assets/icons/gymicon.svg',
                  title: 'Projects',
                  count: todoCount(state.filteredTodos, 'project'),
                ),
                CustomBox(
                  height: height,
                  width: width,
                  backColor: const Color(0xFFEDBE7D),
                  imgUrl: 'assets/icons/bagIcon.svg',
                  title: 'Groceries',
                  count: todoCount(state.filteredTodos, "groceries"),
                ),
              ],
            ),
          ],
        );
      }
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomBox(
                height: height,
                width: width,
                backColor: const Color(0xFFB4C4FF),
                imgUrl: 'assets/icons/speakericon.svg',
                title: 'Daily Task',
                count: 0,
              ),
              CustomBox(
                height: height,
                width: width,
                backColor: const Color(0xFFCFF3E9),
                imgUrl: 'assets/icons/caricon.svg',
                title: 'Work',
                count: 0,
              ),
            ],
          ),
          const Gap(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomBox(
                height: height,
                width: width,
                backColor: const Color(0xFF9747FF),
                imgUrl: 'assets/icons/gymicon.svg',
                title: 'Projects',
                count: 0,
              ),
              CustomBox(
                height: height,
                width: width,
                backColor: const Color(0xFFEDBE7D),
                imgUrl: 'assets/icons/bagIcon.svg',
                title: 'Groceries',
                count: 0,
              ),
            ],
          ),
        ],
      );
    });
  }
}
