pragma solidity ^0.4.18;
import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/EventTicket.sol";
contract TestEventTicket {
    EventTicket et = EventTicket(DeployedAddresses.EventTicket());
	function testUserCanClaimTicket() public {
        bytes32 eh = sha256("user1@example.com");
        bytes32 ret = et.claimTicket(eh);
        Assert.equal(eh, ret, "TestUserCanClaimTicket() failed");
	}
	function testCheckClaimedTicket() public {
        bytes32 eh = sha256("user2@example.com");
        et.claimTicket(eh);
        bool ret = et.checkTicket(eh);
        Assert.equal(ret, true, "TestCheckClaimedTicket() failed");
	}
	function testCheckUnclaimedTicket() public {
        bytes32 eh = sha256("user3@example.com");
        bool ret = et.checkTicket(eh);
        Assert.equal(ret, false, "TestCheckUnclaimed() failed");
	}
    function testUserCanFreeTicket() public {
        bytes32 eh = sha256("user4@example.com");
        et.claimTicket(eh);
        bool ret = et.checkTicket(eh);
        Assert.equal(ret, true, "TestUserCanFreeTicket() failed: could not claim ticket");
        et.freeTicket(eh);
        ret = et.checkTicket(eh);
        Assert.equal(ret, false, "TestUserCanFreeTicket() failed: checkTicket() should return false");
    }
}

