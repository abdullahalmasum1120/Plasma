import 'package:bloc/bloc.dart';
import 'package:blood_donation/data/model/received_request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'requests_event.dart';

part 'requests_state.dart';

class RequestsBloc extends Bloc<RequestsEvent, RequestsState> {
  RequestsBloc() : super(FetchedDataState([])) {
    on<FetchRequestEvent>((event, emit) async {
      List<ReceivedRequest> requests = [];
      QuerySnapshot<Map<String, dynamic>> documents;
      if (event.lastRequest != null) {
        documents = await FirebaseFirestore.instance
            .collection("fetchedRequests")
            .startAfterDocument(
                event.lastRequest!.toJson() as QueryDocumentSnapshot)
            .limit(event.limit)
            .get();
      } else {
        documents = await FirebaseFirestore.instance
            .collection("fetchedRequests")
            .limit(event.limit)
            .get();
      }
      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in documents.docs) {
        requests.add(ReceivedRequest.fromJson(doc as Map<String, dynamic>));
      }
      emit(FetchedDataState(requests));
    });
  }
}
