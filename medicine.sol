pragma solidity ^0.5.1;
contract details{
    struct medicine{
        uint mid;
        string name;
        uint manid;
        uint disid;
        uint rid;
        string mandate; // manfacture date
        string price;  
        string expdate;
        
        uint inhandoff;
    
    }
    mapping (uint=>medicine)medicines;
   
    uint[] stakeholders;
    
    
    struct manufacturer{ 
        uint manid;
        string manname;
        string mlocation;
         
        uint [] medicines;
                
    }
     mapping(uint=>manufacturer)manufacturers;
    
    
     
    struct distributer { 
        uint disid;
        string dname;
        string dlocation;
        uint []  medicines ;
                
    }
    
     mapping(uint =>distributer)distributers;
    
    struct retailer{ 
        uint rid;
        string rname;
        string rlocation;
        uint[]   medicines;
            
    }
    mapping(uint =>retailer)retailers;

function productdetails (uint _mid, string memory _name,string memory _mandate,string memory _expdate,string memory _price   )public{

    medicines[_mid].name= _name;
    medicines[_mid].mandate = _mandate;
    medicines[_mid].expdate = _expdate;
    medicines[_mid].price = _price;
    
}


function getdetails ( uint _mid) view public returns (string memory , uint ,uint, uint  ){
    return ( medicines[_mid].name,   medicines[_mid].manid ,  medicines[_mid].disid, medicines[_mid].rid );
}
   function distributerdetails( uint _disid , string memory _dname,string memory _dlocation)public{
     distributers[_disid].disid=_disid;
     distributers[_disid].dname=_dname;
     distributers[_disid].dlocation=_dlocation;
}  
 function getdistributerdetails(uint _disid) view public returns(uint,string memory,string memory){
     return(distributers[_disid].disid, distributers[_disid].dname, distributers[_disid].dlocation);
 }
                
  
function manufacturerdetails(uint _manid,string memory _manname,string memory _mlocation)public{
    manufacturers[_manid].manid=_manid;
     manufacturers[_manid].manname=_manname;
     manufacturers[_manid].mlocation=_mlocation;
          
}  
 function getmanufacturerdetails(uint _manid) view public returns(uint,string memory,string memory){
     return(manufacturers[_manid].manid, manufacturers[_manid].manname, manufacturers[_manid].mlocation);
 }
  function retdetails(uint _rid,string memory _rname,string memory _rlocation)public{
     retailers[_rid].rid=_rid;
     retailers[_rid].rname=_rname;
     retailers[_rid].rlocation=_rlocation;
}  
 function getretailerdetails (uint _rid) view public returns(uint,string memory,string memory){
     return(retailers[_rid].rid, retailers[_rid].rname, retailers[_rid].rlocation);
 }
                

 function mantodis (uint _id , uint _disid , uint _inhandoff ) public {
     
     medicines[_id].inhandoff = _disid;
     distributers[_id].medicines.push(_disid);
     
 }
 


function distoret (uint _id,uint _rid,uint _inhandoff ) public {
    medicines[_id].inhandoff = _rid;
     retailers[_id].medicines.push(_rid);
}
function getinhandoff (uint _id) view public returns( uint ){
  return (medicines[_id].mid);
} 
}
