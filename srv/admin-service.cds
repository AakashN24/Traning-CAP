using {incident.mgmt.db as db} from '../db/schema';

service AdminService {
   
   entity IncidentsEntity as projection on db.Incidents{
      *
   }actions{
      action IncidentReview(customerID: String) returns String;
   };
   entity Customers       as projection on db.Customers;
   action getIncidents(); 

   
}
