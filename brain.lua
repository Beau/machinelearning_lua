local luann = require("luann")

function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

Brain = {}

function Brain:new()
  local this = {}

  this.initialize = function()
      local learningRate = 50 -- set between 1, 100
      local attempts = 10000 -- number of times to do backpropagation
      local threshold = 1 -- steepness of the sigmoid curve

      --create a network with 2 inputs, 4 hidden cells, and 1 output
      this.network = luann:new({2, 4, 1}, learningRate, threshold)

      --run backpropagation (bp)
      for i = 1,attempts do
        this.network:bp({1,0}, {0})
        this.network:bp({0,1}, {1})
      	-- this.network:bp({0,1},{0})
      	-- this.network:bp({1,0},{1})
      	--this.network:bp({0,1},{1})
      	--this.network:bp({1,1},{1})
      end

      --print the signal of the single output cell when :activated with different inputs
      -- print("Results:")
      -- this.network:activate({0,0})
      -- print("0 0 | " .. this.network[3].cells[1].signal)
      -- this.network:activate({0,1})
      -- print("0 1 | " .. this.network[3].cells[1].signal)
      -- this.network:activate({0.2,0})
      -- print("1 0 | " .. this.network[3].cells[1].signal)
      --this.network:activate({0,0})
      print(this.network[3].cells[1].signal)
    end

    this.save = function(filename)
      luann:saveNetwork(this.network, filename)
    end

    this.load = function(filename)

      if (file_exists(filename)) then
        --Load the network from a file
        this.network = luann:loadNetwork(filename)

        --run the loaded network
        print("Results after:")
        this.network:activate({0,0})
        print("Output of 0,0: " .. newNetwork[3].cells[1].signal)
        this.network:activate({0,1})
        print("Output of 0,1: " .. newNetwork[3].cells[1].signal)
        this.network:activate({1,0})
        print("Output of 1,0: " .. newNetwork[3].cells[1].signal)
        this.network:activate({1,1})
        print("Output of 1,1: " .. newNetwork[3].cells[1].signal)
    end
  end

  return this
end
