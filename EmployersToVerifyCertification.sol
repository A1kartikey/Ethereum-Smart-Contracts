pragma solidity ^0.8.3;
import "./student.sol";//include the same file name
contract Employer{  //contract name
   studentDetails s1 = studentDetails (0xd2a5bC10698FD955D1Fe6cb468a17809A08fd005);//s1 is an instance and copy the address of the imported file(Students_Univrsity.sol.sol)
constructor  () public {	//empty constructor
	}
function checkBgc(address vaddress) view public returns (string memory){
    if(s1.validateStudent(vaddress)){ //"validateStudent" is a function in students.sol
  	return "Valid";}
    	return "Invalid";
	}
}
