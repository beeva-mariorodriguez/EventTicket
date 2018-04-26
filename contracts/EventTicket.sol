pragma solidity ^0.4.18;
contract EventTicket {
    mapping(bytes32 => bool) public claimedTickets;
    uint16 public freeTickets;
    uint16 public totalSupply;
    string public name;
    constructor(uint16 initialSupply, string ticketName) public {
        totalSupply = initialSupply;
        freeTickets = totalSupply;
        name = ticketName;
    }
    function claimTicket(bytes32 eh) public {
        require(claimedTickets[eh] == false);
        require(freeTickets > 0);
        freeTickets--;
        if(freeTickets == 0){
            emit NoMoreTickets();
        }
        claimedTickets[eh] = true;
        emit TicketClaimed(eh);
    }
    function checkTicket(bytes32 eh) public view returns (bool) {
        return claimedTickets[eh];
    }

    event TicketClaimed(bytes32 eh);
    event NoMoreTickets();
}
