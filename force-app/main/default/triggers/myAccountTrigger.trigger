trigger myAccountTrigger on Account (before delete,before insert,before update,
                                    after delete,after insert,after update){
                                        if(Trigger.isBefore){
                                            if(Trigger.isDelete){
                                                System.debug('Within before delete trigger');
                                                for(Account a:Trigger.old){
                                                    /*if(a.Name != 'okToDelete'){
                                                        a.addError('You Can\'t delete this record!');
                                                    }*/
                                                }
                                            }else{
                                                System.debug('You are within beforeupdate trigger');
                                                for(Account a:Trigger.new){
                                                    if(a.name == 'Bad'){
                                                        a.name.addError('BAd NAme');
                                                    }
                                                }
                                                if(Trigger.isInsert){
                                                    System.debug('You are within beforeinsert trigger');
                                                }else{
                                                    System.debug('YOu are in after trigger');
                                                }  
                                            }
                                        }
}