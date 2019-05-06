pragma solidity ^0.5.1;
import "browser/students.sol";//include the same file name
contract Employer{  //contract name
   studentDetails s1 = studentDetails (0xef55BfAc4228981E850936AAf042951F7b146e41);//s1 is an instance and copy the address of the imported file(Students_Univrsity.sol.sol)
constructor  () public {	//empty constructor
	}
function checkBgc(address vaddress) view public returns (string memory){
    if(s1.validateStudent(vaddress)){ //"validateStudent" is a function in students.sol
  	return "Valid";}
    	return "Invalid";
	}
}
