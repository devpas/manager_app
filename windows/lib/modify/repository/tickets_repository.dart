import '../../src/core/handlers/handlers.dart';
import '../../modify/models/models.dart';

abstract class TicketsRepository {
  Future<dynamic> createTicket(
      TicketData ticket, String fileOrdersId, int reason);
  Future<dynamic> moveProduct(TicketData ticket, int send, int take);
  Future<ApiResult<TicketsResponse>> searchTickets(dynamic queryParam);
}
