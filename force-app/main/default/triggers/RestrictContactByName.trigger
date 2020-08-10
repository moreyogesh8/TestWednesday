trigger RestrictContactByName on Contact (before insert, before update) {
    //Check contacts prior to insert or update invalid data
    for(Contact con : trigger.new){
        if(con.LastName == 'INVALIDNAME'){
            con.addError('The Last Name '+con.LastName+' is not allowed for DML');
        }
    }
}