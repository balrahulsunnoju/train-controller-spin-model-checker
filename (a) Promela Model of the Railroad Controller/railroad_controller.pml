mtype = {Red, Green, Idle, Waiting, Bridge}; // Message types

chan requestW = [1] of {bit}; // Request channel for TrainW
chan requestE = [1] of {bit}; // Request channel for TrainE
chan signalW = [1] of {mtype}; // Signal channel for TrainW
chan signalE = [1] of {mtype}; // Signal channel for TrainE

mtype ControllerStateW = Red; // Initial state of the west controller
mtype ControllerStateE = Red; // Initial state of the east controller
mtype TrainStateW = Idle;    // Initial state of TrainW
mtype TrainStateE = Idle;    // Initial state of TrainE

// Controller process
proctype Controller() {
    do
    :: (ControllerStateW == Red && ControllerStateE == Red) ->
        if
        :: requestW?1 -> // TrainW requests access to the bridge
            ControllerStateW = Green;
            signalW!Green;
        :: requestE?1 -> // TrainE requests access to the bridge
            ControllerStateE = Green;
            signalE!Green;
        fi
    :: (ControllerStateW == Green) ->
        if
        :: requestW?0 -> // TrainW releases the bridge
            signalW!Red;
            ControllerStateW = Red;
        fi
    :: (ControllerStateE == Green) ->
        if
        :: requestE?0 -> // TrainE releases the bridge
            signalE!Red;
            ControllerStateE = Red;
        fi
    od
}

// Train process (Parameterized without references)
proctype Train(chan req; chan sig; mtype initialState) {
    mtype state = initialState;
    mtype recvd;
    do
    :: (state == Idle) ->
        req!1;       // Send request to move to Waiting
        state = Waiting;
    :: (state == Waiting) ->
        sig?recvd;   // Receive signal from the controller
        if
        :: (recvd == Green) ->
            state = Bridge; // Move to Bridge
        fi;
    :: (state == Bridge) ->
        req!0;       // Release the bridge
        state = Idle;
    od
}

// Monitor process to ensure safety
active proctype Monitor() {
    do
    :: assert(!((ControllerStateW == Green && ControllerStateE == Green)));
       // Ensure that at most one train is on the bridge at a time
    od
}

// Initialization process
init {
    run Controller();                          // Start the controller process
    run Train(requestW, signalW, Idle);        // Start TrainW process
    run Train(requestE, signalE, Idle);        // Start TrainE process
    run Monitor();                             // Start the monitor process
}

