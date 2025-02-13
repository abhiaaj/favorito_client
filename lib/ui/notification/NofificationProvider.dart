import 'package:favorito_user/Providers/BaseProvider.dart';
import 'package:favorito_user/model/appModel/OffersModel.dart';
import 'package:favorito_user/services/APIManager.dart';

class NotificationProvider extends BaseProvider {
  List<Data> offersListData = [];
  bool isLoading = false;
  NotificationProvider() {
    userOfferList();
  }
  void setLoading(bool val) {
    isLoading = val;
    notifyListeners();
  }

  void userOfferList() async {
    setLoading(true);
    await APIManager.getOffers().then((value) {
      setLoading(false);
      offersListData.clear();
      if (value.status == 'success') {
        offersListData.addAll(value.data);
        print("offerslength: ${offersListData.length}");
        notifyListeners();
      }
    });
  }

  void updateOfferstatus(index) async {
    await APIManager.updateOffers(
        {"offerid": offersListData[index].id, "offer_Status": 1}).then((value) {
      if (value.status == 'success') {
        offersListData[index].offerStatus = "1";
        notifyListeners();
      }
    });
  }
}
