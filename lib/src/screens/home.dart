import '../../config/ui_icons.dart';
import '../models/category.dart';
import '../models/utilities.dart';
import '../widgets/CategoriesIconsContainerWidget.dart';
import '../widgets/CategorizedUtilitiesWidget.dart';
import '../widgets/HomeSliderWidget.dart';
import 'package:flutter/material.dart';
import '../widgets/PopularLocationCarouselWidget.dart';
import '../widgets/SearchBarHomeWidget.dart';
class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> with SingleTickerProviderStateMixin {
  List<Utilitie> _utilitiesOfCategoryList=[];
  List<Utilitie> _utilitiesfBrandList=[];
  CategoriesList _categoriesList = new CategoriesList();
  UtilitiesList _utilitiesList = new UtilitiesList();

  Animation<double>? animationOpacity;
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    CurvedAnimation curve = CurvedAnimation(parent: animationController!, curve: Curves.easeIn);
    animationOpacity = Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });

    animationController!.forward();

    _utilitiesOfCategoryList = _categoriesList.list.firstWhere((category) {
      return category.selected;
    }).utilities;

    //_utilitiesfBrandList = _brandsList.list.firstWhere((brand) {
      //return brand.selected;
    //}).utilities;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              HomeSliderWidget(),
              Container(
                margin: const EdgeInsets.only(top: 150,bottom: 20),
                padding: const EdgeInsets.only(right: 20,left: 20),
                child: SearchBarHomeWidget(),
            ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(right: 2,left: 2),
            child: CategoriesIconsContainerWidget(categoriesList: _categoriesList,)
          ),
          Padding( 
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child:Column(
              children: <Widget>[
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  leading: Icon(
                    UiIcons.favorites,
                    color: Theme.of(context).hintColor,
                  ),
                  title: Text(
                    'Popular',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ],
            ) 
            
        ),
          PopularLocationCarouselWidget(heroTag: 'home_flash_sales', utilitiesList: _utilitiesList.popularList),
          Padding( 
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child:Column(
              children: <Widget>[
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  leading: Icon(
                    UiIcons.box,
                    color: Theme.of(context).hintColor,
                  ),
                  title: Text(
                    'Recent',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ],
            ) 
            
        ),
          CategorizedUtilitiesWidget(animationOpacity : animationOpacity ,utilitiesList: _utilitiesList.recentList,)
        ],
      )
    );
  }
}
