pragma solidity^0.4.24;

contract Supplycahin{
    

 struct item{
     
     uint id;
     string itemname;
     uint quantity;
     address owner;
     uint price;
     State state;
     address InhandOf;
 }  
 
    enum State {
    ForSale,
    Sold,
    Shipped,
    Received
  }
 
    uint[] public list;
 
    mapping (uint => item) items;
    
    
    modifier forSale (uint _id) {
        require(items[_id].state == State.ForSale);
            _;
  }
    modifier sold (uint _sku) {
    require(items[_sku].state == State.Sold);
            _;
  }
    modifier shipped (uint _sku) {
    require(items[_sku].state == State.Shipped);
    _;
  }
  modifier received (uint _sku) {
    require(items[_sku].state == State.Received);
    _;
  }
    
    modifier verifyCaller (address _address) {
    
        require (msg.sender == _address);
        _;
        
    }

  modifier paidEnough(uint _price) {
      require(msg.value >= _price);
      _;
      
      
  }
    
    
    function Additems(uint _id,string _itemname,uint _quantity,address _owner,uint _price) public{
        
    items[_id].id = _id;
    items[_id].itemname = _itemname;
    items[_id].quantity = _quantity;
    items[_id].owner = _owner;
    items[_id].price = _price;
    items[_id].state = State.ForSale;
    items[_id].InhandOf = _owner;
        list.push(_id) +1;
    }
    
    function Getitemlist(uint _id) public constant returns (uint,string,uint,address,uint){
    return (   items[_id].id,
    items[_id].itemname,
    items[_id].quantity,
    items[_id].owner,
    items[_id].price);

    }
    
    function PrintAlllsit() constant public returns (uint[]){
        return list;
        
    }
    
    
    
}
