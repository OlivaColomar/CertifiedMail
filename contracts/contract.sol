pragma solidity ^0.4.11;

contract CertifiedMail {
   
   //Parties involved 
    address sender;
    address receiver;
    address ttp;

    string hB; //NRR proof
    string hBt; //Intervention proof
    
    //Possible states
    enum State { created, cancelled, finished }
    State public state;
    
    function CertifiedMail (address _sender, address _receiver){
        ttp = msg.sender;
        sender = _sender;
        receiver = _receiver;
        state = State.created;
        }


    event stateInfo(
        State state
        );
        
    function abort() returns (string) {
         if(msg.sender==sender){
             if(state==State.created){
                 state=State.cancelled;
                 //return abort token???
                 stateInfo(state);
             }else if (state == State.finished){
                 return hB;
             }
         }
    }
    
    function Resolve(string _hB, string _hBt) returns (State) {
        if (msg.sender==ttp){
            if(state==State.cancelled){
                return state;
            }else{
                hB=_hB;
                hBt=_hBt;
                state=State.finished;
            }
        }
    }
    
    function getState() returns (string){
        if(state==State.cancelled) return "cancelled";
        if(state==State.created) return "created";
        if(state==State.finished) return "finished";
    }
}