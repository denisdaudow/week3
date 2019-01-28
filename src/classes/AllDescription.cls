public class AllDescription {

    public String paramPage {get; set;}
    
    public List<Product_Table__c> product {get; set;}
    
    public AllDescription() {
    
    paramPage = ApexPages.currentPage().getParameters().get('name');
    product = [SELECT Image_Url__c, Name, Product_Description__c, Units_Available__c FROM Product_Table__c WHERE Name =: paramPage];    
    }
    
    public PageReference toShop() {
        PageReference ref1 = new PageReference ('/apex/FirstVFPage');
        return ref1;
    }
    
    public PageReference buyProduct() {
        PageReference ref2 = new PageReference ('/apex/buy?name='+paramPage);
        return ref2;
    }
}