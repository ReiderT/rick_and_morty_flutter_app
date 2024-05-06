import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_api/model/character_model.dart';
import 'package:rick_and_morty_api/view/theme/app_theme.dart';
import 'package:rick_and_morty_api/view/theme/text_styles.dart';
import 'package:rick_and_morty_api/view/widgets/custom_badge.dart';
import 'package:rick_and_morty_api/view/widgets/custom_button2.dart';
import 'package:rick_and_morty_api/viewmodel/navigation_view_model.dart';


class CardStyle1 extends StatefulWidget {
   
  final CharacterModel character;
  final double screenHeight;
  final double velocity;
  final bool? isBadges;
  final String originPage;

  const CardStyle1({
    super.key,
    required this.character,
    required this.screenHeight,
    this.velocity = 50.0,
    this.isBadges = false,
    required this.originPage,
  });

  @override
  State<CardStyle1> createState() => _CardStyle1State();
}

class _CardStyle1State extends State<CardStyle1> {
  @override
  Widget build(BuildContext context) {
    double cardHeight = !widget.isBadges! ? 45.0 : 53.0; 

    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 24.0, top: 32.0, right: 24.0, bottom: 32.0),
          height: (cardHeight * widget.screenHeight) / 100.0,
          decoration: BoxDecoration(
            color: AppDarkTheme.black800,
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: Column(
            children: [
              Hero(
                tag: 'character_avatar_${widget.character.id}',
                child: SizedBox(
                  width: 120.0,
                  height: 120.0,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.character.image),
                     radius: 100.0,
                  ),
                ),
              ),
              const SizedBox(height: 20.0,),
              Container(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: Text(
                  widget.character.name,
                  textAlign: TextAlign.center,
                  style: TextStyles.display1(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 5.0,),
              Text(
                widget.character.species.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyles.body1(color: AppDarkTheme.grayColor, fontWeight: TextStyles.fontWeightRegular),
              ),

              !widget.isBadges! ? const SizedBox(height: 1.0,) 
              : Column(
                children: [
                  const SizedBox(height: 30.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [                  
                      CustomBadge(
                        padding: const EdgeInsets.only(left: 12.0, top: 4.0, right: 12.0, bottom: 4.0),
                        icon: Icon(Icons.location_on, color: AppDarkTheme.pink400,),
                        label: Text(
                          '${widget.character.origin.name}   ',
                          style: TextStyles.body2(color: AppDarkTheme.pink400),
                        ),
                        borderLineColor: AppDarkTheme.pink400,
                        width: widget.character.origin.name.length < 14 ? null : 150.0,
                      ),
                      const SizedBox(width: 10.0,),
                      CustomBadge(
                        padding: const EdgeInsets.only(left: 12.0, top: 4.0, right: 12.0, bottom: 4.0),
                        icon: ImageIcon(
                          const AssetImage('assets/icons/heart.png'),
                          color: widget.character.status == 'Dead' ? AppDarkTheme.red400 : AppDarkTheme.green500,
                        ),
                        label: Text(
                          '${widget.character.status}   ',
                          style: TextStyles.body2(color: widget.character.status == 'Dead' ? AppDarkTheme.red400 : AppDarkTheme.green500),
                        ),
                        borderLineColor: widget.character.status == 'Dead' ? AppDarkTheme.red400 : AppDarkTheme.green500,
                      ),
                    ]
                  ),
                ],
              ),
              
              const SizedBox(height: 40.0,),

              CustomButton2(
                text: 'Ver perfil',
                onTap: () {
                  Provider.of<NavigationProvider>(context, listen: false).origin = widget.originPage;
                  context.push('/character_profile', extra: widget.character,);
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
