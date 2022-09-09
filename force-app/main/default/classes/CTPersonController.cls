public with sharing class CTPersonController {
    //method to get the mobile number and return it with a token value(Using MD5 Algo)
    public static String getToken(String mobileNumber)
    {
        Blob value = Blob.valueOf(mobileNumber);
        Blob hash = Crypto.generateDigest('MD5',value);

        //get the string value of the hash block
        return EncodingUtil.base64Encode(hash);
    }
    //method to get the recent changes in the health status of the person__c records(Limit to 100).
    public static List<Person__c> getRecentHealthChanges()
    {
        return [SELECT Id, Name, Status_Update_Date__c, Health_Status__c,  Mobile__c, Token__c 
                FROM  Person__c 
                ORDER BY Status_Update_Date__c 
                DESC NULLS LAST LIMIT 100];
    }
    //method to get the list of person__c records on search result.
    public static List <Person__c> searchPeople(String searchTerm)
    {
        searchTerm =searchTerm+'%';
        return [SELECT Id, Name, Status_Update_Date__c, Health_Status__c,  Mobile__c, Token__c 
                FROM  Person__c WHERE Name LIKE :searchTerm 
                OR Mobile__c LIKE :searchTerm OR Token__c LIKE :searchTerm 
                ORDER BY Status_Update_Date__c DESC NULLS LAST];
    }
    //method to get the person__c record from an Id. 
    public static Person__c getPersonById(String personId)
    {
        List<Person__c> people = [SELECT Id, Name, Status_Update_Date__c, Health_Status__c,  Mobile__c, Token__c 
                                    FROM  Person__c WHERE Id =:personId];
            if(people!= null && people.size()>0)
            {
                return people[0];
            }
        return null;
    }
}
