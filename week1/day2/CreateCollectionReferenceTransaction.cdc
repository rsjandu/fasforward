import Artist from 0x02

transaction { 
  prepare(account: AuthAccount){
  log(account.address)
      let collection <- Artist.createCollection()
            account.save(
          <- collection, 
          to: /storage/ArtistPictureCollection)

          account.link<&Artist.Collection>(
            /public/ArtistPictureCollection,
            target: /storage/ArtistPictureCollection)
   }

  execute {
    log(self.getType())
  }
}
