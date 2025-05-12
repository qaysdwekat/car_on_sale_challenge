import 'abstract_auction_event.dart';

class SearchByVinEvent extends AbstractAuctionEvent {
  
  final String vin;
  
  SearchByVinEvent(this.vin);
}
