public with sharing class CTPersonController {
    //method to get the mobile number and return it with a token value(Using MD5 Algo)
    public static String getToken(String mobileNumber)
    {
        Blob value = Blob.valueOf(mobileNumber);
        Blob hash = Crypto.generateDigest('MD5',value);

        //get the string value of the hash block
        return EncodingUtil.base64Encode(hash);
    }
}
