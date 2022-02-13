import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/domain_crud/view/domain_view_edit_delete.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class DomainListIntroWidget extends StatelessWidget {
  const DomainListIntroWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      elevation: 10,
      color: ColorConstant.kGreyCardColor,
      child: InkWell(
        splashColor: Colors.blueAccent,
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context)=>DomainProfilePage()
              )
          );
        },
        child: Container(
          height: 175,
          padding: const EdgeInsets.all(5),
          child: Stack(
            children: [
              Positioned.fill(
                child: Opacity(
                  opacity:0.6,
                  child: Image.asset(
                    AssetsLocation.anonymousImageLocation,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned.fill(
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                      child: Text(
                          "Dummy",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Styles.mediumHeading
                        ,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
