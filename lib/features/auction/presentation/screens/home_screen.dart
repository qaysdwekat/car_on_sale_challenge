import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/string_extention.dart';
import '../../../../core/routes/route.dart';
import '../../../../generated/l10n.dart';
import '../../../../widgets/car_on_sale_widget.dart';
import '../bloc/auction_bloc.dart';
import '../bloc/auction_state.dart';
import '../bloc/events/logout_event.dart';
import '../bloc/events/search_by_vin_event.dart';
import '../bloc/widgets/vehicles_multiple_choices_bottom_sheet.dart';

class HomeScreen extends StatelessWidget {
  final AuctionBloc bloc;
  const HomeScreen({super.key, required this.bloc});

  AuctionBloc onCreate(BuildContext context) {
    return bloc;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: onCreate(context),
      child: BlocConsumer<AuctionBloc, AuctionState>(
        buildWhen: (previous, current) {
          final shouldBuild = [SearchByVinEvent].contains(current.eventType) || previous.vin != current.vin;
          return shouldBuild;
        },
        listener: (context, state) async {
          if (state is AuctionDetailsState) {
            context.goNamed(RouteList.auctionDetails, extra: state.details);
          }
          if (state is SessionExpiredState) {
            // Navigate to login screen
            context.replaceNamed(RouteList.login);
          } else if (state is ErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error ?? S.current.general_exception)));
          } else if (state is MultipleChoicesState) {
            final data = await VehiclesMultipleChoicesBottomSheet.showModal(context, state.vehicles);
            if (data?.externalId?.isNotEmpty == true) {
              bloc.add(SearchByVinEvent(data!.externalId!));
            }
          }
        },
        builder: (c, s) {
          return buildScreen(c, s);
        },
      ),
    );
  }

  Widget buildScreen(BuildContext context, AuctionState state) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              bloc.add(LogoutEvent());
            },
            icon: Icon(Icons.logout, color: Colors.white),
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Color(0xFF2F323E),
      body: CarOnSaleWidget(
        isLoading: state is LoadingState,
        title: S.current.check_vin_details,
        placeholder: S.current.vin,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return S.current.vin_required_error;
          }
          if (!value.isValidVin) {
            return S.current.vin_validation_error;
          }
          return null;
        },
        onPressed: (value) {
          bloc.add(SearchByVinEvent(value));
        },
        action: S.current.search,
      ),
    );
  }
}
