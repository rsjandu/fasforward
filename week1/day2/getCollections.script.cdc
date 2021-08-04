import Artist from 0x02
/*
//W1d2Q4
Run the CreateCollectionReferenceTransaction.cdc
 transaction script for all accounts 1-5 before running this script. 

*/
pub fun main() {
  
  let accounts = [
    getAccount(0x01) ,
    getAccount(0x02) ,
    getAccount(0x03) ,
    getAccount(0x04) ,
    getAccount(0x05) ]

  for account in accounts {
    log(account)
        
         let colRef = getAccount(account.address)
                    .getCapability(/public/ArtistPictureCollection)
                    .borrow<&Artist.Collection>()
                    ?? panic("Couldn't borrow refrence to Collection")
      
      if (colRef != nil){
          var index = 0
          var length  = colRef.myPictures.length
          log("No. of Pictures Stored for account : ".concat(account.address.toString()).concat(" - is : ")
                                                    .concat(colRef.myPictures.length.toString())) 
          while(index < length){
              colRef.myPictures[index].display(canvas: colRef.myPictures[index].canvas) //use already created display method to get picture and canvas
            index = index+1
          }        
      }
      else{
            log("Panic occured.....Refrence failure")
      }
    }
}
