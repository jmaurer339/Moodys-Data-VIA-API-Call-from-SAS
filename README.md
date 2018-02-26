# Moodys-Data-VIA-API-Call-from-SAS

Since 2016 Moody’s Economic data has been accessible not only through a web based UI but through an API as well. Documentation on how to structure calls to Moody’s via API is pretty good; examples of API calls from Java, R, and Python are provided by Moody’s. However Moody’s does not provide an example or a template for accessing their API via SAS. The files in this repo provide such examples. 

API calls from SAS are facilitated by PROC HTTP. The execution of this procedure is fairly straight-forward not only for Moody’s but for a wide variety of API calls. The task of accessing Moody’s data specifically via an API call from SAS is complicated by the need to provide Moody’s an encrypted AccessKey. 

Prior to SAS 9.4 the encrypted keys that Moody’s requires to accompany an API request could not be created in a straight-forward manner in SAS. Most pre 9.4 examples illustrated the use of Java based encryption routines accessed via Groovy and executed within SAS by PROC GROOVY. 
With SAS9.4 two functions easily provide the necessary level of encryption to enable the creation of the required keys. The required HMAC/SHA256 encryption is provided by the SHA256HMACHEC function. Additionally the TZONES2U function that converts date/time values to UCT is also useful. 

IMPORTANT NOTE: Moody’s data are not publically available. Moody’s data are provided to organizations for a fee. Therefore, individuals or organizations that do not have an existing account with Moody’s will not be able to access these data via API or any other method. Additionally, the following examples assume/require knowledge of the (paying) users ACCESS and ENCRYPTION keys provided by Moody’s. These keys can be found on the users Moody’s account pages. 

The following files provide examples of completing four different tasks by calling the Moody’s API from SAS. The first retrieves a single, specified Moody’s mnemonic (variable). The second retrieves a list of baskets available on the users account. The third illustrates running/executing/creating a particular basket on the Moody’s site. The fourth retrieves the data associated with that basket. 
Three of the examples use GET requests. The third example uses a POST. All examples call the %moody_encrpt macro. Code for this macro is provided in the first file. In order to execute the subsequent four pieces of code, the %moody_encrpt macro needs to be loaded into the SAS work area.  
