public class buy {
    
    public String str {get; set;}
    
    Contact contact;
    public Contact getContact() {
        if (contact == null) {
            contact = new Contact();
        }
        return contact;
    }
    
    public List<Order_Table__c> order {get; set;}
       
    public String paramPage {get; set;}
    
    public List<Product_Table__c> product {get; set;}
  
    public buy() {
        str = String.valueOf(0);
        paramPage = ApexPages.currentPage().getParameters().get('name');
        product = [SELECT Id, Image_Url__c, Name, Product_Description__c, Units_Available__c, Unit_Price__c FROM Product_Table__c WHERE Name =: paramPage]; 
    }
    
    public PageReference remove(){
        return null;
    }
     
    public PageReference end(){
        List<Contact> listContact = [SELECT Id, FirstName, LastName, Email FROM Contact WHERE Email=:contact.email];
        If (listContact.size() == 0) {
            insert contact;
            Order_Table__c newOrder = new Order_Table__c(Product__c = product.get(0).Id, Units__c = Integer.valueOf(str), Order_Amount__c = Integer.valueOf(str)*product.get(0).Unit_Price__c , Contact__c = contact.id);
            insert newOrder;
            If (product.get(0).Units_Available__c -Integer.valueOf(str) < 0) {
                delete newOrder;
            }
            Else {
                product[0].Units_Available__c = product[0].Units_Available__c - Integer.valueOf(str);
                update product;
            }
            return null;
        }
        Else {
            listContact[0].firstName = contact.firstName;
            listContact[0].lastName = contact.lastName;
            Order_Table__c newOrder = new Order_Table__c(Product__c = product.get(0).Id, Units__c = Integer.valueOf(str), Order_Amount__c = Integer.valueOf(str)*product.get(0).Unit_Price__c , Contact__c = contact.Id);
            insert newOrder;
            update listContact;
            If (product.get(0).Units_Available__c -Integer.valueOf(str) < 0) {
                delete newOrder;
            }
            Else {
                product[0].Units_Available__c = product[0].Units_Available__c - Integer.valueOf(str);
                update product;
            }
            return null;
        }
    }
    
    public PageReference toShop() {
        PageReference ref1 = new PageReference ('/apex/FirstVFPage');
        return ref1;
    }
}