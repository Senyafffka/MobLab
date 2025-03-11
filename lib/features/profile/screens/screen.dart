import 'package:flutter/material.dart';
import 'package:my_resume/const/ui/box_decorations.dart';
import 'package:my_resume/custom_icons.dart';
import 'package:my_resume/features/profile/widgets/widgets.dart';
import 'package:my_resume/shared/app_bar_builder.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarBuilder.build(context, 'Ваш профиль'),
      body: const Align(
        alignment: Alignment.bottomCenter,
        child: FractionallySizedBox(
          heightFactor: 690/700,
          widthFactor: 360/ 400,
          child: Column(
            children: [
              const Expanded(
                flex: 200,
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 150,
                          child: ProfilePhoto()
                      ),
                      const Expanded(
                          flex: 10,
                          child: SizedBox.expand()
                      ),
                      Expanded(
                          flex: 200,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 60,
                                child: InputWidget(title: 'Фамилия'),
                              ),
                              const Expanded(
                                  flex: 10,
                                  child: SizedBox.expand()
                              ),
                              const Expanded(
                                flex: 60,
                                child: InputWidget(title: 'Имя'),
                              ),
                              const Expanded(
                                  flex: 10,
                                  child: SizedBox.expand()
                              ),
                              const Expanded(
                                flex: 60,
                                child: InputWidget(title: 'Отчество'),
                              )
                            ],
                          )
                      )
                    ],
                  )
              ),

              const Expanded(
                  flex: 3,
                  child: SizedBox.expand()
              ),
              const Expanded(
                  flex: 30,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Контакты',
                    ),
                  )
              ),
              const Expanded(
                  flex: 67,
                  child: InputWidget(title: 'Эл.почта'),
              ),
              const Expanded(
                  flex: 7,
                  child: SizedBox.expand()
              ),
              const Expanded(
                  flex: 67,
                  child: InputWidget(title: 'Номер телефона'),
              ),
              const Expanded(
                  flex: 6,
                  child: SizedBox.expand()
              ),
              Expanded(
                  flex: 80,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 100,
                          child: Column(
                            children: [
                              const Text('Пол'),
                              Expanded(child: GenderSelectionWidget())
                            ],
                          )
                      ),
                      const Expanded(
                          flex: 5,
                          child: SizedBox.expand()
                      ),
                      const Expanded(
                          flex: 150,
                          child: Column(
                            children: [
                              Text('Дата рождения'),
                              Expanded(child: InputWidget(title: 'Дата рождения', showTitle: false, maxHeight: 50,))
                            ],
                          )
                      ),
                      const Expanded(
                          flex: 5,
                          child: SizedBox.expand()
                      ),
                      const Expanded(
                          flex: 100,
                          child: Column(
                            children: [
                              Text('Возраст'),
                              Expanded(child: InputWidget(title: 'Возраст', showTitle: false, maxHeight: 50,))
                            ],
                          )
                      ),
                    ],
                  )
              ),
              const Expanded(
                  flex: 20,
                  child: Align(
                    alignment: Alignment.centerLeft,
                      child: Text('Личная информация')
                  )
              ),
              const Expanded(
                  flex: 67,
                  child: InputWidget(title: 'Место проживания')
              ),
              const Expanded(
                  flex: 6,
                  child: SizedBox.expand()
              ),
              const Expanded(
                  flex: 67,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 180,
                          child: InputWidget(title: 'Гражданство')
                      ),
                      Expanded(
                          flex: 180,
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Готовы к переезду?', style: TextStyle(fontSize: 15),),
                              BusinessTripCheckWidget()
                            ],
                          )
                      )
                    ],
                  )
              ),
              const Expanded(
                  flex: 6,
                  child: SizedBox.expand()
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: gradientBack,
        child: BottomNavigationBar(
          onTap: (index){
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
              BottomNavigationBarItem(icon: Icon(CustomIcons.menu), label: 'list'),
              BottomNavigationBarItem(icon: Icon(CustomIcons.plus_1), label: 'plus'),
              BottomNavigationBarItem(icon: Icon(CustomIcons.profile), label: 'profile'),
            ]
        ),
      ),
    );
  }
}





