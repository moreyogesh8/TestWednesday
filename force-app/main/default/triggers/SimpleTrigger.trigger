trigger SimpleTrigger on Account (/*before insert,
                                 after insert,before delete,after update,before update*/after update) {
    /*For(Account account : Trigger.new){
        System.debug(Account);
    }
    Contact con=[Select Name,Account.Name From Contact
                WHere AccountId IN : Trigger.New];
      System.debug(con.Name+' '+con.Account.Name);  
    Account aa = [Select Name from Account 
                  where id = '0017F00000bsHgL'];*/                                                                      
    Account aa = [Select Name from Account 
                  where id IN : Trigger.New];
    
    /*System.debug('Within after update event. Deleting - '+aa );                                
    aa.Rating='Warm';
    aa.Fax='0000000000'; */                                    
                                
    delete aa;                                     
}