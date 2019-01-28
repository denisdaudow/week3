public class FirstVFPage {  
    
    public String probel {get; set;} 
    
    public List<Product_Table__c> product {get; set;}
   
    public FirstVFPage() {
       probel = '     ';
       product = [SELECT Image_Url__c, Name, Product_Description__c, Unit_Price__c FROM Product_Table__c WHERE Image_Url__c <> ''];
       for (Integer i = 0; i < product.size(); i++) {
           If (product.get(i).Product_Description__c.length() > 1) {
           product.get(i).Product_Description__c = product.get(i).Product_Description__c.left(100);
           }
       }
    }
}