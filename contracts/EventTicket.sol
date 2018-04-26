pragma solidity ^0.4.18;
contract EventTicket {
    mapping(bytes32 => bool) public claimedTickets;
    uint16 public availableTickets;
    uint16 public totalSupply;
    string public name;
    constructor() public {
        totalSupply = 2;
        availableTickets = totalSupply;
        name = "TCK";
    }
    function claimTicket(bytes32 eh) public {
        require(claimedTickets[eh] == false);
        require(availableTickets > 0);
        availableTickets--;
        if(availableTickets == 0){
            emit NoMoreTickets();
        }
        claimedTickets[eh] = true;
        emit TicketClaimed(eh);
    }
    function checkTicket(bytes32 eh) public view returns (bool) {
        return claimedTickets[eh];
    }
    function freeTicket(bytes32 eh) public {
        require(claimedTickets[eh] == true);
        claimedTickets[eh] = false;
        emit TicketFreed(eh);
        availableTickets++;
        claimedTickets[eh] = false;
    }

    event TicketClaimed(bytes32 eh);
    event TicketFreed(bytes32 eh);
    event NoMoreTickets();
}
