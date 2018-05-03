App = {
  web3Provider: null,
  contracts: {},

  init: function() {

    return App.initWeb3();
  },

  initWeb3: function() {

    // Is there an injected web3 instance?
    if (typeof web3 !== 'undefined') {
      App.web3Provider = web3.currentProvider;
    } else {
      // If no injected web3 instance is detected, fall back to Ganache
      App.web3Provider = new Web3.providers.HttpProvider('http://localhost:9545');
    }
    web3 = new Web3(App.web3Provider);


    return App.initContract();
  },

  initContract: function(){

    $.getJSON('EventTicket.json', function(data) {
      
      var EventTicketArtifact = data;
      App.contracts.EventTicket = TruffleContract(EventTicketArtifact);
    
      App.contracts.EventTicket.setProvider(App.web3Provider);
   
      return ;
    });

    return App.bindEvents();
  },

  bindEvents: function() {
      $(document).on('click', '.btn-claimTicket', App.claimTicket);
      $(document).on('click', '.btn-freeTicket', App.freeTicket);
    
  },




  freeTicket: function(event){

    event.preventDefault();
    web3.eth.getAccounts(function(error, accounts) {
      if (error) {
        alert(error);
        console.log(error);
      }
    
      var account = accounts[0];

      App.contracts.EventTicket.deployed().then(function(instance) {
        
        return instance.freeTicket(document.getElementById("ticketHash").value,{from: account});

      }).then(function(result) {
         for (var i = 0; i < result.logs.length; i++) {
             var log = result.logs[i];

             console.log(log);

             if (log.event == "TicketFreed") {
               alert("Freed Ticket!");
               break;
             }
             
  }
      }).catch(function(err) {
        alert("Ticket couldn't be freed")
        console.log(err);
      });
    });

  },



  claimTicket: function(event){

    event.preventDefault();

    web3.eth.getAccounts(function(error, accounts) {
      if (error) {
        alert(error);
        console.log(error);
      }
    
      var account = accounts[0];


      App.contracts.EventTicket.deployed().then(function(instance) {
        
        return instance.claimTicket(sha256(document.getElementById("email").value), {from: account});
      }).then(function(result) {
         for (var i = 0; i < result.logs.length; i++) {
             var log = result.logs[i];

             console.log(log);
             if (log.event == "NoMoreTickets") {
               alert("No tickets available!");
               break;
             }
             
             if (log.event == "TicketClaimed") {
               alert("Ticket hash "+log.args.eh);
               break;
             }


  }
      }).catch(function(err) {
        alert("Ticket couldn't be claimed")
        console.log(err.message);
      });
    });

  

   }


};

$(function() {
  $(window).load(function() {
    App.init();
  });
});
