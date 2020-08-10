/**
 * Description: This is a trigger which eveluate account's 
 * AnnualRevenue, and if its more than 500000 will create a 
 * new Oppty
 *
 * Created By: Yogesh More
 * Created Date: 10/06/2017
 **/

trigger InsertDefaultOppty on Account (after insert) {
    TriggerUtility.insertOpportunity(Trigger.new);
}