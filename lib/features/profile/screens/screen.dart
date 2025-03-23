import 'package:flutter/material.dart';
import 'package:my_resume/const/ui/box_decorations.dart';
import 'package:my_resume/custom_icons.dart';
import 'package:my_resume/features/profile/view_model/profile_view_model.dart';
import 'package:my_resume/features/profile/widgets/widgets.dart';
import 'package:my_resume/shared/app_bar_builder.dart';
import 'package:provider/provider.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  int currentIndex = 0;
  String savedStatus = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarBuilder.build(context, 'Ваш профиль'),
      body: ChangeNotifierProvider(
        create: (context) => ProfileViewModel(),
        child: Builder(builder: (context){
          return Selector<ProfileViewModel, String>(
            selector: (_, vm) => vm.savedStatus,
            builder: (BuildContext context, String value, Widget? child) {
              final vm = Provider.of<ProfileViewModel>(context, listen: false);
              if(value.isNotEmpty){
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        value,
                        style: const TextStyle(color: Colors.white70),
                      ),
                      duration: const Duration(seconds: 2),
                      backgroundColor: (!vm.isSaved) ? Colors.redAccent : Colors.green,
                    ),
                  );
                });
              }
              return child ?? const SizedBox();
            },
            child: Selector<ProfileViewModel, bool>(
              selector: (_, vm) => vm.isLoadingPhoto,
              builder: (context, isLoadingPhoto, _){
                return IndexedStack(
                  index: isLoadingPhoto ? 1 : 0,
                  children: const [
                    ProfileScreenSkeleton(),
                    Stack(
                      children: [
                        ProfileScreenSkeleton(),
                        PhotoLoaderWidget(),
                      ],
                    )
                  ],
                );
              },
            ),
          );
        }),
      ),
      bottomNavigationBar: Container(
        decoration: gradientBack,
        child: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            currentIndex: currentIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Colors.grey,
            unselectedItemColor: Colors.white,
            backgroundColor: const Color.fromARGB(0, 0, 0, 0),
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(CustomIcons.menu), label: 'list'),
              BottomNavigationBarItem(
                  icon: Icon(CustomIcons.plus_1), label: 'plus'),
              BottomNavigationBarItem(
                  icon: Icon(CustomIcons.profile), label: 'profile'),
            ]),
      ),
    );
  }
}

class ProfileScreenSkeleton extends StatelessWidget {
  const ProfileScreenSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: 690 / 700,
        widthFactor: 360 / 400,
        child: Column(
          children: [
            Expanded(
                flex: 200,
                child: Row(
                  children: [
                    const Expanded(flex: 150, child: ProfilePhoto()),
                    const Expanded(flex: 10, child: SizedBox.expand()),
                    Expanded(
                        flex: 200,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 60,
                              child: InputWidget(tag: 'surname', title: 'Фамилия'),
                            ),
                            const Expanded(
                                flex: 10, child: SizedBox.expand()),
                            Expanded(
                              flex: 60,
                              child: InputWidget(tag: 'name', title: 'Имя'),
                            ),
                            const Expanded(
                                flex: 10, child: SizedBox.expand()),
                            Expanded(
                              flex: 60,
                              child: InputWidget(tag: 'patronymic', title: 'Отчество'),
                            )
                          ],
                        ))
                  ],
                )),
            const Expanded(flex: 3, child: SizedBox.expand()),
            const Expanded(
                flex: 30,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Контакты',
                  ),
                )),
            Expanded(
              flex: 67,
              child: InputWidget(tag: 'email', title: 'Эл.почта'),
            ),
            const Expanded(flex: 7, child: SizedBox.expand()),
            Expanded(
              flex: 67,
              child: InputWidget(tag: 'phone', title: 'Номер телефона'),
            ),
            const Expanded(flex: 6, child: SizedBox.expand()),
            Expanded(
                flex: 80,
                child: Row(
                  children: [
                    const Expanded(
                        flex: 100,
                        child: Column(
                          children: [
                            Text('Пол'),
                            Expanded(child: GenderSelectionWidget())
                          ],
                        )),
                    const Expanded(flex: 5, child: SizedBox.expand()),
                    Expanded(
                        flex: 150,
                        child: Column(
                          children: [
                            const Text('Дата рождения'),
                            Expanded(
                                child: InputWidget(
                              tag: 'dateOfBirth',
                              maxHeight: 50,
                            ))
                          ],
                        )),
                    const Expanded(flex: 5, child: SizedBox.expand()),
                    Expanded(
                        flex: 100,
                        child: Column(
                          children: [
                            const Text('Возраст'),
                            Expanded(
                                child: InputWidget(
                                  tag: 'age',
                              maxHeight: 50,
                            ))
                          ],
                        )),
                  ],
                )),
            const Expanded(
                flex: 20,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Личная информация'))),
            Expanded(
                flex: 67, child: InputWidget(tag: 'placeOfResidence', title: 'Место проживания')),
            const Expanded(flex: 6, child: SizedBox.expand()),
            Expanded(
                flex: 67,
                child: Row(
                  children: [
                    Expanded(
                        flex: 180,
                        child: InputWidget(tag: 'citizenship', title: 'Гражданство')),
                    Expanded(
                        flex: 180,
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Готовы к переезду?',
                              style: TextStyle(fontSize: 15),
                            ),
                            BusinessTripCheckWidget()
                          ],
                        ))
                  ],
                )),
            const Expanded(flex: 6, child: SizedBox.expand()),
          ],
        ),
      ),
    );
  }
}
