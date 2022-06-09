import 'package:catering/models/global_organization.dart';
import 'package:catering/widgets/organization/global_organization_card.dart';
import 'package:flutter/material.dart';

class GlobalOrganizationsListingScrenn extends StatelessWidget {
  static const String routeName = '/global-organizations-listing';

  final List<GlobalOrganization> globalOrganizations;

  const GlobalOrganizationsListingScrenn({ 
    Key? key,
    required this.globalOrganizations
  }) : super(key: key);

  static Route route({required List<GlobalOrganization> globalOrganizations}) {
    return MaterialPageRoute(
      builder: (_) => GlobalOrganizationsListingScrenn(globalOrganizations: globalOrganizations),
      settings: RouteSettings(name: routeName),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.white30,
                blurRadius: 3.0,
              )
            ],
            color: Theme.of(context).colorScheme.background
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppBar(
                automaticallyImplyLeading: false, 
                elevation: 0,
                titleSpacing: 0,
                centerTitle: true,
                backgroundColor: Theme.of(context).colorScheme.background,
                leading: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  )
                ),
                title: Text(
                  "Организации",
                  style: Theme.of(context).textTheme.headline3!.copyWith(color: Color(0xFF8C9099)),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: globalOrganizations.length,
          itemBuilder: (context, index) {
            return GlobalOrganizationCard(globalOrganization: globalOrganizations[index]);
          }
        )
      )
    );
  }
}