import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/domain_crud/provider/domain_provider.dart';
import 'package:digi3map/screens/domain_crud/view/add_domain.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDomainListWidget extends StatelessWidget {
  final DomainProvider provider;
  const AddDomainListWidget({required this.provider,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      elevation: 10,
      color: ColorConstant.kGreyCardColor,
      child: InkWell(
        splashColor: Colors.blue,
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddDomain(
            provider: provider,
          )));
        },
        child: Container(
          height: 175,
          padding: const EdgeInsets.all(5),
          child: Image.asset(
            AssetsLocation.addDomainListLocation,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
