import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rick_and_morty_api/view/theme/app_theme.dart';
import 'package:rick_and_morty_api/view/theme/text_styles.dart';
import 'package:rick_and_morty_api/view/widgets/custom_badge.dart';
import 'package:rick_and_morty_api/view/widgets/custom_button2.dart';
import 'package:rick_and_morty_api/view/widgets/custom_gradient.dart';

class CardStyle1 extends StatefulWidget {
  
  final String avatarImage;
  final String name;
  final String specie;
  final String status;
  final String origin;
  final double screenHeight;
  final double velocity;

  const CardStyle1({
    super.key,
    required this.avatarImage,
    required this.name,
    required this.specie,
    required this.status,
    required this.origin,
    required this.screenHeight,
    this.velocity = 50.0,
  });

  @override
  State<CardStyle1> createState() => _CardStyle1State();
}

class _CardStyle1State extends State<CardStyle1> {
  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 24.0, top: 32.0, right: 24.0, bottom: 32.0),
          height: (53.0 * widget.screenHeight) / 100.0,
          decoration: BoxDecoration(
            color: AppDarkTheme.black800,
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: Column(
            children: [
              SizedBox(
                width: 120.0,
                height: 120.0,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.avatarImage),
                   radius: 100.0,
                ),
              ),
              const SizedBox(height: 20.0,),
              Container(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: Text(
                  widget.name,
                  textAlign: TextAlign.center,
                  style: TextStyles.display1(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 5.0,),
              Text(
                widget.specie,
                textAlign: TextAlign.center,
                style: TextStyles.body1(color: AppDarkTheme.grayColor, fontWeight: TextStyles.fontWeightRegular),
              ),
              const SizedBox(height: 30.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [                  
                  Expanded(
                    flex: 2,
                    child: CustomBadge(
                      padding: const EdgeInsets.only(left: 12.0, top: 4.0, right: 12.0, bottom: 4.0),
                      icon: Icon(Icons.location_on, color: AppDarkTheme.pink400,),
                      label: Text(
                        '${widget.origin}   ',
                        style: TextStyles.body2(color: AppDarkTheme.pink400),
                      ),
                      borderLineColor: AppDarkTheme.pink400,
                    ),
                  ),
                  const SizedBox(width: 10.0,),
                  Expanded(
                    flex: 1,
                    child: CustomBadge(
                      padding: const EdgeInsets.only(left: 12.0, top: 4.0, right: 12.0, bottom: 4.0),
                      icon: ImageIcon(
                        const AssetImage('assets/icons/heart.png'),
                        color: widget.status == 'Dead' ? AppDarkTheme.red400 : AppDarkTheme.green500,
                      ),
                      label: Text(
                        '${widget.status}   ',
                        style: TextStyles.body2(color: widget.status == 'Dead' ? AppDarkTheme.red400 : AppDarkTheme.green500),
                      ),
                      borderLineColor: widget.status == 'Dead' ? AppDarkTheme.red400 : AppDarkTheme.green500,
                    ),
                  ),
                ]
              ),
              const SizedBox(height: 40.0,),

              CustomButton2(
                text: 'Ver perfil',
                onTap: () {
                  log('Hola');
                },
              ),
              
            ]
          ),
        ),
        const SizedBox(height: 40.0,)
      ]
    );
  }
}
