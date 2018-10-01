pragma solidity^0.4.19;

contract Vote{
    
    address[]  candidateList;
    
      mapping (address => uint)  votesReceived;

        address owner;

        modifier ifOwner() {
        require (owner == msg.sender);
            _;
        }


    function List (address _address) public {
        
        candidateList.push(_address)  -1;
    }


    function printList()view  public returns (address[]){
        
        return candidateList;
    }    
    
    function voteForCandidate(address candidate) public {
    votesReceived[candidate] += 1;
  }

    function totalVotesFor(address candidate) view  public returns (uint) {
    return votesReceived[candidate];
  }
    
    function validCandidate(address candidate) view  public returns (bool) {
    for(uint i = 0; i < candidateList.length; i++) {
      if (candidateList[i] == candidate) {
        return true;
      }
    }
    return false;
  }
    
}


