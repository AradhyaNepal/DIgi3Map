import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/data/services/services_names.dart';
import 'package:digi3map/screens/domain_crud/provider/domain_provider.dart';
import 'package:digi3map/screens/domain_crud/view/domain_view_edit_delete.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DomainListIntroWidget extends StatelessWidget {
  final Domain domain;
  final DomainProvider provider;
  const DomainListIntroWidget({
    required this.domain,
    required this.provider,
    Key? key
  }) : super(key: key);

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
                  builder: (context)=>DomainProfilePage(domain: domain,provider: provider,)
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
                  child: Image.network(
                    Service.baseApiNoDash+domain.imagePath,
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
                      child:Text(
                          domain.domainName,
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
