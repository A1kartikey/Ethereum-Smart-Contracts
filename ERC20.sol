pragma solidity ^0.8.5;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract TokenContract is ERC20 {

    constructor ()ERC20('My Token','MNT'){
        _mint(msg.sender,1000 * 10 ** 18);
    }
}
