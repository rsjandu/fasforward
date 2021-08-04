//W1d2Q3

pub contract Artist
{ 
  pub struct Canvas {

    pub let width: UInt8
    pub let height: UInt8
    pub let pixels: String

    init(width: UInt8, height: UInt8, pixels: String) {
      self.width = width
      self.height = height
      // The following pixels
      // 123
      // 456
      // 789
      // should be serialized as
      // 123456789git
      self.pixels = pixels
    }
  }

  pub resource Picture {
    pub let canvas: Canvas
    
    init(canvas: Canvas) {
      self.canvas = canvas
    }


      pub fun createFrameborder(canvas: Canvas): String {
          var border: String = ""
          var borderEdge: String = "+"
          var borderWidth: UInt8 = 0
        // log(canvas.width)

          while borderWidth < canvas.width {
              borderEdge = borderEdge.concat("-")
              //log(borderEdge)
              borderWidth = borderWidth+1
          }

          borderEdge = borderEdge.concat("+")
          border = border.concat(borderEdge)
          log(border)
          return border
      }

      pub fun deSerializeLetter(_ line: String) {
          var letter:String = ""
          var row: UInt8 = 0
          var deSerializedLine:String=""
          var frameEdge: String="|"

          while row < self.canvas.height
                  {
                      var startIndex:Int = Int(row)*Int(self.canvas.width)
                      var endIndex:Int = Int(row+1)*Int(self.canvas.width)
                      deSerializedLine = line.slice(from: startIndex, upTo: endIndex)
                      letter = frameEdge.concat(deSerializedLine).concat(frameEdge)
                      log(letter)
                      row = row+1
                  }
      }


    pub fun display(canvas: Canvas){
              
          self.createFrameborder(canvas: canvas)
          self.deSerializeLetter(canvas.pixels)
          self.createFrameborder(canvas: canvas)
              
    }
  }

  pub fun serializeStringArray(_ lines: [String]): String {
    var buffer = ""
    for line in lines {
      buffer = buffer.concat(line)
    }

    return buffer
  }

  pub resource Printer {
    pub var printLog: {String: Canvas}
    
    init() {
      self.printLog = {}
    }

  
    pub fun print(canvas: Canvas): @Picture? {

      if (!self.printLog.containsKey(canvas.pixels)) {
      
        let picture <- create Picture(canvas: canvas)
        self.printLog[canvas.pixels] = canvas
        //log(self.printLog)
        picture.display(canvas: canvas)
        
      return <- picture

      }else {
        log("This Canvas has already been printed so not Displaying......!!");
        return nil
      }
    }
  }

  pub resource Collection {

        pub var myPictures: @[Picture] 

        init(){
          self.myPictures <- []
        }

        pub fun deposit(picture: @Picture) {
          self.myPictures.append(<- picture)
        }

        access(all) fun getCanvases(): [Canvas]{
          var allCanvases:[Canvas] = []
          var index = 0
          while (index < self.myPictures.length)  {
            allCanvases.append(self.myPictures[index].canvas)
            index = index + 1
          }
            return allCanvases
        }

        destroy(){
          destroy self.myPictures
        }
    
  }
  
  pub fun createCollection(): @Collection{
    return <- create Collection()
  }

  pub init()
  {
    //printer resource
    self.account.save(
      <- create Printer(), 
      to: /storage/ArtistPicturePrinter)
      
      // capability exposing it
    self.account.link<&Printer>(
      /public/ArtistPicturePrinter,
      target: /storage/ArtistPicturePrinter)

  }
  

}
