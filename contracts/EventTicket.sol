pragma solidity ^0.4.18;
contract EventTicket {
    mapping(bytes32 => bool) public claimedTickets;
    uint16 public freeTickets;
    uint16 public totalSupply;
    string public name;
    constructor() public {
        totalSupply = 2;
        freeTickets = totalSupply;
        name = "TCK";
    }
    function claimTicket(bytes32 eh) public {
        require(claimedTickets[eh] == false);
        require(freeTickets > 0);
        freeTickets--;
        claimedTickets[eh] = true;
    }
    function checkTicket(bytes32 eh) public view returns (bool) {
        return claimedTickets[eh];
    }
}
