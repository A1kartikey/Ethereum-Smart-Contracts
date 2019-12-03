pragma solidity^0.5.1;

contract Vote{
    
    uint[]  candidateList;
    
      mapping (uint => uint)  votesReceived;


    function List (uint _id) public {
        
        candidateList.push(_id) ;
    }


    function printList()view  public returns (uint[] memory){
        
        return candidateList;
    }    
    
    function voteForCandidate(uint candidate) public {
    votesReceived[candidate] += 1;
  }

    function totalVotesFor(uint candidate) view  public returns (uint) {
    return votesReceived[candidate];
  }
    
    function validCandidate(uint candidate) view  public returns (bool) {
    for(uint i = 0; i < candidateList.length; i++) {
      if (candidateList[i] == candidate) {
        return true;
      }
    }
    return false;
  }
    
}
